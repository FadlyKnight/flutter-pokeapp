import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/pokemon_detail.dart';
import 'pokemon_providers.dart';

/// Debounced by the UI before being written to, so this only fires once
/// the user pauses typing.
final searchQueryProvider = StateProvider<String>((ref) => '');

/// Empty query -> no active search (UI shows the regular paginated list).
final searchResultProvider = FutureProvider.autoDispose<PokemonDetail?>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.trim().isEmpty) return null;
  final usecase = ref.watch(searchPokemonProvider);
  return usecase(query);
});
