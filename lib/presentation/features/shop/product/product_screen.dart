import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shoper/presentation/features/shop/product/state.dart';

class ShopItemScreen extends ConsumerWidget {
  const ShopItemScreen({Key? key, required this.productId, required this.name}) : super(key: key);

  final String productId;
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productProvider(productId));
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: Container(
            child: product.when(
                data: (product) => Center(
                      child: Text(product.name),
                    ),
                error: (e, s) => const SizedBox(),
                loading: () => const SizedBox())
            ));
  }
}
