import 'package:dio/dio.dart';

import '../models/ability_detail_model.dart';
import '../models/move_detail_model.dart';
import '../models/pokemon_detail_model.dart';
import '../models/pokemon_model.dart';

abstract class PokemonRemoteDataSource {
  Future<List<PokemonModel>> getPokemonList({required int offset, required int limit});
  Future<PokemonDetailModel> getPokemonDetail(String idOrName);
  Future<MoveDetailModel> getMove(String nameOrId);
  Future<AbilityDetailModel> getAbility(String nameOrId);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  PokemonRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<PokemonModel>> getPokemonList({required int offset, required int limit}) async {
    final listResponse = await _dio.get(
      '/pokemon',
      queryParameters: {'offset': offset, 'limit': limit},
    );
    final results = (listResponse.data['results'] as List).cast<Map<String, dynamic>>();

    // The list endpoint only returns name+url; fetch each detail in
    // parallel to get sprite/type info needed for the card UI.
    final details = await Future.wait(
      results.map((entry) => _dio.get(entry['url'] as String)),
    );

    return details.map((response) => PokemonModel.fromJson(response.data as Map<String, dynamic>)).toList();
  }

  @override
  Future<PokemonDetailModel> getPokemonDetail(String idOrName) async {
    final response = await _dio.get('/pokemon/$idOrName');
    return PokemonDetailModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<MoveDetailModel> getMove(String nameOrId) async {
    final response = await _dio.get('/move/$nameOrId');
    return MoveDetailModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<AbilityDetailModel> getAbility(String nameOrId) async {
    final response = await _dio.get('/ability/$nameOrId');
    return AbilityDetailModel.fromJson(response.data as Map<String, dynamic>);
  }
}
