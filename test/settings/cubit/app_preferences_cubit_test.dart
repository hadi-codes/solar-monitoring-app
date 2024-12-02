// ignore_for_file: avoid_redundant_argument_values

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart' as hydrated_bloc;
import 'package:mocktail/mocktail.dart';
import 'package:monitoring_repository/monitoring_repository.dart';
import 'package:solar_monitor/settings/cubit/cubit.dart';
import 'package:storage/storage.dart';

class MockStorage extends Mock implements Storage {}

class MockHydratedStorage extends Mock
    implements hydrated_bloc.HydratedStorage {}

void main() {
  group('AppPreferencesCubit', () {
    late Storage storage;
    late hydrated_bloc.HydratedStorage hydratedStorage;
    late AppPreferencesCubit cubit;

    setUp(() {
      storage = MockStorage();
      hydratedStorage = MockHydratedStorage();

      when(
        () => hydratedStorage.write(any(), any<dynamic>()),
      ).thenAnswer((_) async {});
      hydrated_bloc.HydratedBloc.storage = hydratedStorage;

      cubit = AppPreferencesCubit(cacheStorage: storage);
    });

    test('initial state is correct', () {
      expect(
        cubit.state,
        equals(
          const AppPreferencesState(
            themeMode: ThemeMode.system,
            monitoringUnit: MonitoringUnit.kilowatts,
            cacheCleared: false,
          ),
        ),
      );
    });

    group('changeThemeMode', () {
      blocTest<AppPreferencesCubit, AppPreferencesState>(
        'emits new state with updated theme mode',
        build: () => cubit,
        seed: () => const AppPreferencesState(
          themeMode: ThemeMode.system,
          monitoringUnit: MonitoringUnit.kilowatts,
          cacheCleared: false,
        ),
        act: (cubit) => cubit.changeThemeMode(ThemeMode.dark),
        expect: () => [
          const AppPreferencesState(
            themeMode: ThemeMode.dark,
            monitoringUnit: MonitoringUnit.kilowatts,
            cacheCleared: false,
          ),
        ],
      );
    });

    group('changeMonitoringUnit', () {
      blocTest<AppPreferencesCubit, AppPreferencesState>(
        'emits new state with updated monitoring unit',
        build: () => cubit,
        seed: () => const AppPreferencesState(
          themeMode: ThemeMode.system,
          monitoringUnit: MonitoringUnit.kilowatts,
          cacheCleared: false,
        ),
        act: (cubit) => cubit.changeMonitoringUnit(MonitoringUnit.watts),
        expect: () => [
          const AppPreferencesState(
            themeMode: ThemeMode.system,
            monitoringUnit: MonitoringUnit.watts,
            cacheCleared: false,
          ),
        ],
      );
    });

    group('clearCache', () {
      blocTest<AppPreferencesCubit, AppPreferencesState>(
        'emits states indicating cache cleared successfully',
        build: () {
          when(() => storage.clear()).thenAnswer((_) async {});
          return cubit;
        },
        act: (cubit) => cubit.clearCache(),
        expect: () => [
          const AppPreferencesState(
            themeMode: ThemeMode.system,
            monitoringUnit: MonitoringUnit.kilowatts,
            cacheCleared: false,
          ),
          const AppPreferencesState(
            themeMode: ThemeMode.system,
            monitoringUnit: MonitoringUnit.kilowatts,
            cacheCleared: true,
          ),
        ],
        verify: (_) {
          verify(() => storage.clear()).called(1);
        },
      );

      blocTest<AppPreferencesCubit, AppPreferencesState>(
        'handles storage clear failure gracefully',
        build: () {
          when(() => storage.clear())
              .thenThrow(const StorageException('Failed to clear'));
          return cubit;
        },
        act: (cubit) => cubit.clearCache(),
        expect: () => [
          const AppPreferencesState(
            themeMode: ThemeMode.system,
            monitoringUnit: MonitoringUnit.kilowatts,
            cacheCleared: false,
          ),
        ],
        verify: (_) {
          verify(() => storage.clear()).called(1);
        },
      );
    });

    group('hydrated bloc', () {
      test('fromJson returns null when json is missing required fields', () {
        expect(
          cubit.fromJson(<String, dynamic>{
            'themeMode': 'invalid_mode',
            'monitoringUnit': 'invalid_unit',
          }),
          isNull,
        );
      });

      test('toJson handles null state gracefully', () {
        when(() => storage.clear()).thenThrow(Exception('Storage error'));
        final json = cubit.toJson(const AppPreferencesState());
        expect(json, isA<Map<String, dynamic>>());
      });

      test('toJson always sets cacheCleared to false', () {
        final json = cubit.toJson(
          const AppPreferencesState(
            themeMode: ThemeMode.dark,
            monitoringUnit: MonitoringUnit.watts,
            cacheCleared: true,
          ),
        );

        expect(json, {
          'themeMode': 'dark',
          'monitoringUnit': 'watts',
          'cacheCleared': false,
        });
      });
    });
  });
}
