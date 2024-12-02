import 'package:equatable/equatable.dart';
import 'package:monitoring_repository/monitoring_repository.dart';
import 'package:solar_monitor_api/solar_monitor_api.dart';

/// {@template monitoring_failure}
/// Base failure for monitoring repository
/// {@endtemplate}
abstract class MonitoringFailure with EquatableMixin implements Exception {
  /// {@macro monitoring_failure}
  const MonitoringFailure(this.error);

  /// The error which was caught
  final Object error;

  @override
  List<Object?> get props => [error];
}

/// {@template fetch_monitoring_data_failure}
/// Failure when fetching monitoring data
/// {@endtemplate}
class FetchMonitoringDataFailure extends MonitoringFailure {
  /// {@macro fetch_monitoring_data_failure}
  const FetchMonitoringDataFailure(super.error);
}

/// {@template monitoring_repository}
/// Monitoring Repository
/// {@endtemplate}
class MonitoringRepository {
  /// {@macro monitoring_repository}
  const MonitoringRepository({
    required SolarMonitorApi solarMonitorApi,
    required MonitoringStorage monitoringStorage,
  })  : _solarMonitorApi = solarMonitorApi,
        _monitoringStorage = monitoringStorage;

  final SolarMonitorApi _solarMonitorApi;
  final MonitoringStorage _monitoringStorage;
  MonitoringApi get _monitoringApi => _solarMonitorApi.getMonitoringApi();

  /// return aggregated monitoring data
  /// for the given [date] and [type]
  /// throws [FetchMonitoringDataFailure] if an error occurs
  Future<List<MonitoringData>> getMonitoringData({
    required DateTime date,
    required MonitoringType type,
    bool forceRefresh = false,
  }) async {
    final formattedDate = '${date.year}-${date.month}-${date.day}';

    if (!forceRefresh) {
      final cachedResult = await _monitoringStorage.getMonitoringData(
        date: formattedDate,
        monitoringType: type.name,
      );

      if (cachedResult != null) return cachedResult;
    }

    try {
      /// simulate network delay
      await Future<void>.delayed(const Duration(seconds: 2));

      final result = await _monitoringApi.monitoringControllerGetMonitoringData(
        date: formattedDate,
        type: type.name,
      );
      final data = result.data?.map(MonitoringData.fromDto).toList() ?? [];

      await _monitoringStorage.setMonitoringData(
        date: formattedDate,
        monitoringType: type.name,
        monitoringData: data,
      );
      return data;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        FetchMonitoringDataFailure(error),
        stackTrace,
      );
    }
  }
}
