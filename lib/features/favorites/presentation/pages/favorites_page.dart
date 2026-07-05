import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_empty_view.dart';
import '../../../pokemon/domain/entities/pokemon.dart';
import '../../../pokemon/presentation/pages/pokemon_detail_page.dart';
import '../../../pokemon/presentation/widgets/pokemon_card.dart';
import '../providers/favorites_provider.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider).values.toList()..sort((a, b) => a.id.compareTo(b.id));

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favorites.isEmpty
          ? const AppEmptyView(message: 'No favorites yet', icon: Icons.favorite_border)
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final favorite = favorites[index];
                final pokemon = Pokemon(
                  id: favorite.id,
                  name: favorite.name,
                  imageUrl: favorite.imageUrl,
                  types: favorite.types,
                );
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
