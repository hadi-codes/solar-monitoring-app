// ignore_for_file: avoid_redundant_argument_values

import 'package:bloc_test/bloc_test.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:monitoring_repository/monitoring_repository.dart';
import 'package:solar_monitor/di/di.dart';
import 'package:solar_monitor/error/error.dart';
import 'package:solar_monitor/monitoring/monitoring.dart';
import 'package:solar_monitor/settings/settings.dart';

import '../../helpers/hydrated_bloc.dart';
import '../../helpers/pump_app.dart';

class MockMonitoringBloc extends MockBloc<MonitoringEvent, MonitoringState>
    implements MonitoringBloc {}

class MockAppPreferencesCubit extends MockCubit<AppPreferencesState>
    implements AppPreferencesCubit {}

void main() {
  late MockMonitoringBloc mockSolarBloc;
  late MockMonitoringBloc mockHouseBloc;
  late MockMonitoringBloc mockBatteryBloc;
  late MockAppPreferencesCubit mockAppPreferencesCubit;

  setUp(() async {
    mockSolarBloc = MockMonitoringBloc();
    mockHouseBloc = MockMonitoringBloc();
    mockBatteryBloc = MockMonitoringBloc();
    mockAppPreferencesCubit = MockAppPreferencesCubit();

    await GetIt.I.reset();
    initHydratedStorage();
    await configureDependencies(environment: Environment.test);

    // Register mocks
    getIt
      ..unregister<MonitoringBloc>()
      ..unregister<AppPreferencesCubit>()
      ..registerFactoryParam<MonitoringBloc, MonitoringType, dynamic>(
        (param1, param2) {
          switch (param1) {
            case MonitoringType.solar:
              return mockSolarBloc;
            case MonitoringType.house:
              return mockHouseBloc;
            case MonitoringType.battery:
              return mockBatteryBloc;
          }
        },
      )
      ..registerFactory<AppPreferencesCubit>(() => mockAppPreferencesCubit);

    registerFallbackValue(const MonitoringEvent.fetch());

    // Setup default states
    when(() => mockAppPreferencesCubit.state).thenReturn(
      const AppPreferencesState(
        monitoringUnit: MonitoringUnit.kilowatts,
      ),
    );

    final defaultState = MonitoringState(
      date: DateTime.now(),
      type: MonitoringType.solar,
    );

    when(() => mockSolarBloc.state).thenReturn(
      defaultState.copyWith(type: MonitoringType.solar),
    );
    when(() => mockHouseBloc.state).thenReturn(
      defaultState.copyWith(type: MonitoringType.house),
    );
    when(() => mockBatteryBloc.state).thenReturn(
      defaultState.copyWith(type: MonitoringType.battery),
    );

    when(() => mockSolarBloc.add(const MonitoringEvent.fetch()))
        .thenReturn(null);
    when(() => mockHouseBloc.add(const MonitoringEvent.fetch()))
        .thenReturn(null);
    when(() => mockBatteryBloc.add(const MonitoringEvent.fetch()))
        .thenReturn(null);
  });

  group('MonitoringPage', () {
    final now = DateTime.now();
    final testMonitoringData = List.generate(
      3,
      (index) => MonitoringData(
        timestamp: now.add(Duration(minutes: index)),
        value: index * 1000,
      ),
    );
    testWidgets('renders MonitoringView', (tester) async {
      await tester.pumpApp(const MonitoringPage());
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(MonitoringView), findsOneWidget);
    });

    testWidgets('shows all three tabs', (tester) async {
      await tester.pumpApp(const MonitoringPage());
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('SOLAR'), findsOneWidget);
      expect(find.text('HOUSE'), findsOneWidget);
      expect(find.text('BATTERY'), findsOneWidget);
    });

    testWidgets('switches between tabs', (tester) async {
      await tester.pumpApp(const MonitoringPage());
      await tester.pump();

      await tester.tap(find.text('HOUSE'));
      await tester.pump();

      await tester.tap(find.text('BATTERY'));
      await tester.pump();
    });

    testWidgets('shows refresh indicator when pulled', (tester) async {
      await tester.pumpApp(const MonitoringPage());
      await tester.pump();

      await tester.drag(
        find.byType(RefreshIndicator),
        const Offset(0, 300),
      );
      await tester.pump();

      verify(() => mockSolarBloc.add(const MonitoringEvent.fetch())).called(1);
    });

    testWidgets('shows error widget when fetch fails', (tester) async {
      when(() => mockSolarBloc.state).thenReturn(
        MonitoringState(
          date: DateTime.now(),
          type: MonitoringType.solar,
          failure: FetchMonitoringDataFailure(Exception('opps')),
          status: FormzSubmissionStatus.failure,
        ),
      );

      await tester.pumpApp(const MonitoringPage());
      await tester.pump();

      expect(find.byType(AppErrorWidget), findsOneWidget);
    });

    testWidgets('shows loading indicator when fetching', (tester) async {
      when(() => mockSolarBloc.state).thenReturn(
        MonitoringState(
          date: DateTime.now(),
          type: MonitoringType.solar,
          status: FormzSubmissionStatus.inProgress,
        ),
      );

      await tester.pumpApp(const MonitoringPage());
      await tester.pump();

      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('shows chart when fetch succeeds', (tester) async {
      when(() => mockSolarBloc.state).thenReturn(
        MonitoringState(
          date: DateTime.now(),
          type: MonitoringType.solar,
          data: testMonitoringData,
          status: FormzSubmissionStatus.success,
        ),
      );

      await tester.pumpApp(const MonitoringPage());
      await tester.pump();

      expect(find.byType(MonitoringChart), findsOneWidget);

      final chart = tester.widget<MonitoringChart>(
        find.byType(MonitoringChart),
      );

      final expectedSpots = testMonitoringData
          .map(
            (data) => FlSpot(
              data.timestamp.millisecondsSinceEpoch.toDouble(),
              data.valueInKilowatts.toDouble(),
            ),
          )
          .toList();
      expect(chart.spots, expectedSpots);
    });

    testWidgets('show chart data with time range', (tester) async {
      final timeRange = (
        testMonitoringData[0].timestamp,
        testMonitoringData[1].timestamp.add(const Duration(minutes: 1))
      );

      when(() => mockSolarBloc.state).thenReturn(
        MonitoringState(
          date: DateTime.now(),
          type: MonitoringType.solar,
          data: testMonitoringData,
          timeRange: timeRange,
          status: FormzSubmissionStatus.success,
        ),
      );

      await tester.pumpApp(const MonitoringPage());
      await tester.pump();

      final chart = tester.widget<MonitoringChart>(
        find.byType(MonitoringChart),
      );

      final expectedSpots = [testMonitoringData[0], testMonitoringData[1]]
          .map(
            (data) => FlSpot(
              data.timestamp.millisecondsSinceEpoch.toDouble(),
              data.valueInKilowatts.toDouble(),
            ),
          )
          .toList();
      expect(chart.spots, expectedSpots);
    });
  });
}
