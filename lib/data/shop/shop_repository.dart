import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shoper/data/auth/user.dart';
import 'package:flutter_shoper/data/model/product.dart';
import 'package:flutter_shoper/data/shop/shop_api_service.dart';

abstract class ShopRepository {
  Future<List<Product>> fetchProducts(User user);

}

final shopRepoProvider = Provider((ref) {
  return ShopRepositoryImpl(ref.watch(shopApiServiceProvider));
});

class ShopRepositoryImpl implements ShopRepository {
  final ShopApiService _shopApiService;

  ShopRepositoryImpl(this._shopApiService);
  @override
  Future<List<Product>> fetchProducts(User user) async {
    final response = await _shopApiService.fetchProducts();
    if (response.statusCode == HttpStatus.ok) {
      return (response.data as List).map<Product>((e) {
        return Product.fromJson(e as Map<String, dynamic>);
      }).toList();
    } else {
      throw Exception('${response.statusCode}, ${response.statusMessage}');
    }
  }
}
