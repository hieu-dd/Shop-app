import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = "/orders_screen";

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderEntities>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) {
          final item = orders.items[i];
          return OrderItem(orderItemEntity: item);
        },
        itemCount: orders.items.length,
      ),
    );
  }
}
