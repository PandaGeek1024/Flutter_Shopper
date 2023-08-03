import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shoper/data/model/product.dart';
import 'package:flutter_shoper/infra/api/api_client.dart';

abstract class ShopApiService {
  Future<Response> fetchProducts();
}

class ShopApiServiceImpl implements ShopApiService {
  final Dio _dio;

  ShopApiServiceImpl(this._dio);

  @override
  Future<Response> fetchProducts() {
    return _dio.get('items');
  }
}

final shopApiServiceProvider =
    Provider<ShopApiService>((ref) => ShopApiServiceImpl(ref.watch(apiClientProvider)));
