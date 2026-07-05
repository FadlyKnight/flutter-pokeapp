import 'package:freezed_annotation/freezed_annotation.dart';

part 'ability_detail.freezed.dart';

@freezed
class AbilityDetail with _$AbilityDetail {
  const factory AbilityDetail({
    required int id,
    required String name,
    required String effect,
    required String generation,
  }) = _AbilityDetail;
}
