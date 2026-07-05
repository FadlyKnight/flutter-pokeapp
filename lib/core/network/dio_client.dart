import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants/api_constants.dart';
import 'retry_interceptor.dart';

/// Builds the single [Dio] instance used to talk to the PokéAPI.
class DioClient {
  DioClient() : dio = Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            connectTimeout: ApiConstants.connectTimeout,
            receiveTimeout: ApiConstants.receiveTimeout,
          ),
        ) {
    dio.interceptors.add(RetryInterceptor(dio));
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(requestBody: false, responseBody: false));
    }
  }

  final Dio dio;
}
