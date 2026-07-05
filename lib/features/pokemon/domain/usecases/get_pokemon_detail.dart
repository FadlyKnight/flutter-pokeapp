import '../entities/pokemon_detail.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonDetail {
  const GetPokemonDetail(this._repository);

  final PokemonRepository _repository;

  Future<PokemonDetail> call(int id) => _repository.getPokemonDetail(id);
}
