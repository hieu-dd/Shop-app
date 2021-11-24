import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop_app/api/product_api.dart';
import 'package:shop_app/providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  String? authToken;

  Products(this.authToken, this._items);

  List<Product> get items {
    return [..._items];
  }

  Future<Response> addProduct(Product product) async {
    final response = await ProductApi(authToken).addProduct(product);
    if (response.statusCode == 200) {
      final id = json.decode(response.body)['name'];
      _items.add(product.copy(id: id));
      notifyListeners();
      return response;
    } else {
      throw ErrorDescription(response.body);
    }
  }

  Future<void> updateProduct(Product product) async {
    final newProduct = await ProductApi(authToken).updateProduct(product);
    final index = _items.indexWhere((element) => element.id == product.id);
    _items[index] = newProduct;
    notifyListeners();
  }

  Future<void> deleteProduct(String productId) async {
    await ProductApi(authToken).deleteProduct(productId);
    _items.removeWhere((element) => element.id == productId);
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> refreshProducts() async {
    try {
      final products = await ProductApi(authToken).getProducts();
      _items = products;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
