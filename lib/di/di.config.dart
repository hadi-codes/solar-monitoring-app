// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:monitoring_repository/monitoring_repository.dart' as _i568;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:solar_monitor_api/solar_monitor_api.dart' as _i594;
import 'package:storage/storage.dart' as _i431;

import '../monitoring/bloc/monitoring_bloc/monitoring_bloc.dart' as _i695;
import '../settings/cubit/app_preferences_cubit/app_preferences_cubit.dart'
    as _i276;
import 'module.dart' as _i946;
import 'test_module.dart' as _i416;

const String _dev = 'dev';
const String _prod = 'prod';
const String _test = 'test';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dIModule = _$DIModule();
    final dITestModule = _$DITestModule();
    gh.singleton<_i594.SolarMonitorApi>(() => dIModule.solarMonitorApi());
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => dIModule.prefs,
      registerFor: {
        _dev,
        _prod,
      },
      preResolve: true,
    );
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => dITestModule.prefs,
      registerFor: {_test},
      preResolve: true,
    );
    gh.singleton<_i431.Storage>(
        () => dIModule.getStorage(gh<_i460.SharedPreferences>()));
    gh.factory<_i276.AppPreferencesCubit>(
        () => _i276.AppPreferencesCubit(cacheStorage: gh<_i431.Storage>()));
    gh.singleton<_i568.MonitoringStorage>(
        () => dIModule.monitoringStorage(gh<_i431.Storage>()));
    gh.singleton<_i568.MonitoringRepository>(
        () => dIModule.monitoringRepository(
              gh<_i594.SolarMonitorApi>(),
              gh<_i568.MonitoringStorage>(),
            ));
    gh.factoryParam<_i695.MonitoringBloc, _i568.MonitoringType?, dynamic>((
      type,
      _,
    ) =>
        _i695.MonitoringBloc(
          monitoringRepository: gh<_i568.MonitoringRepository>(),
          type: type,
        ));
    return this;
  }
}

class _$DIModule extends _i946.DIModule {}

class _$DITestModule extends _i416.DITestModule {}
