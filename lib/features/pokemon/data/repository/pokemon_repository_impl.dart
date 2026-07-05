import 'package:dio/dio.dart';

import '../../../../core/network/app_exceptions.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasource/pokemon_local_datasource.dart';
import '../datasource/pokemon_remote_datasource.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  PokemonRepositoryImpl({
    required PokemonRemoteDataSource remoteDataSource,
    required PokemonLocalDataSource localDataSource,
  })  : _remote = remoteDataSource,
        _local = localDataSource;

  final PokemonRemoteDataSource _remote;
  final PokemonLocalDataSource _local;

  @override
  Future<List<Pokemon>> getPokemonList({required int offset, required int limit}) async {
    final cacheKey = 'list_${offset}_$limit';
    try {
      final models = await _remote.getPokemonList(offset: offset, limit: limit);
      await _local.cachePokemonList(cacheKey, models);
      return models.map((m) => m.toEntity()).toList();
    } on DioException catch (e) {
      final cached = _local.getCachedPokemonList(cacheKey);
      if (cached != null) {
        return cached.map((m) => m.toEntity()).toList();
      }
      throw _mapDioException(e);
    }
  }

  @override
  Future<PokemonDetail> getPokemonDetail(int id) => _getDetail(id.toString());

  @override
  Future<PokemonDetail> getPokemonByName(String name) => _getDetail(name);

  Future<PokemonDetail> _getDetail(String idOrName) async {
    final cacheKey = 'detail_$idOrName';
    try {
      final model = await _remote.getPokemonDetail(idOrName);
      await _local.cachePokemonDetail(cacheKey, model);
      return model.toEntity();
    } on DioException catch (e) {
      final cached = _local.getCachedPokemonDetail(cacheKey);
      if (cached != null) {
        return cached.toEntity();
      }
      throw _mapDioException(e);
    }
  }

  AppException _mapDioException(DioException e) {
    if (e.response?.statusCode == 404) {
      return const NotFoundException();
    }
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const NetworkException();
      default:
        return const ServerException();
    }
  }
}
