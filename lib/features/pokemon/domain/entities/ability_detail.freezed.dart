// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ability_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AbilityDetail {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get effect => throw _privateConstructorUsedError;
  String get generation => throw _privateConstructorUsedError;

  /// Create a copy of AbilityDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AbilityDetailCopyWith<AbilityDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AbilityDetailCopyWith<$Res> {
  factory $AbilityDetailCopyWith(
          AbilityDetail value, $Res Function(AbilityDetail) then) =
      _$AbilityDetailCopyWithImpl<$Res, AbilityDetail>;
  @useResult
  $Res call({int id, String name, String effect, String generation});
}

/// @nodoc
class _$AbilityDetailCopyWithImpl<$Res, $Val extends AbilityDetail>
    implements $AbilityDetailCopyWith<$Res> {
  _$AbilityDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AbilityDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? effect = null,
    Object? generation = null,
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
      effect: null == effect
          ? _value.effect
          : effect // ignore: cast_nullable_to_non_nullable
              as String,
      generation: null == generation
          ? _value.generation
          : generation // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AbilityDetailImplCopyWith<$Res>
    implements $AbilityDetailCopyWith<$Res> {
  factory _$$AbilityDetailImplCopyWith(
          _$AbilityDetailImpl value, $Res Function(_$AbilityDetailImpl) then) =
      __$$AbilityDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String effect, String generation});
}

/// @nodoc
class __$$AbilityDetailImplCopyWithImpl<$Res>
    extends _$AbilityDetailCopyWithImpl<$Res, _$AbilityDetailImpl>
    implements _$$AbilityDetailImplCopyWith<$Res> {
  __$$AbilityDetailImplCopyWithImpl(
      _$AbilityDetailImpl _value, $Res Function(_$AbilityDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of AbilityDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? effect = null,
    Object? generation = null,
  }) {
    return _then(_$AbilityDetailImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      effect: null == effect
          ? _value.effect
          : effect // ignore: cast_nullable_to_non_nullable
              as String,
      generation: null == generation
          ? _value.generation
          : generation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AbilityDetailImpl implements _AbilityDetail {
  const _$AbilityDetailImpl(
      {required this.id,
      required this.name,
      required this.effect,
      required this.generation});

  @override
  final int id;
  @override
  final String name;
  @override
  final String effect;
  @override
  final String generation;

  @override
  String toString() {
    return 'AbilityDetail(id: $id, name: $name, effect: $effect, generation: $generation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AbilityDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.effect, effect) || other.effect == effect) &&
            (identical(other.generation, generation) ||
                other.generation == generation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, effect, generation);

  /// Create a copy of AbilityDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AbilityDetailImplCopyWith<_$AbilityDetailImpl> get copyWith =>
      __$$AbilityDetailImplCopyWithImpl<_$AbilityDetailImpl>(this, _$identity);
}

abstract class _AbilityDetail implements AbilityDetail {
  const factory _AbilityDetail(
      {required final int id,
      required final String name,
      required final String effect,
      required final String generation}) = _$AbilityDetailImpl;

  @override
  int get id;
  @override
  String get name;
  @override
  String get effect;
  @override
  String get generation;

  /// Create a copy of AbilityDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AbilityDetailImplCopyWith<_$AbilityDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
