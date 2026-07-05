import 'dart:convert';

import 'package:hive/hive.dart';

import '../../../../core/constants/hive_constants.dart';
import '../../domain/entities/pokemon_stat.dart';
import '../models/pokemon_detail_model.dart';
import '../models/pokemon_model.dart';

/// Caches raw API responses (as JSON strings) so the list/detail screens
/// keep working offline after a first successful fetch.
abstract class PokemonLocalDataSource {
  Future<void> cachePokemonList(String key, List<PokemonModel> pokemons);
  List<PokemonModel>? getCachedPokemonList(String key);

  Future<void> cachePokemonDetail(String key, PokemonDetailModel detail);
  PokemonDetailModel? getCachedPokemonDetail(String key);
}

class PokemonLocalDataSourceImpl implements PokemonLocalDataSource {
  Box<String> get _listBox => Hive.box<String>(HiveBoxes.pokemonListCache);
  Box<String> get _detailBox => Hive.box<String>(HiveBoxes.pokemonDetailCache);

  @override
  Future<void> cachePokemonList(String key, List<PokemonModel> pokemons) async {
    final raw = pokemons
        .map((p) => {'id': p.id, 'name': p.name, 'imageUrl': p.imageUrl, 'types': p.types})
        .toList();
    await _listBox.put(key, jsonEncode(raw));
  }

  @override
  List<PokemonModel>? getCachedPokemonList(String key) {
    final raw = _listBox.get(key);
    if (raw == null) return null;
    final decoded = jsonDecode(raw) as List;
    return decoded
        .map((e) => PokemonModel(
              id: e['id'] as int,
              name: e['name'] as String,
              imageUrl: e['imageUrl'] as String,
              types: (e['types'] as List).cast<String>(),
            ))
        .toList();
  }

  @override
  Future<void> cachePokemonDetail(String key, PokemonDetailModel detail) async {
    await _detailBox.put(key, jsonEncode(_detailToRaw(detail)));
  }

  @override
  PokemonDetailModel? getCachedPokemonDetail(String key) {
    final raw = _detailBox.get(key);
    if (raw == null) return null;
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return PokemonDetailModel(
      id: decoded['id'] as int,
      name: decoded['name'] as String,
      imageUrl: decoded['imageUrl'] as String,
      types: (decoded['types'] as List).cast<String>(),
      abilities: (decoded['abilities'] as List).cast<String>(),
      heightDecimeters: decoded['heightDecimeters'] as int,
      weightHectograms: decoded['weightHectograms'] as int,
      baseExperience: decoded['baseExperience'] as int,
      stats: (decoded['stats'] as List)
          .map((s) => PokemonStat(name: s['name'] as String, baseStat: s['baseStat'] as int))
          .toList(),
      moves: (decoded['moves'] as List).cast<String>(),
    );
  }

  Map<String, dynamic> _detailToRaw(PokemonDetailModel d) => {
        'id': d.id,
        'name': d.name,
        'imageUrl': d.imageUrl,
        'types': d.types,
        'abilities': d.abilities,
        'heightDecimeters': d.heightDecimeters,
        'weightHectograms': d.weightHectograms,
        'baseExperience': d.baseExperience,
        'stats': d.stats.map((s) => {'name': s.name, 'baseStat': s.baseStat}).toList(),
        'moves': d.moves,
      };
}
