// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'move_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MoveDetail {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get damageClass => throw _privateConstructorUsedError;
  int? get power => throw _privateConstructorUsedError;
  int? get accuracy => throw _privateConstructorUsedError;
  int? get pp => throw _privateConstructorUsedError;
  String get effect => throw _privateConstructorUsedError;

  /// Create a copy of MoveDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MoveDetailCopyWith<MoveDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoveDetailCopyWith<$Res> {
  factory $MoveDetailCopyWith(
          MoveDetail value, $Res Function(MoveDetail) then) =
      _$MoveDetailCopyWithImpl<$Res, MoveDetail>;
  @useResult
  $Res call(
      {int id,
      String name,
      String type,
      String damageClass,
      int? power,
      int? accuracy,
      int? pp,
      String effect});
}

/// @nodoc
class _$MoveDetailCopyWithImpl<$Res, $Val extends MoveDetail>
    implements $MoveDetailCopyWith<$Res> {
  _$MoveDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MoveDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? damageClass = null,
    Object? power = freezed,
    Object? accuracy = freezed,
    Object? pp = freezed,
    Object? effect = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      damageClass: null == damageClass
          ? _value.damageClass
          : damageClass // ignore: cast_nullable_to_non_nullable
              as String,
      power: freezed == power
          ? _value.power
          : power // ignore: cast_nullable_to_non_nullable
              as int?,
      accuracy: freezed == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as int?,
      pp: freezed == pp
          ? _value.pp
          : pp // ignore: cast_nullable_to_non_nullable
              as int?,
      effect: null == effect
          ? _value.effect
          : effect // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MoveDetailImplCopyWith<$Res>
    implements $MoveDetailCopyWith<$Res> {
  factory _$$MoveDetailImplCopyWith(
          _$MoveDetailImpl value, $Res Function(_$MoveDetailImpl) then) =
      __$$MoveDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String type,
      String damageClass,
      int? power,
      int? accuracy,
      int? pp,
      String effect});
}

/// @nodoc
class __$$MoveDetailImplCopyWithImpl<$Res>
    extends _$MoveDetailCopyWithImpl<$Res, _$MoveDetailImpl>
    implements _$$MoveDetailImplCopyWith<$Res> {
  __$$MoveDetailImplCopyWithImpl(
      _$MoveDetailImpl _value, $Res Function(_$MoveDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of MoveDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? damageClass = null,
    Object? power = freezed,
    Object? accuracy = freezed,
    Object? pp = freezed,
    Object? effect = null,
  }) {
    return _then(_$MoveDetailImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      damageClass: null == damageClass
          ? _value.damageClass
          : damageClass // ignore: cast_nullable_to_non_nullable
              as String,
      power: freezed == power
          ? _value.power
          : power // ignore: cast_nullable_to_non_nullable
              as int?,
      accuracy: freezed == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as int?,
      pp: freezed == pp
          ? _value.pp
          : pp // ignore: cast_nullable_to_non_nullable
              as int?,
      effect: null == effect
          ? _value.effect
          : effect // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MoveDetailImpl implements _MoveDetail {
  const _$MoveDetailImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.damageClass,
      this.power,
      this.accuracy,
      this.pp,
      required this.effect});

  @override
  final int id;
  @override
  final String name;
  @override
  final String type;
  @override
  final String damageClass;
  @override
  final int? power;
  @override
  final int? accuracy;
  @override
  final int? pp;
  @override
  final String effect;

  @override
  String toString() {
    return 'MoveDetail(id: $id, name: $name, type: $type, damageClass: $damageClass, power: $power, accuracy: $accuracy, pp: $pp, effect: $effect)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoveDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.damageClass, damageClass) ||
                other.damageClass == damageClass) &&
            (identical(other.power, power) || other.power == power) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.pp, pp) || other.pp == pp) &&
            (identical(other.effect, effect) || other.effect == effect));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, type, damageClass, power, accuracy, pp, effect);

  /// Create a copy of MoveDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MoveDetailImplCopyWith<_$MoveDetailImpl> get copyWith =>
      __$$MoveDetailImplCopyWithImpl<_$MoveDetailImpl>(this, _$identity);
}

abstract class _MoveDetail implements MoveDetail {
  const factory _MoveDetail(
      {required final int id,
      required final String name,
      required final String type,
      required final String damageClass,
      final int? power,
      final int? accuracy,
      final int? pp,
      required final String effect}) = _$MoveDetailImpl;

  @override
  int get id;
  @override
  String get name;
  @override
  String get type;
  @override
  String get damageClass;
  @override
  int? get power;
  @override
  int? get accuracy;
  @override
  int? get pp;
  @override
  String get effect;

  /// Create a copy of MoveDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MoveDetailImplCopyWith<_$MoveDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
