/// Domain-level exceptions. Repositories translate transport errors
/// (Dio, Hive, etc.) into these so the UI never has to interpret raw
/// exception types.
sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException([super.message = 'No internet connection']);
}

class ServerException extends AppException {
  const ServerException([super.message = 'Something went wrong on our end']);
}

class NotFoundException extends AppException {
  const NotFoundException([super.message = 'Pokémon not found']);
}

class CacheException extends AppException {
  const CacheException([super.message = 'No cached data available']);
}
