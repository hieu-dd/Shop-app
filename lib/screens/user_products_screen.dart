import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = "/user-products";

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("User products"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return UserProductItem(
            id: productsData.items[index].id,
            title: productsData.items[index].title,
            imageUrl: productsData.items[index].imageUrl,
          );
        },
        itemCount: productsData.items.length,
      ),
    );
  }
}
