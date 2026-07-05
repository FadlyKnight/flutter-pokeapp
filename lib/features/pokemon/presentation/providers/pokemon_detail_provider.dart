import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/pokemon_detail.dart';
import 'pokemon_providers.dart';

final pokemonDetailProvider = FutureProvider.autoDispose.family<PokemonDetail, int>((ref, id) async {
  final usecase = ref.watch(getPokemonDetailProvider);
  return usecase(id);
});
