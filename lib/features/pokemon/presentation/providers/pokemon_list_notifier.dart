import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/app_exceptions.dart';
import '../../domain/entities/pokemon.dart';
import 'pokemon_providers.dart';

class PokemonListState {
  const PokemonListState({
    this.pokemons = const [],
    this.isLoadingFirstPage = true,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.error,
  });

  final List<Pokemon> pokemons;
  final bool isLoadingFirstPage;
  final bool isLoadingMore;
  final bool hasMore;
  final AppException? error;

  PokemonListState copyWith({
    List<Pokemon>? pokemons,
    bool? isLoadingFirstPage,
    bool? isLoadingMore,
    bool? hasMore,
    AppException? error,
    bool clearError = false,
  }) {
    return PokemonListState(
      pokemons: pokemons ?? this.pokemons,
      isLoadingFirstPage: isLoadingFirstPage ?? this.isLoadingFirstPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Drives the paginated, pull-to-refreshable Pokémon list on the home page.
class PokemonListNotifier extends Notifier<PokemonListState> {
  int _offset = 0;

  @override
  PokemonListState build() {
    Future.microtask(loadFirstPage);
    return const PokemonListState();
  }

  Future<void> loadFirstPage() async {
    _offset = 0;
    state = state.copyWith(isLoadingFirstPage: true, clearError: true);
    try {
      final usecase = ref.read(getPokemonListProvider);
      final pokemons = await usecase(offset: _offset, limit: ApiConstants.pageSize);
      _offset += pokemons.length;
      state = PokemonListState(
        pokemons: pokemons,
        isLoadingFirstPage: false,
        hasMore: pokemons.length == ApiConstants.pageSize,
      );
    } on AppException catch (e) {
      state = state.copyWith(isLoadingFirstPage: false, error: e);
    }
  }

  Future<void> loadNextPage() async {
    if (state.isLoadingMore || state.isLoadingFirstPage || !state.hasMore) return;
    state = state.copyWith(isLoadingMore: true);
    try {
      final usecase = ref.read(getPokemonListProvider);
      final more = await usecase(offset: _offset, limit: ApiConstants.pageSize);
      _offset += more.length;
      state = state.copyWith(
        pokemons: [...state.pokemons, ...more],
        isLoadingMore: false,
        hasMore: more.length == ApiConstants.pageSize,
      );
    } on AppException catch (e) {
      state = state.copyWith(isLoadingMore: false, error: e);
    }
  }

  Future<void> refresh() => loadFirstPage();
}

final pokemonListProvider = NotifierProvider<PokemonListNotifier, PokemonListState>(
  PokemonListNotifier.new,
);
