import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop_app/providers/product.dart';

class Api {
  static const BASE_URL =
      'shop-app-7b3c7-default-rtdb.asia-southeast1.firebasedatabase.app';
  static const PRODUCTS_END_POINT = "/products.json";

  Future<http.Response> addProduct(Product product) {
    final uri = Uri.https(BASE_URL, PRODUCTS_END_POINT);
    return http.post(uri, body: product.encode());
  }

  Future<Product> updateProduct(Product product) async {
    final uri = Uri.https(BASE_URL, "/products/${product.id}.json");
    final response = await http.patch(uri, body: product.encode());
    final data = json.decode(response.body);
    return Product(
      id: product.id,
      title: data['title'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      price: data['price'],
      isFavorite: data['isFavorite'] ?? false,
    );
  }

  Future<void> deleteProduct(productId) async {
    final uri = Uri.https(BASE_URL, "/products/$productId.json");
    final response = await http.delete(uri);
    if (response.statusCode >= 400) {
      throw Exception("Cannot delete $productId");
    }
  }

  Future<List<Product>> getProducts() async {
    final uri = Uri.https(BASE_URL, PRODUCTS_END_POINT);
    final response = await http.get(uri);
    final data = json.decode(response.body) as Map<String, dynamic>;
    final List<Product> products = [];
    data.forEach((key, value) {
      products.add(Product(
        id: key,
        title: value['title'],
        price: value['price'],
        imageUrl: value['imageUrl'],
        description: value['description'],
        isFavorite: value['isFavorite'] ?? false,
      ));
    });
    return products;
  }

  Future<bool> toggleFavorite(String productId, bool isFavorite) async {
    final uri = Uri.https(BASE_URL, "/products/$productId.json");
    final response =
        await http.patch(uri, body: json.encode({'isFavorite': isFavorite}));
    return response.statusCode <= 400;
  }
}
