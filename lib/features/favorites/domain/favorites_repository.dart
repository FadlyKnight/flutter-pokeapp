import 'favorite_pokemon.dart';

abstract class FavoritesRepository {
  List<FavoritePokemon> getAll();
  bool isFavorite(int id);
  Future<void> add(FavoritePokemon pokemon);
  Future<void> remove(int id);
}
