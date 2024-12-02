import 'package:solar_monitor_api/solar_monitor_api.dart';

/// The base URL for the [SolarMonitorApi]
const kSolarApiBaseUrl = String.fromEnvironment(
  'SOLAR_API_BASE_URL',
  defaultValue: 'http://localhost:3001',
);
