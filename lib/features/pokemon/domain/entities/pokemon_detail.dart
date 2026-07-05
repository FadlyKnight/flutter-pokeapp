import 'package:freezed_annotation/freezed_annotation.dart';

import 'pokemon_stat.dart';

part 'pokemon_detail.freezed.dart';

/// Full Pokémon detail shown on the detail screen.
@freezed
class PokemonDetail with _$PokemonDetail {
  const factory PokemonDetail({
    required int id,
    required String name,
    required String imageUrl,
    required List<String> types,
    required List<String> abilities,
    required int heightDecimeters,
    required int weightHectograms,
    required int baseExperience,
    required List<PokemonStat> stats,
    required List<String> moves,
  }) = _PokemonDetail;
}
