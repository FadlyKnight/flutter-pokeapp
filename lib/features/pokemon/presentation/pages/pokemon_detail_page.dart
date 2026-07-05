import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/app_exceptions.dart';
import '../../../../core/utils/string_extensions.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../favorites/domain/favorite_pokemon.dart';
import '../../../favorites/presentation/widgets/favorite_button.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../providers/pokemon_detail_provider.dart';
import '../widgets/stat_bar.dart';
import '../widgets/type_chip.dart';

class PokemonDetailPage extends ConsumerWidget {
  const PokemonDetailPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(pokemonDetailProvider(id));

    return Scaffold(
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => AppErrorView(
          exception: error is AppException ? error : const ServerException(),
          onRetry: () => ref.invalidate(pokemonDetailProvider(id)),
        ),
        data: (detail) => _DetailBody(detail: detail),
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.detail});

  final PokemonDetail detail;

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).colorScheme.primaryContainer;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 260,
          pinned: true,
          backgroundColor: accent,
          actions: [
            FavoriteButton(
              pokemon: FavoritePokemon(
                id: detail.id,
                name: detail.name,
                imageUrl: detail.imageUrl,
                types: detail.types,
              ),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            title: Text(detail.name.capitalize),
            background: Container(
              color: accent,
              padding: const EdgeInsets.only(top: 40),
              child: Hero(
                tag: 'pokemon-${detail.id}',
                child: CachedNetworkImage(
                  imageUrl: detail.imageUrl,
                  fit: BoxFit.contain,
                  errorWidget: (_, __, ___) => const Icon(Icons.image_not_supported_outlined, size: 64),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('#${detail.id.toString().padLeft(3, '0')}', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 8),
                Wrap(spacing: 8, children: detail.types.map((t) => TypeChip(type: t)).toList()),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _Metric(label: 'Height', value: '${detail.heightDecimeters / 10} m'),
                    _Metric(label: 'Weight', value: '${detail.weightHectograms / 10} kg'),
                    _Metric(label: 'Base Exp', value: '${detail.baseExperience}'),
                  ],
                ),
                const SizedBox(height: 20),
                Text('Abilities', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: detail.abilities
                      .map((a) => Chip(label: Text(a.replaceAll('-', ' ').capitalize)))
                      .toList(),
                ),
                const SizedBox(height: 20),
                Text('Stats', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                ...detail.stats.map((s) => StatBar(stat: s)),
                const SizedBox(height: 20),
                Text('Moves', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: detail.moves
                      .take(30)
                      .map((m) => Chip(label: Text(m.replaceAll('-', ' ').capitalize)))
                      .toList(),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
