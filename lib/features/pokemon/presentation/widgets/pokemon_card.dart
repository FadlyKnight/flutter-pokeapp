import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../favorites/domain/favorite_pokemon.dart';
import '../../../favorites/presentation/widgets/favorite_button.dart';
import '../../domain/entities/pokemon.dart';
import 'type_chip.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.pokemon, required this.onTap});

  final Pokemon pokemon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Hero(
                tag: 'pokemon-${pokemon.id}',
                child: CachedNetworkImage(
                  imageUrl: pokemon.imageUrl,
                  width: 72,
                  height: 72,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const SizedBox(
                    width: 72,
                    height: 72,
                    child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.image_not_supported_outlined),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#${pokemon.id.toString().padLeft(3, '0')}',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Text(
                      pokemon.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      children: pokemon.types.map((t) => TypeChip(type: t)).toList(),
                    ),
                  ],
                ),
              ),
              FavoriteButton(
                pokemon: FavoritePokemon(
                  id: pokemon.id,
                  name: pokemon.name,
                  imageUrl: pokemon.imageUrl,
                  types: pokemon.types,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
