import 'package:dio/dio.dart';

/// Retries idempotent GET requests a couple of times with a short backoff
/// before giving up, to smooth over flaky mobile connections.
class RetryInterceptor extends Interceptor {
  RetryInterceptor(this._dio, {this.retries = 2, this.retryDelay = const Duration(milliseconds: 500)});

  final Dio _dio;
  final int retries;
  final Duration retryDelay;

  static const _retryCountKey = 'retry_count';

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final request = err.requestOptions;
    final isGet = request.method == 'GET';
    final shouldRetry = isGet && _isRetryable(err);
    final currentRetryCount = (request.extra[_retryCountKey] as int?) ?? 0;

    if (shouldRetry && currentRetryCount < retries) {
      request.extra[_retryCountKey] = currentRetryCount + 1;
      await Future.delayed(retryDelay * (currentRetryCount + 1));
      try {
        final response = await _dio.fetch(request);
        return handler.resolve(response);
      } on DioException catch (e) {
        return handler.next(e);
      }
    }

    handler.next(err);
  }

  bool _isRetryable(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError;
  }
}
