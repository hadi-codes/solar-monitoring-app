part of 'app_preferences_cubit.dart';

@freezed
class AppPreferencesState with _$AppPreferencesState {
  const factory AppPreferencesState({
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(MonitoringUnit.kilowatts) MonitoringUnit monitoringUnit,
    @Default(false) bool cacheCleared,
  }) = _State;

  factory AppPreferencesState.fromJson(Map<String, dynamic> json) =>
      _$AppPreferencesStateFromJson(json);
}
