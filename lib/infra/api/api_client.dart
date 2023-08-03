import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiClientProvider = Provider((ref) {
  var options = BaseOptions(
    baseUrl: 'https://6337068e5327df4c43cea237.mockapi.io/api/',
  );
  final dioClient = Dio(options);
  // Related to this issue
  // https://stackoverflow.com/questions/67341429/certificate-verify-failed-while-using-dio-3-0-10
  (dioClient.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient dioClient) {
    dioClient.badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);
    return dioClient;
  };
  return dioClient;
});
