import '../../../../core/network/app_exceptions.dart';
import '../entities/pokemon_detail.dart';
import '../repositories/pokemon_repository.dart';

/// Searches by exact name or numeric ID, matching CLAUDE.md's "search by
/// name or ID" requirement. PokéAPI's `/pokemon/{name|id}` endpoint already
/// supports both forms, so this usecase just normalizes the query.
class SearchPokemon {
  const SearchPokemon(this._repository);

  final PokemonRepository _repository;

  Future<PokemonDetail> call(String query) async {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) {
      throw const NotFoundException('Enter a name or Pokédex number');
    }
    return _repository.getPokemonByName(normalized);
  }
}
