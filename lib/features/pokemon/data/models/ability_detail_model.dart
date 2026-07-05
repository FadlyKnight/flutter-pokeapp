import '../../domain/entities/ability_detail.dart';

/// DTO mirroring `GET /ability/{id|name}`.
class AbilityDetailModel {
  const AbilityDetailModel({
    required this.id,
    required this.name,
    required this.effect,
    required this.generation,
  });

  final int id;
  final String name;
  final String effect;
  final String generation;

  factory AbilityDetailModel.fromJson(Map<String, dynamic> json) {
    final effectEntries = json['effect_entries'] as List? ?? const [];
    final englishEntry = effectEntries.cast<Map<String, dynamic>>().firstWhere(
          (e) => (e['language'] as Map<String, dynamic>)['name'] == 'en',
          orElse: () => const {},
        );
    final rawEffect = (englishEntry['short_effect'] ?? englishEntry['effect']) as String?;

    return AbilityDetailModel(
      id: json['id'] as int,
      name: json['name'] as String,
      effect: (rawEffect ?? 'No description available.').replaceAll('\n', ' ').replaceAll('\f', ' '),
      generation: (json['generation'] as Map<String, dynamic>?)?['name'] as String? ?? 'unknown',
    );
  }

  AbilityDetail toEntity() => AbilityDetail(id: id, name: name, effect: effect, generation: generation);
}
