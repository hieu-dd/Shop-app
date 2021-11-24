import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Drawer"),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/");
            },
            child:const ListTile(
              leading: Icon(Icons.shop),
              title: Text("Shops"),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
            child:const ListTile(
              leading: Icon(Icons.payment),
              title: Text("Orders"),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
            child:const ListTile(
              leading: Icon(Icons.supervisor_account),
              title: Text("UserProducts"),
            ),
          ),
        ],
      ),
    );
  }
}
