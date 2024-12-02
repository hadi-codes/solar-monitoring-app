import 'package:test/test.dart';
import 'package:solar_monitor_api/solar_monitor_api.dart';

/// tests for MonitoringApi
void main() {
  final instance = SolarMonitorApi().getMonitoringApi();

  group(MonitoringApi, () {
    // Get aggregated monitoring data
    //
    //Future monitoringControllerGetMonitoringData(String date, String type) async
    test('test monitoringControllerGetMonitoringData', () async {
      // TODO
    });
  });
}
