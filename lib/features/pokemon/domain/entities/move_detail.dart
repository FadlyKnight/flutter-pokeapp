import 'package:freezed_annotation/freezed_annotation.dart';

part 'move_detail.freezed.dart';

@freezed
class MoveDetail with _$MoveDetail {
  const factory MoveDetail({
    required int id,
    required String name,
    required String type,
    required String damageClass,
    int? power,
    int? accuracy,
    int? pp,
    required String effect,
  }) = _MoveDetail;
}
