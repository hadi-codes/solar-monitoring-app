// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:solar_monitor_api/solar_monitor_api.dart';

/// {@template monitoring_unit}
/// Enum representing the unit of the monitoring data
/// {@endtemplate}
enum MonitoringUnit {
  /// Kilowatts
  kilowatts(interval: 1, symbol: 'kW'),

  /// Watts
  watts(interval: 1000, symbol: 'W'),
  ;

  const MonitoringUnit({
    required this.interval,
    required this.symbol,
  });

  /// Scale of the monitoring unit
  final int interval;

  final String symbol;
}

///{@template monitoring_data}
/// Monitoring data model
/// {@endtemplate}
///
class MonitoringData extends Equatable {
  /// {@macro monitoring_data}
  const MonitoringData({
    required this.timestamp,
    required num value,
  }) : _value = value;

  /// Converts a [MonitoringDataDto] into a [MonitoringData]
  factory MonitoringData.fromDto(MonitoringDataDto dto) {
    return MonitoringData(
      timestamp: dto.timestamp,
      value: dto.value,
    );
  }

  /// Timestamp of the monitoring data
  final DateTime timestamp;

  /// Value of the monitoring data
  final num _value;

  /// Value of the monitoring data in watts
  num get valueInWatts => _value;

  /// Value of the monitoring data in kilowatts
  num get valueInKilowatts => _value / 1000;

  /// Converts a [MonitoringData] into a map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'timestamp': timestamp.millisecondsSinceEpoch,
      'value': _value,
    };
  }

  @override
  List<Object?> get props => [timestamp, _value];

  factory MonitoringData.fromMap(Map<String, dynamic> map) {
    return MonitoringData(
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      value: map['value'] as num,
    );
  }
}
