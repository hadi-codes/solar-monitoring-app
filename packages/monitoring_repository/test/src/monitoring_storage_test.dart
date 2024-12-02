import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:monitoring_repository/monitoring_repository.dart';
import 'package:storage/storage.dart';
import 'package:test/test.dart';

class MockStorage extends Mock implements Storage {}

void main() {
  group('MonitoringStorage', () {
    late Storage storage;
    late MonitoringStorage monitoringStorage;

    setUp(() {
      storage = MockStorage();
      monitoringStorage = MonitoringStorage(storage: storage);
    });

    group('setMonitoringData', () {
      test('writes encoded monitoring data to storage', () async {
        const date = '2024-3-20';
        const monitoringType = 'solar';
        final monitoringData = [
          MonitoringData(
            timestamp: DateTime.parse('2024-03-20T10:00:00Z'),
            value: 100,
          ),
        ];

        final expectedKey = MonitoringStorageKeys.monitoringData(
          date: date,
          monitoringType: monitoringType,
        );

        final expectedEncodedData = json.encode([
          {
            'timestamp': '2024-03-20T10:00:00.000Z',
            'value': 100,
          }
        ]);

        when(
          () => storage.write(
            key: expectedKey,
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async {});

        await monitoringStorage.setMonitoringData(
          date: date,
          monitoringType: monitoringType,
          monitoringData: monitoringData,
        );

        verifyNever(
          () => storage.write(
            key: expectedKey,
            value: expectedEncodedData,
          ),
        );
      });
    });

    group('getMonitoringData', () {
      test('returns null when no data exists', () async {
        const timestamp = '2024-3-20';
        const monitoringType = 'solar';

        final expectedKey = MonitoringStorageKeys.monitoringData(
          date: timestamp,
          monitoringType: monitoringType,
        );

        when(() => storage.read(key: expectedKey))
            .thenAnswer((_) async => null);

        final result = await monitoringStorage.getMonitoringData(
          date: timestamp,
          monitoringType: monitoringType,
        );

        expect(result, isNull);
      });

      test('returns decoded monitoring data when exists', () async {
        final timestamp = DateTime(2024, 3, 20);
        const date = '2024-3-20';

        const monitoringType = 'solar';

        final expectedKey = MonitoringStorageKeys.monitoringData(
          date: date,
          monitoringType: monitoringType,
        );

        final storedData = json.encode([
          {
            'timestamp': timestamp.millisecondsSinceEpoch,
            'value': 100,
          }
        ]);

        when(() => storage.read(key: expectedKey))
            .thenAnswer((_) async => storedData);

        final result = await monitoringStorage.getMonitoringData(
          date: date,
          monitoringType: monitoringType,
        );

        expect(result, [
          isA<MonitoringData>()
              .having(
                (m) => m.timestamp,
                'timestamp',
                timestamp,
              )
              .having((m) => m.valueInWatts, 'valueInWatts', 100),
        ]);
      });

      test('throws StorageException when storage read fails', () async {
        const date = '2024-3-20';
        const monitoringType = 'solar';

        final expectedKey = MonitoringStorageKeys.monitoringData(
          date: date,
          monitoringType: monitoringType,
        );

        when(() => storage.read(key: expectedKey))
            .thenThrow(const StorageException('Read failed'));

        expect(
          () => monitoringStorage.getMonitoringData(
            date: date,
            monitoringType: monitoringType,
          ),
          throwsA(isA<StorageException>()),
        );
      });
    });
  });
}
