import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = './product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final productsData = Provider.of<Products>(context);
    final product =
        productsData.items.firstWhere((element) => element.id == productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          GridTileBar(
            backgroundColor: Colors.black54,
            leading: Text(
              "Sku : ${product.id}",
              style: TextStyle(color: Colors.white),
            ),
            title: Text(
              product.title,
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text(
             "\$ ${product.price.toString()}",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
