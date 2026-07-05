import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/app_exceptions.dart';
import '../../../../core/utils/string_extensions.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../domain/entities/ability_detail.dart';
import '../../domain/entities/move_detail.dart';
import '../providers/move_ability_providers.dart';
import 'type_chip.dart';

void showMoveDetailSheet(BuildContext context, String moveName) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => _MoveDetailSheet(moveName: moveName),
  );
}

void showAbilityDetailSheet(BuildContext context, String abilityName) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => _AbilityDetailSheet(abilityName: abilityName),
  );
}

class _MoveDetailSheet extends ConsumerWidget {
  const _MoveDetailSheet({required this.moveName});

  final String moveName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moveAsync = ref.watch(moveDetailProvider(moveName));

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: moveAsync.when(
          loading: () => const SizedBox(
            height: 160,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, _) => SizedBox(
            height: 160,
            child: AppErrorView(
              exception: error is AppException ? error : const ServerException(),
              onRetry: () => ref.invalidate(moveDetailProvider(moveName)),
            ),
          ),
          data: (move) => _MoveContent(move: move),
        ),
      ),
    );
  }
}

class _MoveContent extends StatelessWidget {
  const _MoveContent({required this.move});

  final MoveDetail move;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(move.name.replaceAll('-', ' ').capitalize, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [
            TypeChip(type: move.type),
            Chip(label: Text(move.damageClass.capitalize)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _Stat(label: 'Power', value: move.power?.toString() ?? '—'),
            _Stat(label: 'Accuracy', value: move.accuracy != null ? '${move.accuracy}%' : '—'),
            _Stat(label: 'PP', value: move.pp?.toString() ?? '—'),
          ],
        ),
        const SizedBox(height: 16),
        Text(move.effect, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class _AbilityDetailSheet extends ConsumerWidget {
  const _AbilityDetailSheet({required this.abilityName});

  final String abilityName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final abilityAsync = ref.watch(abilityDetailProvider(abilityName));

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: abilityAsync.when(
          loading: () => const SizedBox(
            height: 140,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, _) => SizedBox(
            height: 140,
            child: AppErrorView(
              exception: error is AppException ? error : const ServerException(),
              onRetry: () => ref.invalidate(abilityDetailProvider(abilityName)),
            ),
          ),
          data: (ability) => _AbilityContent(ability: ability),
        ),
      ),
    );
  }
}

class _AbilityContent extends StatelessWidget {
  const _AbilityContent({required this.ability});

  final AbilityDetail ability;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(ability.name.replaceAll('-', ' ').capitalize, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Chip(label: Text(ability.generation.replaceAll('-', ' ').capitalize)),
        const SizedBox(height: 16),
        Text(ability.effect, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

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
