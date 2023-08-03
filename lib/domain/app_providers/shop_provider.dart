import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shoper/data/auth/authenticator.dart';
import 'package:flutter_shoper/data/model/product.dart';
import 'package:flutter_shoper/data/shop/shop_repository.dart';

final shopProvider = StateNotifierProvider<ShopNotifier, AsyncValue<List<Product>>>(
    (ref) => ShopNotifier(ref.watch(shopRepoProvider), ref.watch(authenticatorProvider.notifier)));

class ShopNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  final Authenticator _authenticator;
  final ShopRepository _shopRepository;

  ShopNotifier(this._shopRepository, this._authenticator) : super(const AsyncLoading()) {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final products = await _shopRepository.fetchProducts(_authenticator.state!);
      state = AsyncData(products);
    } on Exception catch (e, s) {
      state = AsyncError(e, s);
    }
  }
}
