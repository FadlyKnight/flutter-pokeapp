import 'package:flutter/material.dart';

import '../../../../core/utils/string_extensions.dart';
import '../../domain/entities/pokemon_stat.dart';

/// An animated progress indicator for a single base stat, per CLAUDE.md's
/// "Stats should use animated progress indicators" requirement.
class StatBar extends StatelessWidget {
  const StatBar({super.key, required this.stat, this.maxValue = 200});

  final PokemonStat stat;
  final int maxValue;

  @override
  Widget build(BuildContext context) {
    final ratio = (stat.baseStat / maxValue).clamp(0.0, 1.0);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(_label(stat.name), style: Theme.of(context).textTheme.bodySmall),
          ),
          SizedBox(
            width: 32,
            child: Text(
              '${stat.baseStat}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: ratio),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                builder: (context, value, _) => LinearProgressIndicator(
                  value: value,
                  minHeight: 8,
                  backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _label(String statName) => statName.replaceAll('-', ' ').capitalize;
}
