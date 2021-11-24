import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/products_grid.dart';

class ProductOverviewScreen extends StatefulWidget {
  static const routeName = '/product-overview';
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  Future _obtainGetProducts() {
    return Provider.of<Products>(context, listen: false).refreshProducts();
  }

  late Future _getProducts;

  @override
  void initState() {
    _getProducts = _obtainGetProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          title: Text('My shop'),
          actions: [
            Consumer<CartEntity>(
              builder: (_, cart, child) => Badge(
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _getProducts = _obtainGetProducts();
                    });
                    // Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                ),
                color: Colors.black54,
                value: cart.itemCount.toString(),
              ),
            ),
            PopupMenuButton(itemBuilder: (ctx) => []),
          ],
        ),
        body: FutureBuilder<void>(
          future: _getProducts,
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ProductsGrid();
          },
        ));
  }
}
