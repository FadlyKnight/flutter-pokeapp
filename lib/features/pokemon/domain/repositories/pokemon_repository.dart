import '../entities/pokemon.dart';
import '../entities/pokemon_detail.dart';

/// Abstraction the presentation layer depends on; implemented in the data
/// layer so networking/caching details never leak into the UI.
abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemonList({required int offset, required int limit});

  Future<PokemonDetail> getPokemonDetail(int id);

  /// Fetches a single Pokémon by exact name, used by search.
  Future<PokemonDetail> getPokemonByName(String name);
}
