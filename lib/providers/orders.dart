import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';

class OrderItemEntity {
  final String id;
  final List<CartItemEntity> items;
  final double totalPrice;
  final DateTime time;

  OrderItemEntity({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.time,
  });
}

class OrderEntities with ChangeNotifier {
  final List<OrderItemEntity> _items = [];

  List<OrderItemEntity> get items {
    return _items;
  }

  void addOrder(List<CartItemEntity> items, double price) {
    final now = DateTime.now();
    _items.insert(
      0,
      OrderItemEntity(
        id: now.toString(),
        items: items,
        totalPrice: price,
        time: now,
      ),
    );
    notifyListeners();
  }
}
