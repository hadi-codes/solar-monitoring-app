part of 'monitoring_bloc.dart';

@freezed
class MonitoringEvent with _$MonitoringEvent {
  const factory MonitoringEvent.fetch() = _OnFetch;

  const factory MonitoringEvent.dateChanged({
    required DateTime date,
  }) = _OnDateChanged;

  const factory MonitoringEvent.timeRangeChanged({
    MonitoringTimeRange? timeRange,
  }) = _OnTimeRangeChanged;
}
