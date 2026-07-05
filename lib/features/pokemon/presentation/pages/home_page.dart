import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/app_exceptions.dart';
import '../../../../core/utils/debouncer.dart';
import '../../../../core/widgets/app_empty_view.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/shimmer_box.dart';
import '../providers/pokemon_list_notifier.dart';
import '../providers/pokemon_search_provider.dart';
import '../widgets/pokemon_card.dart';
import '../widgets/type_chip.dart';
import 'pokemon_detail_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  final _debouncer = Debouncer();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(pokemonListProvider.notifier).loadNextPage();
    }
  }

  void _onSearchChanged(String value) {
    _debouncer.run(() => ref.read(searchQueryProvider.notifier).state = value);
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(searchQueryProvider);
    final isSearching = query.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('Pokédex')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search by name or Pokédex number...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: isSearching
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(searchQueryProvider.notifier).state = '';
                        },
                      )
                    : null,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(child: isSearching ? const _SearchResults() : const _PokemonList()),
        ],
      ),
    );
  }
}

class _SearchResults extends ConsumerWidget {
  const _SearchResults();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(searchResultProvider);

    return result.when(
      loading: () => ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 3,
        itemBuilder: (_, __) => const PokemonCardShimmer(),
      ),
      error: (error, _) => AppErrorView(
        exception: error is AppException ? error : const ServerException(),
      ),
      data: (detail) {
        if (detail == null) return const SizedBox.shrink();
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => PokemonDetailPage(id: detail.id)),
                ),
                leading: Image.network(detail.imageUrl, width: 56, height: 56, fit: BoxFit.contain),
                title: Text('#${detail.id} ${detail.name}'),
                subtitle: Wrap(spacing: 6, children: detail.types.map((t) => TypeChip(type: t)).toList()),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PokemonList extends ConsumerWidget {
  const _PokemonList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pokemonListProvider);

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
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
