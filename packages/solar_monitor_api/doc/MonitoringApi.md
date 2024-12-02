# solar_monitor_api.api.MonitoringApi

## Load the API package
```dart
import 'package:solar_monitor_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**monitoringControllerGetMonitoringData**](MonitoringApi.md#monitoringcontrollergetmonitoringdata) | **GET** /monitoring | Get aggregated monitoring data


# **monitoringControllerGetMonitoringData**
> BuiltList<MonitoringDataDto> monitoringControllerGetMonitoringData(date, type)

Get aggregated monitoring data

### Example
```dart
import 'package:solar_monitor_api/api.dart';

final api = SolarMonitorApi().getMonitoringApi();
final String date = date_example; // String | Date to fetch data for (YYYY-MM-DD)
final String type = type_example; // String | Type of data (e.g., solar, house, battery)

try {
    final response = api.monitoringControllerGetMonitoringData(date, type);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MonitoringApi->monitoringControllerGetMonitoringData: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **date** | **String**| Date to fetch data for (YYYY-MM-DD) | 
 **type** | **String**| Type of data (e.g., solar, house, battery) | 

### Return type

[**BuiltList&lt;MonitoringDataDto&gt;**](MonitoringDataDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

