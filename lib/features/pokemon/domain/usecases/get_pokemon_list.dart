import '../entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonList {
  const GetPokemonList(this._repository);

  final PokemonRepository _repository;

  Future<List<Pokemon>> call({required int offset, required int limit}) {
    return _repository.getPokemonList(offset: offset, limit: limit);
  }
}
