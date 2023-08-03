import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shoper/data/model/product.dart';
import 'package:flutter_shoper/domain/app_providers/shop_provider.dart';

final productProvider = FutureProvider.autoDispose.family<Product, String>((ref, id) async {
  final product = ref.watch(shopProvider).valueOrNull?.firstWhere((e) => e.id == id);
  return product!;
});