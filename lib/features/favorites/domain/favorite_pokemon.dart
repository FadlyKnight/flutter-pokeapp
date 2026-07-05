import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_pokemon.freezed.dart';

/// Minimal Pokémon snapshot persisted so the favorites list works fully
/// offline without re-hitting the API.
@freezed
class FavoritePokemon with _$FavoritePokemon {
  const factory FavoritePokemon({
    required int id,
    required String name,
    required String imageUrl,
    required List<String> types,
  }) = _FavoritePokemon;
}
