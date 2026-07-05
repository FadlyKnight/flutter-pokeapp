// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_pokemon.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FavoritePokemon {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  List<String> get types => throw _privateConstructorUsedError;

  /// Create a copy of FavoritePokemon
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FavoritePokemonCopyWith<FavoritePokemon> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoritePokemonCopyWith<$Res> {
  factory $FavoritePokemonCopyWith(
          FavoritePokemon value, $Res Function(FavoritePokemon) then) =
      _$FavoritePokemonCopyWithImpl<$Res, FavoritePokemon>;
  @useResult
  $Res call({int id, String name, String imageUrl, List<String> types});
}

/// @nodoc
class _$FavoritePokemonCopyWithImpl<$Res, $Val extends FavoritePokemon>
    implements $FavoritePokemonCopyWith<$Res> {
  _$FavoritePokemonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoritePokemon
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageUrl = null,
    Object? types = null,
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
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      types: null == types
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FavoritePokemonImplCopyWith<$Res>
    implements $FavoritePokemonCopyWith<$Res> {
  factory _$$FavoritePokemonImplCopyWith(_$FavoritePokemonImpl value,
          $Res Function(_$FavoritePokemonImpl) then) =
      __$$FavoritePokemonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String imageUrl, List<String> types});
}

/// @nodoc
class __$$FavoritePokemonImplCopyWithImpl<$Res>
    extends _$FavoritePokemonCopyWithImpl<$Res, _$FavoritePokemonImpl>
    implements _$$FavoritePokemonImplCopyWith<$Res> {
  __$$FavoritePokemonImplCopyWithImpl(
      _$FavoritePokemonImpl _value, $Res Function(_$FavoritePokemonImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoritePokemon
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageUrl = null,
    Object? types = null,
  }) {
    return _then(_$FavoritePokemonImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      types: null == types
          ? _value._types
          : types // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$FavoritePokemonImpl implements _FavoritePokemon {
  const _$FavoritePokemonImpl(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required final List<String> types})
      : _types = types;

  @override
  final int id;
  @override
  final String name;
  @override
  final String imageUrl;
  final List<String> _types;
  @override
  List<String> get types {
    if (_types is EqualUnmodifiableListView) return _types;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_types);
  }

  @override
  String toString() {
    return 'FavoritePokemon(id: $id, name: $name, imageUrl: $imageUrl, types: $types)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoritePokemonImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._types, _types));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, imageUrl,
      const DeepCollectionEquality().hash(_types));

  /// Create a copy of FavoritePokemon
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoritePokemonImplCopyWith<_$FavoritePokemonImpl> get copyWith =>
      __$$FavoritePokemonImplCopyWithImpl<_$FavoritePokemonImpl>(
          this, _$identity);
}

abstract class _FavoritePokemon implements FavoritePokemon {
  const factory _FavoritePokemon(
      {required final int id,
      required final String name,
      required final String imageUrl,
      required final List<String> types}) = _$FavoritePokemonImpl;

  @override
  int get id;
  @override
  String get name;
  @override
  String get imageUrl;
  @override
  List<String> get types;

  /// Create a copy of FavoritePokemon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoritePokemonImplCopyWith<_$FavoritePokemonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
