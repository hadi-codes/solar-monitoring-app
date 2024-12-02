import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart' hide Storage;
import 'package:injectable/injectable.dart';
import 'package:monitoring_repository/monitoring_repository.dart';
import 'package:storage/storage.dart';

part 'app_preferences_state.dart';
part 'app_preferences_cubit.freezed.dart';
part 'app_preferences_cubit.g.dart';

/// A Cubit that manages application preferences including theme mode,
/// monitoring units, and cache management.
/// this extends [HydratedCubit] to support persistence of state
@injectable
class AppPreferencesCubit extends HydratedCubit<AppPreferencesState> {
  AppPreferencesCubit({
    required Storage cacheStorage,
  })  : _cacheStorage = cacheStorage,
        super(const AppPreferencesState());

  final Storage _cacheStorage;

  Future<void> changeMonitoringUnit(MonitoringUnit unit) async {
    emit(state.copyWith(monitoringUnit: unit));
  }

  Future<void> changeThemeMode(ThemeMode mode) async {
    emit(state.copyWith(themeMode: mode));
  }

  Future<void> clearCache() async {
    try {
      emit(state.copyWith(cacheCleared: false));

      await _cacheStorage.clear();
      emit(state.copyWith(cacheCleared: true));
    } catch (e) {
      debugPrint('Error clearing cache: $e');
    }
  }

  @override
  AppPreferencesState? fromJson(Map<String, dynamic> json) {
    try {
      return AppPreferencesState.fromJson(json);
    } catch (e) {
      debugPrint('Error parsing AppPreferencesState: $e');
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AppPreferencesState state) {
    try {
      return state.copyWith(cacheCleared: false).toJson();
    } catch (e) {
      debugPrint('Error serializing AppPreferencesState: $e');
      return null;
    }
  }
}
