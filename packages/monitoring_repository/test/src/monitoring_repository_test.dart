// ignore_for_file: prefer_const_constructors
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:monitoring_repository/monitoring_repository.dart';
import 'package:solar_monitor_api/solar_monitor_api.dart';
import 'package:test/test.dart';

class MockSolarMonitorApi extends Mock implements SolarMonitorApi {}

class MockMonitoringApi extends Mock implements MonitoringApi {}

class MockMonitoringStorage extends Mock implements MonitoringStorage {}

void main() {
  group('MonitoringRepository', () {
    late SolarMonitorApi solarMonitorApi;
    late MonitoringApi monitoringApi;
    late MonitoringStorage monitoringStorage;
    late MonitoringRepository monitoringRepository;

    setUp(() {
      solarMonitorApi = MockSolarMonitorApi();
      monitoringApi = MockMonitoringApi();
      monitoringStorage = MockMonitoringStorage();

      when(() => solarMonitorApi.getMonitoringApi()).thenReturn(monitoringApi);

      monitoringRepository = MonitoringRepository(
        solarMonitorApi: solarMonitorApi,
        monitoringStorage: monitoringStorage,
      );
    });

    group('getMonitoringData', () {
      final testDate = DateTime(2024, 3, 20);
      const formattedDate = '2024-3-20';
      const testType = MonitoringType.battery;

      final mockDto = MonitoringDataDto(
        (b) => b
          ..timestamp = DateTime.parse('2024-03-20T10:00:00Z')
          ..value = 100,
      );

      final mockApiResponse = Response<BuiltList<MonitoringDataDto>>(
        data: BuiltList<MonitoringDataDto>([mockDto]),
        statusCode: 200,
        requestOptions: RequestOptions(path: '/monitoring'),
      );

      final expectedData = [
        MonitoringData(
          timestamp: DateTime.parse('2024-03-20T10:00:00Z'),
          value: 100,
        ),
      ];

      test('returns cached data when available and not forced to refresh',
          () async {
        when(
          () => monitoringStorage.getMonitoringData(
            date: formattedDate,
            monitoringType: testType.name,
          ),
        ).thenAnswer((_) async => expectedData);

        final result = await monitoringRepository.getMonitoringData(
          date: testDate,
          type: testType,
        );

        expect(result, equals(expectedData));
        verifyNever(
          () => monitoringApi.monitoringControllerGetMonitoringData(
            date: any(named: 'date'),
            type: any(named: 'type'),
          ),
        );
      });

      test('fetches from API when cache is empty', () async {
        when(
          () => monitoringStorage.getMonitoringData(
            date: formattedDate,
            monitoringType: testType.name,
          ),
        ).thenAnswer((_) async => null);

        when(
          () => monitoringApi.monitoringControllerGetMonitoringData(
            date: formattedDate,
            type: testType.name,
          ),
        ).thenAnswer((_) async => mockApiResponse);

        when(
          () => monitoringStorage.setMonitoringData(
            date: formattedDate,
            monitoringType: testType.name,
            monitoringData: expectedData,
          ),
        ).thenAnswer((_) async {});

        final result = await monitoringRepository.getMonitoringData(
          date: testDate,
          type: testType,
        );

        expect(result, equals(expectedData));
        verify(
          () => monitoringApi.monitoringControllerGetMonitoringData(
            date: formattedDate,
            type: testType.name,
          ),
        ).called(1);
      });

      test('fetches from API when forceRefresh is true', () async {
        when(
          () => monitoringApi.monitoringControllerGetMonitoringData(
            date: formattedDate,
            type: testType.name,
          ),
        ).thenAnswer((_) async => mockApiResponse);

        when(
          () => monitoringStorage.setMonitoringData(
            date: formattedDate,
            monitoringType: testType.name,
            monitoringData: expectedData,
          ),
        ).thenAnswer((_) async {});

        final result = await monitoringRepository.getMonitoringData(
          date: testDate,
          type: testType,
          forceRefresh: true,
        );

        expect(result, equals(expectedData));
        verify(
          () => monitoringApi.monitoringControllerGetMonitoringData(
            date: formattedDate,
            type: testType.name,
          ),
        ).called(1);
      });

      test('throws FetchMonitoringDataFailure when API call fails', () async {
        when(
          () => monitoringStorage.getMonitoringData(
            date: formattedDate,
            monitoringType: testType.name,
          ),
        ).thenAnswer((_) async => null);

        final dioError = DioException(
          requestOptions: RequestOptions(path: '/monitoring'),
          error: 'API Error',
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: '/monitoring'),
          ),
        );

        when(
          () => monitoringApi.monitoringControllerGetMonitoringData(
            date: any(named: 'date'),
            type: any(named: 'type'),
          ),
        ).thenThrow(dioError);

        expect(
          () => monitoringRepository.getMonitoringData(
            date: testDate,
            type: testType,
          ),
          throwsA(
            isA<FetchMonitoringDataFailure>().having(
              (f) => f.error,
              'error',
              equals(dioError),
            ),
          ),
        );
      });
    });
  });
}
