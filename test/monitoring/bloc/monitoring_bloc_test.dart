// ignore_for_file: avoid_redundant_argument_values

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:monitoring_repository/monitoring_repository.dart';
import 'package:solar_monitor/monitoring/bloc/monitoring_bloc/monitoring_bloc.dart';

class MockMonitoringRepository extends Mock implements MonitoringRepository {}

void main() {
  group('MonitoringBloc', () {
    late MonitoringRepository monitoringRepository;
    late DateTime today;
    late DateTime yesterday;

    setUp(() {
      registerFallbackValue(MonitoringType.solar);

      monitoringRepository = MockMonitoringRepository();
      today = DateTime.now();
      yesterday = today.subtract(const Duration(days: 1));
    });

    MonitoringBloc buildBloc({
      Duration pollingInterval = const Duration(seconds: 5),
      MonitoringType? type,
    }) {
      return MonitoringBloc(
        monitoringRepository: monitoringRepository,
        pollingInterval: pollingInterval,
        type: type,
      );
    }

    test('initial state is correct', () {
      final bloc = buildBloc();
      expect(bloc.state.type, equals(MonitoringType.solar));
      expect(bloc.state.date.day, equals(DateTime.now().day));
      expect(bloc.state.status, equals(FormzSubmissionStatus.initial));
      expect(bloc.state.monitoringData, isEmpty);
      expect(bloc.state.failure, isNull);
    });

    group('MonitoringEvent.fetch', () {
      final mockData = [
        MonitoringData(
          timestamp: DateTime.now(),
          value: 100,
        ),
      ];

      blocTest<MonitoringBloc, MonitoringState>(
        'emits successful state when data is fetched successfully',
        setUp: () {
          when(
            () => monitoringRepository.getMonitoringData(
              date: any(named: 'date'),
              type: any(named: 'type'),
              forceRefresh: any(named: 'forceRefresh'),
            ),
          ).thenAnswer((_) async => mockData);
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const MonitoringEvent.fetch()),
        expect: () => [
          isA<MonitoringState>().having(
            (s) => s.status,
            'status',
            FormzSubmissionStatus.inProgress,
          ),
          isA<MonitoringState>()
              .having((s) => s.status, 'status', FormzSubmissionStatus.success)
              .having((s) => s.monitoringData, 'monitoringData', mockData)
              .having((s) => s.failure, 'failure', isNull),
        ],
        verify: (_) {
          verify(
            () => monitoringRepository.getMonitoringData(
              date: any(named: 'date'),
              type: MonitoringType.solar,
              forceRefresh: false,
            ),
          ).called(1);
        },
      );

      blocTest<MonitoringBloc, MonitoringState>(
        'emits failure state when fetching data fails',
        setUp: () {
          when(
            () => monitoringRepository.getMonitoringData(
              date: any(named: 'date'),
              type: any(named: 'type'),
              forceRefresh: any(named: 'forceRefresh'),
            ),
          ).thenThrow(const FetchMonitoringDataFailure('error'));
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const MonitoringEvent.fetch()),
        expect: () => [
          isA<MonitoringState>().having(
            (s) => s.status,
            'status',
            FormzSubmissionStatus.inProgress,
          ),
          isA<MonitoringState>()
              .having((s) => s.status, 'status', FormzSubmissionStatus.failure)
              .having(
                (s) => s.failure,
                'failure',
                isA<FetchMonitoringDataFailure>(),
              ),
        ],
      );

      blocTest<MonitoringBloc, MonitoringState>(
        "forces refresh when fetching today's data with existing data",
        setUp: () {
          when(
            () => monitoringRepository.getMonitoringData(
              date: any(named: 'date'),
              type: any(named: 'type'),
              forceRefresh: any(named: 'forceRefresh'),
            ),
          ).thenAnswer((_) async => mockData);
        },
        build: buildBloc,
        seed: () => MonitoringState(
          type: MonitoringType.solar,
          date: today,
          data: mockData,
        ),
        act: (bloc) => bloc.add(const MonitoringEvent.fetch()),
        verify: (_) {
          verify(
            () => monitoringRepository.getMonitoringData(
              date: any(named: 'date'),
              type: MonitoringType.solar,
              forceRefresh: true,
            ),
          ).called(1);
        },
      );
    });

    group('MonitoringEvent.dateChanged', () {
      blocTest<MonitoringBloc, MonitoringState>(
        'updates date in state',
        build: buildBloc,
        act: (bloc) => bloc.add(MonitoringEvent.dateChanged(date: yesterday)),
        expect: () => [
          isA<MonitoringState>().having((s) => s.date, 'date', yesterday),
        ],
      );
    });

    group('MonitoringEvent.timeRangeChanged', () {
      final timeRange = (
        DateTime(2024, 1, 1, 8), // 8 AM
        DateTime(2024, 1, 1, 17), // 5 PM
      );

      blocTest<MonitoringBloc, MonitoringState>(
        'updates timeRange in state',
        build: buildBloc,
        act: (bloc) =>
            bloc.add(MonitoringEvent.timeRangeChanged(timeRange: timeRange)),
        expect: () => [
          isA<MonitoringState>()
              .having((s) => s.timeRange, 'timeRange', timeRange),
        ],
      );

      test('filters data based on timeRange', () {
        final bloc = buildBloc();
        final now = DateTime(2024, 1, 1, 12); // noon
        final outside = DateTime(2024, 1, 1, 7); // 7 AM
        final data = [
          MonitoringData(timestamp: now, value: 100),
          MonitoringData(timestamp: outside, value: 200),
        ];

        bloc.emit(
          bloc.state.copyWith(
            data: data,
            timeRange: timeRange,
          ),
        );

        expect(bloc.state.monitoringData, [data.first]);
      });
    });

    test('timer is cancelled on close', () async {
      final bloc =
          buildBloc(pollingInterval: const Duration(milliseconds: 100));
      await bloc.close();
      verifyNever(
        () => monitoringRepository.getMonitoringData(
          date: any(named: 'date'),
          type: any(named: 'type'),
        ),
      );
    });

    group('polling', () {
      late List<MonitoringData> mockData;

      setUp(() {
        mockData = [
          MonitoringData(
            timestamp: DateTime.now(),
            value: 100,
          ),
        ];
      });

      blocTest<MonitoringBloc, MonitoringState>(
        'polls data when date is today',
        setUp: () {
          when(
            () => monitoringRepository.getMonitoringData(
              date: any(named: 'date'),
              type: any(named: 'type'),
              forceRefresh: any(named: 'forceRefresh'),
            ),
          ).thenAnswer((_) async => mockData);
        },
        build: () =>
            buildBloc(pollingInterval: const Duration(milliseconds: 100)),
        act: (bloc) async {
          // Wait for two polling intervals
          await Future<void>.delayed(const Duration(milliseconds: 250));
        },
        expect: () => [
          // First poll
          isA<MonitoringState>().having(
            (s) => s.status,
            'status',
            FormzSubmissionStatus.inProgress,
          ),
          isA<MonitoringState>()
              .having((s) => s.status, 'status', FormzSubmissionStatus.success)
              .having((s) => s.monitoringData, 'monitoringData', mockData),
          // Second poll
          isA<MonitoringState>().having(
            (s) => s.status,
            'status',
            FormzSubmissionStatus.inProgress,
          ),
          isA<MonitoringState>()
              .having((s) => s.status, 'status', FormzSubmissionStatus.success)
              .having((s) => s.monitoringData, 'monitoringData', mockData),
        ],
        verify: (_) {
          verify(
            () => monitoringRepository.getMonitoringData(
              date: any(named: 'date'),
              type: MonitoringType.solar,
              forceRefresh: any(named: 'forceRefresh'),
            ),
          ).called(2);
        },
      );

      blocTest<MonitoringBloc, MonitoringState>(
        'does not poll data when date is not today',
        setUp: () {
          when(
            () => monitoringRepository.getMonitoringData(
              date: any(named: 'date'),
              type: any(named: 'type'),
              forceRefresh: any(named: 'forceRefresh'),
            ),
          ).thenAnswer((_) async => mockData);
        },
        build: () =>
            buildBloc(pollingInterval: const Duration(milliseconds: 100)),
        seed: () => MonitoringState(
          type: MonitoringType.solar,
          date: yesterday,
        ),
        act: (bloc) async {
          // Wait for two polling intervals
          await Future<void>.delayed(const Duration(milliseconds: 250));
        },
        expect: () => <MonitoringState>[], // No state changes expected
        verify: (_) {
          verifyNever(
            () => monitoringRepository.getMonitoringData(
              date: any(named: 'date'),
              type: any(named: 'type'),
              forceRefresh: any(named: 'forceRefresh'),
            ),
          );
        },
      );

      test('polling stops when bloc is closed', () async {
        when(
          () => monitoringRepository.getMonitoringData(
            date: any(named: 'date'),
            type: any(named: 'type'),
            forceRefresh: any(named: 'forceRefresh'),
          ),
        ).thenAnswer((_) async => mockData);

        final bloc =
            buildBloc(pollingInterval: const Duration(milliseconds: 100));

        // Wait for one poll
        await Future<void>.delayed(const Duration(milliseconds: 150));

        // Close the bloc
        await bloc.close();

        // Wait to ensure no more polls occur
        await Future<void>.delayed(const Duration(milliseconds: 150));

        verify(
          () => monitoringRepository.getMonitoringData(
            date: any(named: 'date'),
            type: any(named: 'type'),
            forceRefresh: any(named: 'forceRefresh'),
          ),
        ).called(1); // Only one call should have occurred
      });

      test('polling continues after error', () async {
        var callCount = 0;
        when(
          () => monitoringRepository.getMonitoringData(
            date: any(named: 'date'),
            type: any(named: 'type'),
            forceRefresh: any(named: 'forceRefresh'),
          ),
        ).thenAnswer((_) async {
          callCount++;
          if (callCount == 1) {
            throw const FetchMonitoringDataFailure('error');
          }
          return mockData;
        });

        final bloc =
            buildBloc(pollingInterval: const Duration(milliseconds: 100));

        // Wait for two polls
        await Future<void>.delayed(const Duration(milliseconds: 250));

        expect(
          bloc.state.status,
          equals(FormzSubmissionStatus.success),
          reason: 'Bloc should recover after error and continue polling',
        );
        verify(
          () => monitoringRepository.getMonitoringData(
            date: any(named: 'date'),
            type: any(named: 'type'),
            forceRefresh: any(named: 'forceRefresh'),
          ),
        ).called(2);
      });
    });
  });
}
