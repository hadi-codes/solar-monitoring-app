import 'package:injectable/injectable.dart';
import 'package:monitoring_repository/monitoring_repository.dart';
import 'package:persistent_storage/persistent_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_monitor/constants.dart';
import 'package:solar_monitor_api/solar_monitor_api.dart';
import 'package:storage/storage.dart';

@module
abstract class DIModule {
  @preResolve
  @singleton
  @Environment(Environment.dev)
  @Environment(Environment.prod)
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @singleton
  Storage getStorage(SharedPreferences prefs) {
    return PersistentStorage(sharedPreferences: prefs);
  }

  @singleton
  SolarMonitorApi solarMonitorApi() => SolarMonitorApi(
        basePathOverride: kSolarApiBaseUrl,
      );

  @singleton
  MonitoringStorage monitoringStorage(Storage storage) =>
      MonitoringStorage(storage: storage);

  @singleton
  MonitoringRepository monitoringRepository(
    SolarMonitorApi solarMonitorApi,
    MonitoringStorage monitoringStorage,
  ) =>
      MonitoringRepository(
        monitoringStorage: monitoringStorage,
        solarMonitorApi: solarMonitorApi,
      );
}
