import '../../domain/entities/pokemon.dart';

/// DTO mirroring the shape of `GET /pokemon/{id}`, trimmed to the fields
/// needed for list/search cards. Kept as a plain class (rather than
/// freezed+json_serializable) because the PokéAPI payload is irregular
/// nested JSON that's clearer to parse by hand than to coerce into codegen.
class PokemonModel {
  const PokemonModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
  });

  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    final sprites = json['sprites'] as Map<String, dynamic>? ?? const {};
    final other = sprites['other'] as Map<String, dynamic>? ?? const {};
    final artwork = other['official-artwork'] as Map<String, dynamic>? ?? const {};
    final fallbackImage = sprites['front_default'] as String?;

    final typesJson = json['types'] as List? ?? const [];

    return PokemonModel(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: (artwork['front_default'] as String?) ?? fallbackImage ?? '',
      types: typesJson
          .map((t) => ((t as Map<String, dynamic>)['type'] as Map<String, dynamic>)['name'] as String)
          .toList(),
    );
  }

  Pokemon toEntity() => Pokemon(id: id, name: name, imageUrl: imageUrl, types: types);
}
