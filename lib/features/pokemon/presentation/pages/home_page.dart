import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_empty_view.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/shimmer_box.dart';
import '../providers/pokemon_list_notifier.dart';
import '../widgets/pokemon_card.dart';
import 'pokemon_detail_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(pokemonListProvider.notifier).loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pokemonListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Pokédex')),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(PokemonListState state) {
    if (state.isLoadingFirstPage) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 6,
        itemBuilder: (_, __) => const PokemonCardShimmer(),
      );
    }

    if (state.error != null && state.pokemons.isEmpty) {
      return AppErrorView(
        exception: state.error!,
        onRetry: () => ref.read(pokemonListProvider.notifier).loadFirstPage(),
      );
    }

    if (state.pokemons.isEmpty) {
      return const AppEmptyView(message: 'No Pokémon Found');
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(pokemonListProvider.notifier).refresh(),
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        itemCount: state.pokemons.length + (state.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= state.pokemons.length) {
            return const PokemonCardShimmer();
          }
          final pokemon = state.pokemons[index];
          return PokemonCard(
            pokemon: pokemon,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => PokemonDetailPage(id: pokemon.id)),
            ),
          );
        },
      ),
    );
  }
}
