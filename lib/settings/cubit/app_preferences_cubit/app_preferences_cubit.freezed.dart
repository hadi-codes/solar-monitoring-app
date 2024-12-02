// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_preferences_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppPreferencesState _$AppPreferencesStateFromJson(Map<String, dynamic> json) {
  return _State.fromJson(json);
}

/// @nodoc
mixin _$AppPreferencesState {
  ThemeMode get themeMode => throw _privateConstructorUsedError;
  MonitoringUnit get monitoringUnit => throw _privateConstructorUsedError;
  bool get cacheCleared => throw _privateConstructorUsedError;

  /// Serializes this AppPreferencesState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppPreferencesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppPreferencesStateCopyWith<AppPreferencesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppPreferencesStateCopyWith<$Res> {
  factory $AppPreferencesStateCopyWith(
          AppPreferencesState value, $Res Function(AppPreferencesState) then) =
      _$AppPreferencesStateCopyWithImpl<$Res, AppPreferencesState>;
  @useResult
  $Res call(
      {ThemeMode themeMode, MonitoringUnit monitoringUnit, bool cacheCleared});
}

/// @nodoc
class _$AppPreferencesStateCopyWithImpl<$Res, $Val extends AppPreferencesState>
    implements $AppPreferencesStateCopyWith<$Res> {
  _$AppPreferencesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppPreferencesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? monitoringUnit = null,
    Object? cacheCleared = null,
  }) {
    return _then(_value.copyWith(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      monitoringUnit: null == monitoringUnit
          ? _value.monitoringUnit
          : monitoringUnit // ignore: cast_nullable_to_non_nullable
              as MonitoringUnit,
      cacheCleared: null == cacheCleared
          ? _value.cacheCleared
          : cacheCleared // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StateImplCopyWith<$Res>
    implements $AppPreferencesStateCopyWith<$Res> {
  factory _$$StateImplCopyWith(
          _$StateImpl value, $Res Function(_$StateImpl) then) =
      __$$StateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ThemeMode themeMode, MonitoringUnit monitoringUnit, bool cacheCleared});
}

/// @nodoc
class __$$StateImplCopyWithImpl<$Res>
    extends _$AppPreferencesStateCopyWithImpl<$Res, _$StateImpl>
    implements _$$StateImplCopyWith<$Res> {
  __$$StateImplCopyWithImpl(
      _$StateImpl _value, $Res Function(_$StateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppPreferencesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? monitoringUnit = null,
    Object? cacheCleared = null,
  }) {
    return _then(_$StateImpl(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      monitoringUnit: null == monitoringUnit
          ? _value.monitoringUnit
          : monitoringUnit // ignore: cast_nullable_to_non_nullable
              as MonitoringUnit,
      cacheCleared: null == cacheCleared
          ? _value.cacheCleared
          : cacheCleared // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StateImpl implements _State {
  const _$StateImpl(
      {this.themeMode = ThemeMode.system,
      this.monitoringUnit = MonitoringUnit.kilowatts,
      this.cacheCleared = false});

  factory _$StateImpl.fromJson(Map<String, dynamic> json) =>
      _$$StateImplFromJson(json);

  @override
  @JsonKey()
  final ThemeMode themeMode;
  @override
  @JsonKey()
  final MonitoringUnit monitoringUnit;
  @override
  @JsonKey()
  final bool cacheCleared;

  @override
  String toString() {
    return 'AppPreferencesState(themeMode: $themeMode, monitoringUnit: $monitoringUnit, cacheCleared: $cacheCleared)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StateImpl &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.monitoringUnit, monitoringUnit) ||
                other.monitoringUnit == monitoringUnit) &&
            (identical(other.cacheCleared, cacheCleared) ||
                other.cacheCleared == cacheCleared));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, themeMode, monitoringUnit, cacheCleared);

  /// Create a copy of AppPreferencesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StateImplCopyWith<_$StateImpl> get copyWith =>
      __$$StateImplCopyWithImpl<_$StateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StateImplToJson(
      this,
    );
  }
}

abstract class _State implements AppPreferencesState {
  const factory _State(
      {final ThemeMode themeMode,
      final MonitoringUnit monitoringUnit,
      final bool cacheCleared}) = _$StateImpl;

  factory _State.fromJson(Map<String, dynamic> json) = _$StateImpl.fromJson;

  @override
  ThemeMode get themeMode;
  @override
  MonitoringUnit get monitoringUnit;
  @override
  bool get cacheCleared;

  /// Create a copy of AppPreferencesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StateImplCopyWith<_$StateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
