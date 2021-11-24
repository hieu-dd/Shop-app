import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop_app/api/api.dart';
import 'package:shop_app/providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  Future<Response> addProduct(Product product) async {
    final response = await Api().addProduct(product);
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
    final newProduct = await Api().updateProduct(product);
    final index = _items.indexWhere((element) => element.id == product.id);
    _items[index] = newProduct;
    notifyListeners();
  }

  Future<void> deleteProduct(String productId) async {
    await Api().deleteProduct(productId);
    _items.removeWhere((element) => element.id == productId);
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> refreshProducts() async {
    try {
      final products = await Api().getProducts();
      _items = products;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
