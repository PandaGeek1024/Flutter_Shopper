import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shoper/data/model/product.dart';
import 'package:flutter_shoper/domain/app_providers/shop_provider.dart';


final totalProductsNumberProvider = Provider<AsyncValue<int>>((ref) {
  final products = ref.watch(shopProvider);
  return products.whenData((value) {
    return value.length;
  });
});

final sortedProductsProvider = Provider<AsyncValue<List<Product>>>((ref) {
  return ref.watch(shopProvider).whenData((value) => value);
});
