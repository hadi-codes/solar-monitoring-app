// ignore_for_file: avoid_redundant_argument_values

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:monitoring_repository/monitoring_repository.dart';
import 'package:solar_monitor/di/di.dart';
import 'package:solar_monitor/settings/cubit/cubit.dart';
import 'package:solar_monitor/settings/view/settings_page.dart';

import '../../helpers/hydrated_bloc.dart';
import '../../helpers/pump_app.dart';

class MockAppPreferencesCubit extends MockCubit<AppPreferencesState>
    implements AppPreferencesCubit {}

void main() {
  late MockAppPreferencesCubit mockAppPreferencesCubit;
  setUp(() async {
    mockAppPreferencesCubit = MockAppPreferencesCubit();
    await GetIt.I.reset();

    initHydratedStorage();
    await configureDependencies(environment: Environment.test);
    getIt
      ..unregister<AppPreferencesCubit>()
      ..registerFactory<AppPreferencesCubit>(() => mockAppPreferencesCubit);

    when(() => mockAppPreferencesCubit.state).thenReturn(
      const AppPreferencesState(
        themeMode: ThemeMode.light,
        monitoringUnit: MonitoringUnit.kilowatts,
      ),
    );

    when(
      () => mockAppPreferencesCubit.changeThemeMode(
        ThemeMode.dark,
      ),
    ).thenAnswer(
      (_) => Future<void>.value(),
    );

    when(
      () => mockAppPreferencesCubit.changeMonitoringUnit(
        MonitoringUnit.watts,
      ),
    ).thenAnswer(
      (_) => Future<void>.value(),
    );

    when(() => mockAppPreferencesCubit.clearCache()).thenAnswer(
      (_) => Future<void>.value(),
    );
  });

  group('SettingsPage', () {
    testWidgets('renders SettingsPage', (tester) async {
      await tester.pumpApp(const SettingsPage());

      await tester.pumpAndSettle();

      expect(find.byType(SettingsPage), findsOneWidget);
      expect(find.widgetWithText(AppBar, 'Settings'), findsOneWidget);
    });

    testWidgets('renders theme ListTile with initial value', (tester) async {
      await tester.pumpApp(const SettingsPage());

      await tester.pumpAndSettle();

      expect(find.text('Theme'), findsOneWidget);

      expect(
        find.text(
          'Light',
        ),
        findsOneWidget,
      );
    });

    testWidgets('changes theme mode to dark', (tester) async {
      await tester.pumpApp(const SettingsPage());

      await tester.pumpAndSettle();

      await tester.tap(find.text('Theme'));

      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(
        find.widgetWithText(RadioListTile<ThemeMode>, 'Dark'),
        findsOneWidget,
      );
      expect(
        find.widgetWithText(RadioListTile<ThemeMode>, 'Light'),
        findsOneWidget,
      );

      await tester.tap(find.widgetWithText(RadioListTile<ThemeMode>, 'Dark'));

      await tester.pumpAndSettle(const Duration(seconds: 1));

      verify(() => mockAppPreferencesCubit.changeThemeMode(ThemeMode.dark))
          .called(1);
    });

    testWidgets('renders monitoring unit ListTile with initial value',
        (tester) async {
      await tester.pumpApp(const SettingsPage());

      await tester.pumpAndSettle();

      expect(find.text('Measuring Unit'), findsOneWidget);

      expect(
        find.text(
          'Kilowatts',
        ),
        findsOneWidget,
      );
    });

    testWidgets('changes measuring unit to watt', (tester) async {
      await tester.pumpApp(const SettingsPage());

      await tester.pumpAndSettle();

      await tester.tap(find.text('Measuring Unit'));

      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(
        find.widgetWithText(RadioListTile<MonitoringUnit>, 'Watts'),
        findsOneWidget,
      );

      await tester.tap(
        find.widgetWithText(
          RadioListTile<MonitoringUnit>,
          'Watts',
        ),
      );

      await tester.pumpAndSettle(const Duration(seconds: 1));

      verify(
        () => mockAppPreferencesCubit.changeMonitoringUnit(
          MonitoringUnit.watts,
        ),
      ).called(1);
    });

    testWidgets('clear cache', (tester) async {
      await tester.pumpApp(const SettingsPage());

      await tester.pumpAndSettle();

      await tester.tap(find.text('Clear Cache'));

      await tester.pumpAndSettle(const Duration(seconds: 1));

      await tester.tap(find.text('Clear'));

      await tester.pump(const Duration(seconds: 1));

      verify(() => mockAppPreferencesCubit.clearCache()).called(1);
    });
  });
}
