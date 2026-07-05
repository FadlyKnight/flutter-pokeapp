import '../entities/ability_detail.dart';
import '../repositories/pokemon_repository.dart';

class GetAbilityDetail {
  const GetAbilityDetail(this._repository);

  final PokemonRepository _repository;

  Future<AbilityDetail> call(String name) => _repository.getAbilityDetail(name);
}
