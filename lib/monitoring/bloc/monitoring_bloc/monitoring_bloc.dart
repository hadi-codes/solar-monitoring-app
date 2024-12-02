import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:monitoring_repository/monitoring_repository.dart';
import 'package:solar_monitor/extension/extension.dart';

part 'monitoring_event.dart';
part 'monitoring_state.dart';
part 'monitoring_bloc.freezed.dart';

/// {@template base_monitoring_bloc}
/// A base bloc for monitoring data.
/// {@endtemplate}
abstract class BaseMonitoringBloc
    extends Bloc<MonitoringEvent, MonitoringState> {
  BaseMonitoringBloc(super.initialState);
}

/// these mixins are used to create multiple blocs from a single bloc

/// {@template battery_monitoring_bloc}
/// A bloc for battery monitoring data.
/// {@endtemplate}
mixin BatteryMonitoringBloc on BaseMonitoringBloc {}

/// {@template solar_monitoring_bloc}
/// A bloc for solar monitoring data.
/// {@endtemplate}
mixin SolarMonitoringBloc on BaseMonitoringBloc {}

/// {@template house_monitoring_bloc}
/// A bloc for house monitoring data.
/// {@endtemplate}
mixin HouseMonitoringBloc on BaseMonitoringBloc {}

/// {@template monitoring_bloc}
/// A bloc for monitoring data.
/// {@endtemplate}
@injectable
class MonitoringBloc extends BaseMonitoringBloc
    with BatteryMonitoringBloc, SolarMonitoringBloc, HouseMonitoringBloc {
  MonitoringBloc({
    /// The repository for monitoring data.
    required MonitoringRepository monitoringRepository,

    /// The polling interval for the data.
    @ignoreParam Duration pollingInterval = const Duration(seconds: 5),

    /// The type of monitoring data to fetch.
    @factoryParam MonitoringType? type,
  })  : _monitoringRepository = monitoringRepository,
        super(
          MonitoringState(
            type: type ?? MonitoringType.solar,
            date: DateTime.now(),
          ),
        ) {
    on<_OnFetch>(_onFetch, transformer: restartable());
    on<_OnDateChanged>(_onDateChanged);
    on<_OnTimeRangeChanged>(_onTimeRangeChanged);

    _timer = Timer.periodic(pollingInterval, (_) {
      if (!state.date.isToday) return;
      add(const MonitoringEvent.fetch());
    });
  }
  final MonitoringRepository _monitoringRepository;
  late Timer _timer;

  void _onDateChanged(_OnDateChanged event, Emitter<MonitoringState> emit) {
    emit(
      state.copyWith(
        date: event.date,
      ),
    );
  }

  void _onTimeRangeChanged(
    _OnTimeRangeChanged event,
    Emitter<MonitoringState> emit,
  ) {
    emit(
      state.copyWith(
        timeRange: event.timeRange,
      ),
    );
  }

  Future<void> _onFetch(_OnFetch event, Emitter<MonitoringState> emit) async {
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.inProgress,
      ),
    );

    try {
      /// we are polling the data every x minutes
      /// when the date is today, we will fetch the data from the api
      /// and skip the cache.
      final forceRefresh = state.date.isToday && state.data.isNotEmpty;
      final data = await _monitoringRepository.getMonitoringData(
        date: state.date,
        type: state.type,
        forceRefresh: forceRefresh,
      );
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          data: data.toList(),
          failure: null,
        ),
      );
    } on MonitoringFailure catch (error) {
      addError(error, StackTrace.current);
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          failure: error,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
