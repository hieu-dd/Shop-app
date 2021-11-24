import 'package:flutter/material.dart';

class CartItemEntity {
  String id;
  String productId;
  double quantity;
  String title = '';
  double price = 0.0;

  CartItemEntity({
    required this.id,
    required this.productId,
    this.quantity = 1,
  });

  CartItemEntity copy(double quantity) {
    return CartItemEntity(
      id: id,
      productId: productId,
      quantity: quantity,
    );
  }
}

class CartEntity with ChangeNotifier {
  Map<String, CartItemEntity> _items = {};

  Map<String, CartItemEntity> get items {
    return {..._items};
  }

  void addItem(
    String productId,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (value) => value.copy(
          value.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItemEntity(
          id: DateTime.now().toString(),
          productId: productId,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (_items[productId] == null) {
      return;
    } else if (_items[productId]!.quantity == 1) {
      _items.remove(productId);
    } else {
      _items.update(
        productId,
        (value) => value.copy(
          value.quantity - 1,
        ),
      );
    }
  }

  int get itemCount {
    return _items.length;
  }

  double get grandTotal {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.quantity * cartItem.price;
    });
    return total;
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
