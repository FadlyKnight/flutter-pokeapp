import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/favorites_repository_impl.dart';
import '../../domain/favorite_pokemon.dart';
import '../../domain/favorites_repository.dart';

final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) => FavoritesRepositoryImpl());

/// Holds the current favorites keyed by Pokémon id, kept in memory and
/// mirrored to Hive so any widget (card, detail, favorites page) reacts
/// instantly to a toggle.
class FavoritesNotifier extends Notifier<Map<int, FavoritePokemon>> {
  @override
  Map<int, FavoritePokemon> build() {
    final repo = ref.watch(favoritesRepositoryProvider);
    return {for (final f in repo.getAll()) f.id: f};
  }

  bool isFavorite(int id) => state.containsKey(id);

  Future<void> toggle(FavoritePokemon pokemon) async {
    final repo = ref.read(favoritesRepositoryProvider);
    if (state.containsKey(pokemon.id)) {
      await repo.remove(pokemon.id);
      state = {...state}..remove(pokemon.id);
    } else {
      await repo.add(pokemon);
      state = {...state, pokemon.id: pokemon};
    }
  }
}

final favoritesProvider = NotifierProvider<FavoritesNotifier, Map<int, FavoritePokemon>>(
  FavoritesNotifier.new,
);
