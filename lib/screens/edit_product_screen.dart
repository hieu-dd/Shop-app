import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit-product";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageFocus = FocusNode();
  final _imageController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editProduct = Product(
    id: '',
    title: '',
    description: '',
    imageUrl: '',
    price: 0.0,
  );
  var _isInitState = false;
  var _isLoading = false;

  @override
  void initState() {
    _imageFocus.addListener(_imageListener);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitState) {
      final productId = ModalRoute.of(context)?.settings.arguments as String?;
      if (productId != null) {
        final productsData = Provider.of<Products>(context, listen: false);
        _editProduct = productsData.findById(productId);
        _imageController.text = _editProduct.imageUrl;
      }
      _isInitState = true;
    }
  }

  @override
  void dispose() {
    _imageFocus.removeListener(_imageListener);
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageFocus.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _imageListener() {
    setState(() {});
  }

  void _saveForm() async {
    if (_form.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      _form.currentState?.save();
      final productsData = Provider.of<Products>(context, listen: false);
      if (_editProduct.id.isEmpty) {
        try {
          await productsData.addProduct(_editProduct);
        } catch (error) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
            ),
          );
        }
      } else {
        await productsData.updateProduct(_editProduct);
      }
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit product"),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        label: const Text("Title"),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        return (value?.isEmpty ?? false)
                            ? "Title cannot empty "
                            : null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocus);
                      },
                      onSaved: (title) {
                        _editProduct = _editProduct.copy(title: title);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        label: const Text("Price"),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocus,
                      onSaved: (price) {
                        _editProduct = _editProduct.copy(
                            price: double.tryParse(price ?? ""));
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionFocus);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        label: const Text("Description"),
                      ),
                      textInputAction: TextInputAction.next,
                      focusNode: _descriptionFocus,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_imageFocus);
                      },
                      onSaved: (description) {
                        _editProduct =
                            _editProduct.copy(description: description);
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.only(top: 10, right: 10),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            child: _imageController.text.isEmpty
                                ? Text("Image Url")
                                : FittedBox(
                                    child: Image.network(_imageController.text),
                                  ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              label: const Text("ImageUrl"),
                            ),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageController,
                            onFieldSubmitted: (_) {
                              setState(() {});
                              _saveForm();
                            },
                            onSaved: (imageUrl) {
                              _editProduct =
                                  _editProduct.copy(imageUrl: imageUrl);
                            },
                            focusNode: _imageFocus,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
