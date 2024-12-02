import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:monitoring_repository/monitoring_repository.dart';
import 'package:solar_monitor/app/app.dart';
import 'package:solar_monitor/di/di.dart';
import 'package:solar_monitor/monitoring/monitoring.dart';
import 'package:solar_monitor/settings/view/settings_page.dart';

import '../../helpers/hydrated_bloc.dart';

class MockMonitoringRepository extends Mock implements MonitoringRepository {}

void main() {
  setUp(() async {
    // Reset GetIt before each test
    await GetIt.I.reset();

    // Initialize storage and dependencies
    initHydratedStorage();
    await configureDependencies(environment: Environment.test);
    getIt
      ..unregister<MonitoringRepository>()
      ..registerSingleton<MonitoringRepository>(MockMonitoringRepository());

    registerFallbackValue(MonitoringType.solar);

    when(
      () => getIt<MonitoringRepository>().getMonitoringData(
        date: any(named: 'date'),
        type: any(named: 'type'),
      ),
    ).thenAnswer((_) async => []);
  });

  tearDown(() {
    // Clean up any remaining timers
    WidgetsBinding.instance.resetEpoch();
  });

  group('App', () {
    testWidgets('renders MonitoringPage and SettingsPage', (tester) async {
      // Pump the widget with a frame
      await tester.pumpWidget(const App());

      await tester.pump(const Duration(seconds: 2));

      expect(find.byType(MonitoringPage), findsOneWidget);

      // find settings button by text and tap
      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();

      expect(find.byType(SettingsPage), findsOneWidget);
    });
  });
}
