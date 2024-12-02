// ignore_for_file: avoid_redundant_argument_values

import 'package:bloc_test/bloc_test.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:monitoring_repository/monitoring_repository.dart';
import 'package:solar_monitor/di/di.dart';
import 'package:solar_monitor/monitoring/monitoring.dart';
import 'package:solar_monitor/settings/settings.dart';

import '../../helpers/pump_app.dart';

class MockAppPreferencesCubit extends MockCubit<AppPreferencesState>
    implements AppPreferencesCubit {}

void main() {
  late MockAppPreferencesCubit mockAppPreferencesCubit;

  setUp(() async {
    await GetIt.I.reset();
    await configureDependencies(environment: Environment.test);
    mockAppPreferencesCubit = MockAppPreferencesCubit();

    getIt
      ..unregister<AppPreferencesCubit>()
      ..registerSingleton<AppPreferencesCubit>(mockAppPreferencesCubit);

    when(() => mockAppPreferencesCubit.state).thenReturn(
      const AppPreferencesState(
        monitoringUnit: MonitoringUnit.kilowatts,
      ),
    );
  });

  group('MonitoringChart', () {
    final testSpots = [
      const FlSpot(1000, 1),
      const FlSpot(2000, 2),
      const FlSpot(3000, 3),
    ];

    testWidgets('renders LineChart', (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: MonitoringChart(
            spots: testSpots,
            chartColor: Colors.blue,
          ),
        ),
      );

      expect(find.byType(LineChart), findsOneWidget);
    });

    testWidgets('displays error message when provided', (tester) async {
      const errorText = 'Test Error';
      await tester.pumpApp(
        Scaffold(
          body: MonitoringChart(
            spots: testSpots,
            chartColor: Colors.blue,
            errorText: errorText,
          ),
        ),
      );

      expect(find.text(errorText), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
    });

    testWidgets('does not show error container when no error', (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: MonitoringChart(
            spots: testSpots,
            chartColor: Colors.blue,
          ),
        ),
      );

      expect(find.byIcon(Icons.error), findsNothing);
    });

    testWidgets('handles empty spots list', (tester) async {
      await tester.pumpApp(
        const Scaffold(
          body: MonitoringChart(
            spots: [],
            chartColor: Colors.blue,
          ),
        ),
      );

      expect(find.byType(LineChart), findsOneWidget);
    });

    testWidgets('updates when monitoring unit changes', (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: MonitoringChart(
            spots: testSpots,
            chartColor: Colors.blue,
          ),
        ),
      );

      // Change to watts
      when(() => mockAppPreferencesCubit.state).thenReturn(
        const AppPreferencesState(
          monitoringUnit: MonitoringUnit.watts,
        ),
      );

      await tester.pump();

      // Verify the chart is still rendered
      expect(find.byType(LineChart), findsOneWidget);
    });
  });
}
