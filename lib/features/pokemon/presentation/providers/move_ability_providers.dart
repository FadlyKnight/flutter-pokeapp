import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/ability_detail.dart';
import '../../domain/entities/move_detail.dart';
import 'pokemon_providers.dart';

final moveDetailProvider = FutureProvider.autoDispose.family<MoveDetail, String>((ref, name) async {
  final usecase = ref.watch(getMoveDetailProvider);
  return usecase(name);
});

final abilityDetailProvider = FutureProvider.autoDispose.family<AbilityDetail, String>((ref, name) async {
  final usecase = ref.watch(getAbilityDetailProvider);
  return usecase(name);
});
