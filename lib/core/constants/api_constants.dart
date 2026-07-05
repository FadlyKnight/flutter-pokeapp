/// Endpoints and paging defaults for the PokéAPI.
class ApiConstants {
  const ApiConstants._();

  static const String baseUrl = 'https://pokeapi.co/api/v2';
  static const int pageSize = 20;
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);
}
