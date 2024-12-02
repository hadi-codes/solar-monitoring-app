part of 'monitoring_bloc.dart';

/// {@template monitoring_time_range}
/// A tuple representing a time range with a start and end date.
/// {@endtemplate}
typedef MonitoringTimeRange = (DateTime start, DateTime end);

@freezed
class MonitoringState with _$MonitoringState {
  factory MonitoringState({
    required MonitoringType type,
    required DateTime date,
    MonitoringTimeRange? timeRange,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @protected @Default(<MonitoringData>[]) List<MonitoringData> data,
    MonitoringFailure? failure,
  }) = _State;

  MonitoringState._();

  bool get hasData => data.isNotEmpty;
  bool get hasFailure => failure != null;

  List<MonitoringData> get monitoringData {
    if (timeRange == null) {
      return data;
    }

    return data.where((e) {
      final start = DateTime(
        e.timestamp.year,
        e.timestamp.month,
        e.timestamp.day,
        timeRange!.$1.hour,
        timeRange!.$1.minute,
      );
      final end = DateTime(
        e.timestamp.year,
        e.timestamp.month,
        e.timestamp.day,
        timeRange!.$2.hour,
        timeRange!.$2.minute,
      );
      return e.timestamp.isAfter(start) && e.timestamp.isBefore(end);
    }).toList();
  }
}
