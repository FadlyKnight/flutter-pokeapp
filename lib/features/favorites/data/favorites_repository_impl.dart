import 'dart:convert';

import 'package:hive/hive.dart';

import '../../../core/constants/hive_constants.dart';
import '../domain/favorite_pokemon.dart';
import '../domain/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  Box<String> get _box => Hive.box<String>(HiveBoxes.favorites);

  @override
  List<FavoritePokemon> getAll() {
    return _box.values.map((raw) {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return FavoritePokemon(
        id: json['id'] as int,
        name: json['name'] as String,
        imageUrl: json['imageUrl'] as String,
        types: (json['types'] as List).cast<String>(),
      );
    }).toList()
      ..sort((a, b) => a.id.compareTo(b.id));
  }

  @override
  bool isFavorite(int id) => _box.containsKey(id.toString());

  @override
  Future<void> add(FavoritePokemon pokemon) async {
    await _box.put(
      pokemon.id.toString(),
      jsonEncode({
        'id': pokemon.id,
        'name': pokemon.name,
        'imageUrl': pokemon.imageUrl,
        'types': pokemon.types,
      }),
    );
  }

  @override
  Future<void> remove(int id) async {
    await _box.delete(id.toString());
  }
}
