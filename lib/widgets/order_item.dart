import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/providers/orders.dart';

class OrderItem extends StatelessWidget {
  final OrderItemEntity orderItemEntity;

  const OrderItem({
    Key? key,
    required this.orderItemEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        title: Text(DateFormat("dd MM yy").format(orderItemEntity.time)),
        subtitle: Text(DateFormat("dd/MM/yyyy").format(orderItemEntity.time)),
      ),
    );
  }
}
