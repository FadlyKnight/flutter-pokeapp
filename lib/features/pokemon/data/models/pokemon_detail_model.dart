import '../../domain/entities/pokemon_detail.dart';
import '../../domain/entities/pokemon_stat.dart';

/// DTO mirroring the full `GET /pokemon/{id}` payload.
class PokemonDetailModel {
  const PokemonDetailModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.abilities,
    required this.heightDecimeters,
    required this.weightHectograms,
    required this.baseExperience,
    required this.stats,
    required this.moves,
  });

  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final List<String> abilities;
  final int heightDecimeters;
  final int weightHectograms;
  final int baseExperience;
  final List<PokemonStat> stats;
  final List<String> moves;

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) {
    final sprites = json['sprites'] as Map<String, dynamic>? ?? const {};
    final other = sprites['other'] as Map<String, dynamic>? ?? const {};
    final artwork = other['official-artwork'] as Map<String, dynamic>? ?? const {};
    final fallbackImage = sprites['front_default'] as String?;

    final typesJson = json['types'] as List? ?? const [];
    final abilitiesJson = json['abilities'] as List? ?? const [];
    final statsJson = json['stats'] as List? ?? const [];
    final movesJson = json['moves'] as List? ?? const [];

    return PokemonDetailModel(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: (artwork['front_default'] as String?) ?? fallbackImage ?? '',
      types: typesJson
          .map((t) => ((t as Map<String, dynamic>)['type'] as Map<String, dynamic>)['name'] as String)
          .toList(),
      abilities: abilitiesJson
          .map((a) => ((a as Map<String, dynamic>)['ability'] as Map<String, dynamic>)['name'] as String)
          .toList(),
      heightDecimeters: json['height'] as int,
      weightHectograms: json['weight'] as int,
      baseExperience: json['base_experience'] as int? ?? 0,
      stats: statsJson.map((s) {
        final map = s as Map<String, dynamic>;
        return PokemonStat(
          name: (map['stat'] as Map<String, dynamic>)['name'] as String,
          baseStat: map['base_stat'] as int,
        );
      }).toList(),
      moves: movesJson
          .map((m) => ((m as Map<String, dynamic>)['move'] as Map<String, dynamic>)['name'] as String)
          .toList(),
    );
  }

  PokemonDetail toEntity() => PokemonDetail(
        id: id,
        name: name,
        imageUrl: imageUrl,
        types: types,
        abilities: abilities,
        heightDecimeters: heightDecimeters,
        weightHectograms: weightHectograms,
        baseExperience: baseExperience,
        stats: stats,
        moves: moves,
      );
}
