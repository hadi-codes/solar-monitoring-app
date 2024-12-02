// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monitoring_data_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MonitoringDataDto extends MonitoringDataDto {
  @override
  final DateTime timestamp;
  @override
  final num value;

  factory _$MonitoringDataDto(
          [void Function(MonitoringDataDtoBuilder)? updates]) =>
      (new MonitoringDataDtoBuilder()..update(updates))._build();

  _$MonitoringDataDto._({required this.timestamp, required this.value})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        timestamp, r'MonitoringDataDto', 'timestamp');
    BuiltValueNullFieldError.checkNotNull(value, r'MonitoringDataDto', 'value');
  }

  @override
  MonitoringDataDto rebuild(void Function(MonitoringDataDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MonitoringDataDtoBuilder toBuilder() =>
      new MonitoringDataDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MonitoringDataDto &&
        timestamp == other.timestamp &&
        value == other.value;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, timestamp.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MonitoringDataDto')
          ..add('timestamp', timestamp)
          ..add('value', value))
        .toString();
  }
}

class MonitoringDataDtoBuilder
    implements Builder<MonitoringDataDto, MonitoringDataDtoBuilder> {
  _$MonitoringDataDto? _$v;

  DateTime? _timestamp;
  DateTime? get timestamp => _$this._timestamp;
  set timestamp(DateTime? timestamp) => _$this._timestamp = timestamp;

  num? _value;
  num? get value => _$this._value;
  set value(num? value) => _$this._value = value;

  MonitoringDataDtoBuilder() {
    MonitoringDataDto._defaults(this);
  }

  MonitoringDataDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _timestamp = $v.timestamp;
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MonitoringDataDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MonitoringDataDto;
  }

  @override
  void update(void Function(MonitoringDataDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MonitoringDataDto build() => _build();

  _$MonitoringDataDto _build() {
    final _$result = _$v ??
        new _$MonitoringDataDto._(
            timestamp: BuiltValueNullFieldError.checkNotNull(
                timestamp, r'MonitoringDataDto', 'timestamp'),
            value: BuiltValueNullFieldError.checkNotNull(
                value, r'MonitoringDataDto', 'value'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
