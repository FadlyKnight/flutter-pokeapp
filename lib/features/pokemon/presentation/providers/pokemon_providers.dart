import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/datasource/pokemon_local_datasource.dart';
import '../../data/datasource/pokemon_remote_datasource.dart';
import '../../data/repository/pokemon_repository_impl.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../../domain/usecases/get_ability_detail.dart';
import '../../domain/usecases/get_move_detail.dart';
import '../../domain/usecases/get_pokemon_detail.dart';
import '../../domain/usecases/get_pokemon_list.dart';

final dioProvider = Provider<Dio>((ref) => DioClient().dio);

final pokemonRemoteDataSourceProvider = Provider<PokemonRemoteDataSource>(
  (ref) => PokemonRemoteDataSourceImpl(ref.watch(dioProvider)),
);

final pokemonLocalDataSourceProvider = Provider<PokemonLocalDataSource>(
  (ref) => PokemonLocalDataSourceImpl(),
);

final pokemonRepositoryProvider = Provider<PokemonRepository>(
  (ref) => PokemonRepositoryImpl(
    remoteDataSource: ref.watch(pokemonRemoteDataSourceProvider),
    localDataSource: ref.watch(pokemonLocalDataSourceProvider),
  ),
);

final getPokemonListProvider = Provider((ref) => GetPokemonList(ref.watch(pokemonRepositoryProvider)));
final getPokemonDetailProvider = Provider((ref) => GetPokemonDetail(ref.watch(pokemonRepositoryProvider)));
final getMoveDetailProvider = Provider((ref) => GetMoveDetail(ref.watch(pokemonRepositoryProvider)));
final getAbilityDetailProvider = Provider((ref) => GetAbilityDetail(ref.watch(pokemonRepositoryProvider)));
