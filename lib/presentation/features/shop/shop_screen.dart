import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shoper/presentation/features/shop/shop_state.dart';
import 'package:go_router/go_router.dart';

class ShopScreen extends ConsumerWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(sortedProductsProvider);

    return products.when(
        data: (products) {
          return ListView.separated(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(visualDensity: VisualDensity.compact,
                    title: Text(product.name),
                    subtitle: Text(product.description, maxLines: 1,),
                    // trailing: Column(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    //   Text(product.price.toString()),
                    //   Text(product.amount.toString(), ),
                    // ],),
                    onTap: () {
                      final route = context.namedLocation('product',
                          params: <String, String>{'id': product.id, 'name': product.name});
                      context.go(route);
                    });
              }, separatorBuilder: (BuildContext context, int index) => const Divider(),);
        },
        error: (error, stackTrack) => Text("Some error"),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
