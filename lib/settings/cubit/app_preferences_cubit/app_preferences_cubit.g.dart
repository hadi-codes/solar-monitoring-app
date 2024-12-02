// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_preferences_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StateImpl _$$StateImplFromJson(Map<String, dynamic> json) => _$StateImpl(
      themeMode: $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
          ThemeMode.system,
      monitoringUnit: $enumDecodeNullable(
              _$MonitoringUnitEnumMap, json['monitoringUnit']) ??
          MonitoringUnit.kilowatts,
      cacheCleared: json['cacheCleared'] as bool? ?? false,
    );

Map<String, dynamic> _$$StateImplToJson(_$StateImpl instance) =>
    <String, dynamic>{
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'monitoringUnit': _$MonitoringUnitEnumMap[instance.monitoringUnit]!,
      'cacheCleared': instance.cacheCleared,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};

const _$MonitoringUnitEnumMap = {
  MonitoringUnit.kilowatts: 'kilowatts',
  MonitoringUnit.watts: 'watts',
};
