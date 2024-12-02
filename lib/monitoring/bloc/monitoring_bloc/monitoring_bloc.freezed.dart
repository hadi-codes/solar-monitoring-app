// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'monitoring_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MonitoringEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(DateTime date) dateChanged,
    required TResult Function((DateTime, DateTime)? timeRange) timeRangeChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetch,
    TResult? Function(DateTime date)? dateChanged,
    TResult? Function((DateTime, DateTime)? timeRange)? timeRangeChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(DateTime date)? dateChanged,
    TResult Function((DateTime, DateTime)? timeRange)? timeRangeChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OnFetch value) fetch,
    required TResult Function(_OnDateChanged value) dateChanged,
    required TResult Function(_OnTimeRangeChanged value) timeRangeChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OnFetch value)? fetch,
    TResult? Function(_OnDateChanged value)? dateChanged,
    TResult? Function(_OnTimeRangeChanged value)? timeRangeChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OnFetch value)? fetch,
    TResult Function(_OnDateChanged value)? dateChanged,
    TResult Function(_OnTimeRangeChanged value)? timeRangeChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonitoringEventCopyWith<$Res> {
  factory $MonitoringEventCopyWith(
          MonitoringEvent value, $Res Function(MonitoringEvent) then) =
      _$MonitoringEventCopyWithImpl<$Res, MonitoringEvent>;
}

/// @nodoc
class _$MonitoringEventCopyWithImpl<$Res, $Val extends MonitoringEvent>
    implements $MonitoringEventCopyWith<$Res> {
  _$MonitoringEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonitoringEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$OnFetchImplCopyWith<$Res> {
  factory _$$OnFetchImplCopyWith(
          _$OnFetchImpl value, $Res Function(_$OnFetchImpl) then) =
      __$$OnFetchImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OnFetchImplCopyWithImpl<$Res>
    extends _$MonitoringEventCopyWithImpl<$Res, _$OnFetchImpl>
    implements _$$OnFetchImplCopyWith<$Res> {
  __$$OnFetchImplCopyWithImpl(
      _$OnFetchImpl _value, $Res Function(_$OnFetchImpl) _then)
      : super(_value, _then);

  /// Create a copy of MonitoringEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OnFetchImpl implements _OnFetch {
  const _$OnFetchImpl();

  @override
  String toString() {
    return 'MonitoringEvent.fetch()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OnFetchImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(DateTime date) dateChanged,
    required TResult Function((DateTime, DateTime)? timeRange) timeRangeChanged,
  }) {
    return fetch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetch,
    TResult? Function(DateTime date)? dateChanged,
    TResult? Function((DateTime, DateTime)? timeRange)? timeRangeChanged,
  }) {
    return fetch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(DateTime date)? dateChanged,
    TResult Function((DateTime, DateTime)? timeRange)? timeRangeChanged,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OnFetch value) fetch,
    required TResult Function(_OnDateChanged value) dateChanged,
    required TResult Function(_OnTimeRangeChanged value) timeRangeChanged,
  }) {
    return fetch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OnFetch value)? fetch,
    TResult? Function(_OnDateChanged value)? dateChanged,
    TResult? Function(_OnTimeRangeChanged value)? timeRangeChanged,
  }) {
    return fetch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OnFetch value)? fetch,
    TResult Function(_OnDateChanged value)? dateChanged,
    TResult Function(_OnTimeRangeChanged value)? timeRangeChanged,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(this);
    }
    return orElse();
  }
}

abstract class _OnFetch implements MonitoringEvent {
  const factory _OnFetch() = _$OnFetchImpl;
}

/// @nodoc
abstract class _$$OnDateChangedImplCopyWith<$Res> {
  factory _$$OnDateChangedImplCopyWith(
          _$OnDateChangedImpl value, $Res Function(_$OnDateChangedImpl) then) =
      __$$OnDateChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime date});
}

/// @nodoc
class __$$OnDateChangedImplCopyWithImpl<$Res>
    extends _$MonitoringEventCopyWithImpl<$Res, _$OnDateChangedImpl>
    implements _$$OnDateChangedImplCopyWith<$Res> {
  __$$OnDateChangedImplCopyWithImpl(
      _$OnDateChangedImpl _value, $Res Function(_$OnDateChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of MonitoringEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
  }) {
    return _then(_$OnDateChangedImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$OnDateChangedImpl implements _OnDateChanged {
  const _$OnDateChangedImpl({required this.date});

  @override
  final DateTime date;

  @override
  String toString() {
    return 'MonitoringEvent.dateChanged(date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnDateChangedImpl &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date);

  /// Create a copy of MonitoringEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnDateChangedImplCopyWith<_$OnDateChangedImpl> get copyWith =>
      __$$OnDateChangedImplCopyWithImpl<_$OnDateChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(DateTime date) dateChanged,
    required TResult Function((DateTime, DateTime)? timeRange) timeRangeChanged,
  }) {
    return dateChanged(date);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetch,
    TResult? Function(DateTime date)? dateChanged,
    TResult? Function((DateTime, DateTime)? timeRange)? timeRangeChanged,
  }) {
    return dateChanged?.call(date);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(DateTime date)? dateChanged,
    TResult Function((DateTime, DateTime)? timeRange)? timeRangeChanged,
    required TResult orElse(),
  }) {
    if (dateChanged != null) {
      return dateChanged(date);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OnFetch value) fetch,
    required TResult Function(_OnDateChanged value) dateChanged,
    required TResult Function(_OnTimeRangeChanged value) timeRangeChanged,
  }) {
    return dateChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OnFetch value)? fetch,
    TResult? Function(_OnDateChanged value)? dateChanged,
    TResult? Function(_OnTimeRangeChanged value)? timeRangeChanged,
  }) {
    return dateChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OnFetch value)? fetch,
    TResult Function(_OnDateChanged value)? dateChanged,
    TResult Function(_OnTimeRangeChanged value)? timeRangeChanged,
    required TResult orElse(),
  }) {
    if (dateChanged != null) {
      return dateChanged(this);
    }
    return orElse();
  }
}

abstract class _OnDateChanged implements MonitoringEvent {
  const factory _OnDateChanged({required final DateTime date}) =
      _$OnDateChangedImpl;

  DateTime get date;

  /// Create a copy of MonitoringEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnDateChangedImplCopyWith<_$OnDateChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OnTimeRangeChangedImplCopyWith<$Res> {
  factory _$$OnTimeRangeChangedImplCopyWith(_$OnTimeRangeChangedImpl value,
          $Res Function(_$OnTimeRangeChangedImpl) then) =
      __$$OnTimeRangeChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({(DateTime, DateTime)? timeRange});
}

/// @nodoc
class __$$OnTimeRangeChangedImplCopyWithImpl<$Res>
    extends _$MonitoringEventCopyWithImpl<$Res, _$OnTimeRangeChangedImpl>
    implements _$$OnTimeRangeChangedImplCopyWith<$Res> {
  __$$OnTimeRangeChangedImplCopyWithImpl(_$OnTimeRangeChangedImpl _value,
      $Res Function(_$OnTimeRangeChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of MonitoringEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeRange = freezed,
  }) {
    return _then(_$OnTimeRangeChangedImpl(
      timeRange: freezed == timeRange
          ? _value.timeRange
          : timeRange // ignore: cast_nullable_to_non_nullable
              as (DateTime, DateTime)?,
    ));
  }
}

/// @nodoc

class _$OnTimeRangeChangedImpl implements _OnTimeRangeChanged {
  const _$OnTimeRangeChangedImpl({this.timeRange});

  @override
  final (DateTime, DateTime)? timeRange;

  @override
  String toString() {
    return 'MonitoringEvent.timeRangeChanged(timeRange: $timeRange)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnTimeRangeChangedImpl &&
            (identical(other.timeRange, timeRange) ||
                other.timeRange == timeRange));
  }

  @override
  int get hashCode => Object.hash(runtimeType, timeRange);

  /// Create a copy of MonitoringEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnTimeRangeChangedImplCopyWith<_$OnTimeRangeChangedImpl> get copyWith =>
      __$$OnTimeRangeChangedImplCopyWithImpl<_$OnTimeRangeChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(DateTime date) dateChanged,
    required TResult Function((DateTime, DateTime)? timeRange) timeRangeChanged,
  }) {
    return timeRangeChanged(timeRange);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetch,
    TResult? Function(DateTime date)? dateChanged,
    TResult? Function((DateTime, DateTime)? timeRange)? timeRangeChanged,
  }) {
    return timeRangeChanged?.call(timeRange);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(DateTime date)? dateChanged,
    TResult Function((DateTime, DateTime)? timeRange)? timeRangeChanged,
    required TResult orElse(),
  }) {
    if (timeRangeChanged != null) {
      return timeRangeChanged(timeRange);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OnFetch value) fetch,
    required TResult Function(_OnDateChanged value) dateChanged,
    required TResult Function(_OnTimeRangeChanged value) timeRangeChanged,
  }) {
    return timeRangeChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OnFetch value)? fetch,
    TResult? Function(_OnDateChanged value)? dateChanged,
    TResult? Function(_OnTimeRangeChanged value)? timeRangeChanged,
  }) {
    return timeRangeChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OnFetch value)? fetch,
    TResult Function(_OnDateChanged value)? dateChanged,
    TResult Function(_OnTimeRangeChanged value)? timeRangeChanged,
    required TResult orElse(),
  }) {
    if (timeRangeChanged != null) {
      return timeRangeChanged(this);
    }
    return orElse();
  }
}

abstract class _OnTimeRangeChanged implements MonitoringEvent {
  const factory _OnTimeRangeChanged({final (DateTime, DateTime)? timeRange}) =
      _$OnTimeRangeChangedImpl;

  (DateTime, DateTime)? get timeRange;

  /// Create a copy of MonitoringEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnTimeRangeChangedImplCopyWith<_$OnTimeRangeChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MonitoringState {
  MonitoringType get type => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  (DateTime, DateTime)? get timeRange => throw _privateConstructorUsedError;
  FormzSubmissionStatus get status => throw _privateConstructorUsedError;
  @protected
  List<MonitoringData> get data => throw _privateConstructorUsedError;
  MonitoringFailure? get failure => throw _privateConstructorUsedError;

  /// Create a copy of MonitoringState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonitoringStateCopyWith<MonitoringState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonitoringStateCopyWith<$Res> {
  factory $MonitoringStateCopyWith(
          MonitoringState value, $Res Function(MonitoringState) then) =
      _$MonitoringStateCopyWithImpl<$Res, MonitoringState>;
  @useResult
  $Res call(
      {MonitoringType type,
      DateTime date,
      (DateTime, DateTime)? timeRange,
      FormzSubmissionStatus status,
      @protected List<MonitoringData> data,
      MonitoringFailure? failure});
}

/// @nodoc
class _$MonitoringStateCopyWithImpl<$Res, $Val extends MonitoringState>
    implements $MonitoringStateCopyWith<$Res> {
  _$MonitoringStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonitoringState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? date = null,
    Object? timeRange = freezed,
    Object? status = null,
    Object? data = null,
    Object? failure = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MonitoringType,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeRange: freezed == timeRange
          ? _value.timeRange
          : timeRange // ignore: cast_nullable_to_non_nullable
              as (DateTime, DateTime)?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<MonitoringData>,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as MonitoringFailure?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StateImplCopyWith<$Res>
    implements $MonitoringStateCopyWith<$Res> {
  factory _$$StateImplCopyWith(
          _$StateImpl value, $Res Function(_$StateImpl) then) =
      __$$StateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MonitoringType type,
      DateTime date,
      (DateTime, DateTime)? timeRange,
      FormzSubmissionStatus status,
      @protected List<MonitoringData> data,
      MonitoringFailure? failure});
}

/// @nodoc
class __$$StateImplCopyWithImpl<$Res>
    extends _$MonitoringStateCopyWithImpl<$Res, _$StateImpl>
    implements _$$StateImplCopyWith<$Res> {
  __$$StateImplCopyWithImpl(
      _$StateImpl _value, $Res Function(_$StateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MonitoringState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? date = null,
    Object? timeRange = freezed,
    Object? status = null,
    Object? data = null,
    Object? failure = freezed,
  }) {
    return _then(_$StateImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MonitoringType,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeRange: freezed == timeRange
          ? _value.timeRange
          : timeRange // ignore: cast_nullable_to_non_nullable
              as (DateTime, DateTime)?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<MonitoringData>,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as MonitoringFailure?,
    ));
  }
}

/// @nodoc

class _$StateImpl extends _State {
  _$StateImpl(
      {required this.type,
      required this.date,
      this.timeRange,
      this.status = FormzSubmissionStatus.initial,
      @protected final List<MonitoringData> data = const <MonitoringData>[],
      this.failure})
      : _data = data,
        super._();

  @override
  final MonitoringType type;
  @override
  final DateTime date;
  @override
  final (DateTime, DateTime)? timeRange;
  @override
  @JsonKey()
  final FormzSubmissionStatus status;
  final List<MonitoringData> _data;
  @override
  @JsonKey()
  @protected
  List<MonitoringData> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final MonitoringFailure? failure;

  @override
  String toString() {
    return 'MonitoringState(type: $type, date: $date, timeRange: $timeRange, status: $status, data: $data, failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StateImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.timeRange, timeRange) ||
                other.timeRange == timeRange) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type, date, timeRange, status,
      const DeepCollectionEquality().hash(_data), failure);

  /// Create a copy of MonitoringState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StateImplCopyWith<_$StateImpl> get copyWith =>
      __$$StateImplCopyWithImpl<_$StateImpl>(this, _$identity);
}

abstract class _State extends MonitoringState {
  factory _State(
      {required final MonitoringType type,
      required final DateTime date,
      final (DateTime, DateTime)? timeRange,
      final FormzSubmissionStatus status,
      @protected final List<MonitoringData> data,
      final MonitoringFailure? failure}) = _$StateImpl;
  _State._() : super._();

  @override
  MonitoringType get type;
  @override
  DateTime get date;
  @override
  (DateTime, DateTime)? get timeRange;
  @override
  FormzSubmissionStatus get status;
  @override
  @protected
  List<MonitoringData> get data;
  @override
  MonitoringFailure? get failure;

  /// Create a copy of MonitoringState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StateImplCopyWith<_$StateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
