import '../../domain/entities/move_detail.dart';

/// DTO mirroring `GET /move/{id|name}`.
class MoveDetailModel {
  const MoveDetailModel({
    required this.id,
    required this.name,
    required this.type,
    required this.damageClass,
    required this.power,
    required this.accuracy,
    required this.pp,
    required this.effect,
  });

  final int id;
  final String name;
  final String type;
  final String damageClass;
  final int? power;
  final int? accuracy;
  final int? pp;
  final String effect;

  factory MoveDetailModel.fromJson(Map<String, dynamic> json) {
    final effectEntries = json['effect_entries'] as List? ?? const [];
    final englishEntry = effectEntries.cast<Map<String, dynamic>>().firstWhere(
          (e) => (e['language'] as Map<String, dynamic>)['name'] == 'en',
          orElse: () => const {},
        );
    final rawEffect = (englishEntry['short_effect'] ?? englishEntry['effect']) as String?;

    return MoveDetailModel(
      id: json['id'] as int,
      name: json['name'] as String,
      type: (json['type'] as Map<String, dynamic>)['name'] as String,
      damageClass: (json['damage_class'] as Map<String, dynamic>?)?['name'] as String? ?? 'unknown',
      power: json['power'] as int?,
      accuracy: json['accuracy'] as int?,
      pp: json['pp'] as int?,
      effect: (rawEffect ?? 'No description available.').replaceAll('\n', ' ').replaceAll('\f', ' '),
    );
  }

  MoveDetail toEntity() => MoveDetail(
        id: id,
        name: name,
        type: type,
        damageClass: damageClass,
        power: power,
        accuracy: accuracy,
        pp: pp,
        effect: effect,
      );
}
