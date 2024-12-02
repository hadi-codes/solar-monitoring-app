import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:monitoring_repository/monitoring_repository.dart';
import 'package:solar_monitor/di/di.dart';
import 'package:solar_monitor/error/error.dart';
import 'package:solar_monitor/extension/date_time.dart';
import 'package:solar_monitor/l10n/l10n.dart';
import 'package:solar_monitor/monitoring/monitoring.dart';
import 'package:solar_monitor/settings/settings.dart';
import 'package:solar_monitor/ui/ui.dart';

/// A page that displays monitoring data for solar, house, and battery systems.
///
/// This page consists of three main components:
/// * A tab-based interface to switch between different monitoring types
///  (solar, house, battery)
/// * A date picker to select the time period for monitoring data
/// * Charts displaying the monitoring data for the selected period
///
/// The page uses multiple [BlocProvider]s to manage the state of
/// each monitoring type:
/// * [SolarMonitoringBloc] for solar power monitoring
/// * [HouseMonitoringBloc] for house power consumption
/// * [BatteryMonitoringBloc] for battery status
///
/// Each tab displays a chart with the following features:
/// * Pull-to-refresh functionality to update data
/// * Error handling with retry capability
/// * Support for different units (watts/kilowatts)
/// * Data visualization

class MonitoringPage extends StatelessWidget {
  const MonitoringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SolarMonitoringBloc>(
          lazy: false,
          create: (context) => getIt<MonitoringBloc>(
            param1: MonitoringType.solar,
          )..add(
              const MonitoringEvent.fetch(),
            ),
        ),
        BlocProvider<HouseMonitoringBloc>(
          lazy: false,
          create: (context) => getIt<MonitoringBloc>(
            param1: MonitoringType.house,
          )..add(
              const MonitoringEvent.fetch(),
            ),
        ),
        BlocProvider<BatteryMonitoringBloc>(
          lazy: false,
          create: (context) => getIt<MonitoringBloc>(
            param1: MonitoringType.battery,
          )..add(
              const MonitoringEvent.fetch(),
            ),
        ),
      ],
      child: const MonitoringView(),
    );
  }
}

class MonitoringView extends StatelessWidget {
  const MonitoringView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.monitoringViewAppbarTitle),
          centerTitle: true,
          bottom: TabBar(
            padding: EdgeInsets.zero,
            tabs: MonitoringType.values
                .map(
                  (e) => Tab(
                    text: e.getTranslation(context).toUpperCase(),
                  ),
                )
                .toList(),
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            _MonitoringTab<SolarMonitoringBloc>(),
            _MonitoringTab<HouseMonitoringBloc>(),
            _MonitoringTab<BatteryMonitoringBloc>(),
          ],
        ),
      ),
    );
  }
}

class _MonitoringTab<T extends BaseMonitoringBloc> extends StatefulWidget {
  const _MonitoringTab({super.key});

  @override
  State<_MonitoringTab<T>> createState() => _MonitoringTabState<T>();
}

class _MonitoringTabState<T extends BaseMonitoringBloc>
    extends State<_MonitoringTab<T>> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<T>();
    final state = context.watch<T>().state;
    final chartColor = switch (state.type) {
      MonitoringType.solar => Colors.yellow.shade800,
      MonitoringType.house => Colors.blue,
      MonitoringType.battery => Colors.green,
    };
    final monitoringData = state.monitoringData;
    final hasFailure = state.hasFailure;
    final errorText = hasFailure ? state.failure.getTranslation(context) : null;
    final shouldShowErrorWidget = hasFailure &&
        (monitoringData.isEmpty ||
            !state.date.isSameDay(monitoringData.first.timestamp));

    return RefreshIndicator(
      onRefresh: () async {
        context.read<T>().add(const MonitoringEvent.fetch());
        final future = bloc.stream.firstWhere(
          (state) => !state.status.isInProgress,
        );
        await future;
      },
      child: Column(
        children: [
          _DatePicker<T>(),
          Expanded(
            child: Builder(
              builder: (context) {
                final preferredMonitoringUnit = context.select(
                  (AppPreferencesCubit cubit) => cubit.state.monitoringUnit,
                );
                final spots = monitoringData.map(
                  (e) {
                    final value = switch (preferredMonitoringUnit) {
                      MonitoringUnit.watts => e.valueInWatts,
                      MonitoringUnit.kilowatts => e.valueInKilowatts,
                    }
                        .toDouble();
                    return FlSpot(
                      e.timestamp.millisecondsSinceEpoch.toDouble(),
                      value,
                    );
                  },
                ).toList();

                if (shouldShowErrorWidget) {
                  return AppErrorWidget(
                    message: errorText,
                    onRetry: () => context.read<T>().add(
                          const MonitoringEvent.fetch(),
                        ),
                  );
                }

                return LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: constraints.maxHeight,
                        child: MonitoringChart(
                          spots: spots,
                          chartColor: chartColor,
                          errorText: errorText,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DatePicker<T extends BaseMonitoringBloc> extends StatelessWidget {
  const _DatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<T>();
    final currentDate = context.select(
      (T bloc) => bloc.state.date,
    );
    final selectedTimeRange = context.select(
      (T bloc) => bloc.state.timeRange,
    );

    final isLoading = context.select(
      (T bloc) => bloc.state.status.isInProgress,
    );
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            bottom: AppSpacing.md,
          ),
          alignment: Alignment.topCenter,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 400),
            opacity: isLoading ? 1 : 0,
            child: const LinearProgressIndicator(),
          ),
        ),
        IgnorePointer(
          ignoring: isLoading,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isLoading ? 0.5 : 1,
            child: MonitoringDatePicker(
              currentDate: currentDate,
              selectedTimeRange: selectedTimeRange,
              onDateTimeRangeChanged: (newDateRange) {
                bloc.add(
                  MonitoringEvent.timeRangeChanged(
                    timeRange: newDateRange,
                  ),
                );
              },
              onDateChanged: (newDate) {
                bloc
                  ..add(
                    MonitoringEvent.dateChanged(date: newDate),
                  )
                  ..add(
                    const MonitoringEvent.fetch(),
                  );
              },
            ),
          ),
        ),
      ],
    );
  }
}

extension on MonitoringType {
  String getTranslation(BuildContext context) {
    switch (this) {
      case MonitoringType.solar:
        return context.l10n.solar;
      case MonitoringType.house:
        return context.l10n.house;
      case MonitoringType.battery:
        return context.l10n.battery;
    }
  }
}

extension on MonitoringFailure? {
  String getTranslation(BuildContext context) {
    final l10n = context.l10n;
    return switch (this) {
      FetchMonitoringDataFailure() => l10n.fetchMonitoringDataFailure,
      _ => l10n.unknownError,
    };
  }
}
