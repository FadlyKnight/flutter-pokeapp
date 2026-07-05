import '../entities/move_detail.dart';
import '../repositories/pokemon_repository.dart';

class GetMoveDetail {
  const GetMoveDetail(this._repository);

  final PokemonRepository _repository;

  Future<MoveDetail> call(String name) => _repository.getMoveDetail(name);
}
