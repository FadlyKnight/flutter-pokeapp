import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/favorite_pokemon.dart';
import '../providers/favorites_provider.dart';

class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({super.key, required this.pokemon, this.color});

  final FavoritePokemon pokemon;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoritesProvider.select((favs) => favs.containsKey(pokemon.id)));
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.redAccent : color,
      ),
      tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
      onPressed: () => ref.read(favoritesProvider.notifier).toggle(pokemon),
    );
  }
}
