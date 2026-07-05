import 'package:dio/dio.dart';
import 'package:pokedex/features/pokemon/data/datasource/pokemon_local_datasource.dart';
import 'package:pokedex/features/pokemon/data/datasource/pokemon_remote_datasource.dart';
import 'package:pokedex/features/pokemon/data/models/pokemon_model.dart';
import 'package:pokedex/features/pokemon/data/repository/pokemon_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRemoteDataSource extends Mock implements PokemonRemoteDataSource {}

class _MockLocalDataSource extends Mock implements PokemonLocalDataSource {}

void main() {
  late _MockRemoteDataSource remote;
  late _MockLocalDataSource local;
  late PokemonRepositoryImpl repository;

  setUp(() {
    remote = _MockRemoteDataSource();
    local = _MockLocalDataSource();
    repository = PokemonRepositoryImpl(remoteDataSource: remote, localDataSource: local);
  });

  const bulbasaur = PokemonModel(id: 1, name: 'bulbasaur', imageUrl: 'url', types: ['grass', 'poison']);

  group('getPokemonList', () {
    test('returns entities mapped from the remote datasource and caches them', () async {
      when(() => remote.getPokemonList(offset: 0, limit: 20)).thenAnswer((_) async => [bulbasaur]);
      when(() => local.cachePokemonList(any(), any())).thenAnswer((_) async {});

      final result = await repository.getPokemonList(offset: 0, limit: 20);

      expect(result, hasLength(1));
      expect(result.first.name, 'bulbasaur');
      verify(() => local.cachePokemonList('list_0_20', [bulbasaur])).called(1);
    });

    test('falls back to cached data when the remote call fails', () async {
      when(() => remote.getPokemonList(offset: 0, limit: 20)).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/pokemon'), type: DioExceptionType.connectionError),
      );
      when(() => local.getCachedPokemonList('list_0_20')).thenReturn([bulbasaur]);

      final result = await repository.getPokemonList(offset: 0, limit: 20);

      expect(result, hasLength(1));
      expect(result.first.name, 'bulbasaur');
    });
  });
}
