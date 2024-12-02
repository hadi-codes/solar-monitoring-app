import 'dart:convert';

import 'package:monitoring_repository/monitoring_repository.dart';
import 'package:storage/storage.dart';

/// Storage keys for the [MonitoringStorage].
abstract class MonitoringStorageKeys {
  /// Whether the notifications are enabled.
  static String monitoringData({
    required String date,
    required String monitoringType,
  }) =>
      '__monitoring_data_${monitoringType}_${date}_key__';
}

/// {@template monitoring_storage}
/// Storage for the [MonitoringRepository].
/// {@endtemplate}
class MonitoringStorage {
  /// {@macro monitoring_storage}
  const MonitoringStorage({
    required Storage storage,
  }) : _storage = storage;

  final Storage _storage;

  /// Sets the monitoring data for the given [date] and [monitoringType].
  Future<void> setMonitoringData({
    required String date,
    required String monitoringType,
    required List<MonitoringData> monitoringData,
  }) async {
    final monitoringDataEncoded = json.encode(
      monitoringData.map((data) => data.toMap()).toList(),
    );
    await _storage.write(
      key: MonitoringStorageKeys.monitoringData(
        date: date,
        monitoringType: monitoringType,
      ),
      value: monitoringDataEncoded,
    );
  }

  /// Returns the monitoring data for the given [date] and [monitoringType].
  ///  Returns `null` if no monitoring data is found.
  /// Throws a [StorageException] if the read fails.

  Future<List<MonitoringData>?> getMonitoringData({
    required String date,
    required String monitoringType,
  }) async {
    final monitoringDataEncoded = await _storage.read(
      key: MonitoringStorageKeys.monitoringData(
        date: date,
        monitoringType: monitoringType,
      ),
    );
    if (monitoringDataEncoded == null) return null;
    final monitoringDataDecoded = json.decode(monitoringDataEncoded) as List;
    return monitoringDataDecoded
        .map((data) => MonitoringData.fromMap(data as Map<String, dynamic>))
        .toList();
  }
}
