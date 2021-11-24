import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shop_app/api/api.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.isFavorite = false,
  });

  Future<bool> toggleFavorite() async {
    final isUpdated = await Api().toggleFavorite(id, !isFavorite);
    if (isUpdated) {
      isFavorite = !isFavorite;
      notifyListeners();
    }
    return isUpdated;
  }

  Product copy({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    double? price,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
    );
  }

  String encode() {
    return json.encode({
      'title': title,
      'imageUrl': imageUrl,
      'description': description,
      'price': price,
    });
  }
}
