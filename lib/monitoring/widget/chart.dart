import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:monitoring_repository/monitoring_repository.dart';
import 'package:solar_monitor/settings/settings.dart';
import 'package:solar_monitor/ui/spacing/spacing.dart';
import 'package:solar_monitor/ui/ui.dart';

/// {@template empty_axis_titles}
/// A set of empty axis titles for the chart.
/// This used to make chart center aligned.
/// {@endtemplate}
final _emptyAxisTitles = AxisTitles(
  sideTitles: SideTitles(
    showTitles: true,
    reservedSize: AppSpacing.xlg,
    getTitlesWidget: (value, meta) => const SizedBox.shrink(),
  ),
);

/// A widget that displays power monitoring data as a line chart.
///
/// The chart shows power consumption/generation over time, with customizable units
/// (watts or kilowatts) based on user preferences. It includes:
/// * A line graph with a filled area below the line
/// * Interactive tooltips showing exact values and timestamps
/// * Customizable error state display
/// * Automatic scaling based on data points
/// * Time-based X-axis with hour:minute formatting
/// * Unit-aware Y-axis with appropriate intervals
///
/// Example:
/// ```dart
/// MonitoringChart(
///   spots: [FlSpot(timestamp1, value1), FlSpot(timestamp2, value2)],
///   chartColor: Colors.blue,
///   errorText: 'Optional error message',
/// )
/// ```
class MonitoringChart extends StatelessWidget {
  const MonitoringChart({
    required this.spots,
    required this.chartColor,
    this.errorText,
    super.key,
  });
  final List<FlSpot> spots;
  final String? errorText;

  final Color chartColor;
  @override
  Widget build(BuildContext context) {
    final preferredMonitoringUnit = context.select(
      (AppPreferencesCubit cubit) => cubit.state.monitoringUnit,
    );

    final first = spots.firstOrNull ?? FlSpot.zero;
    final last = spots.lastOrNull ?? const FlSpot(1, 1);
    final minX = first.x;
    final maxX = last.x;
    final hasError = errorText != null;
    final baselineX = first.x;
    final baselineY = first.y;

    final tooltipColor = Theme.of(context).colorScheme.onPrimaryContainer;

    return Column(
      children: [
        if (hasError)
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSpacing.sm),
              color: Theme.of(context).colorScheme.errorContainer,
            ),
            margin: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Icon(
                  Icons.error,
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
                const Gap(AppSpacing.sm),
                Text(
                  errorText!,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                ),
              ],
            ),
          ),
        Expanded(
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  color: chartColor,
                  spots: spots,
                  isCurved: true,
                  barWidth: 1.2,
                  preventCurveOverShooting: true,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    color: chartColor.withOpacity(0.3),
                  ),
                ),
              ],
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (touchedSpot) => tooltipColor,
                  getTooltipItems: (touchedSpots) =>
                      touchedSpots.map((LineBarSpot touchedSpot) {
                    final suffix = preferredMonitoringUnit.symbol;
                    final timestamp = DateTime.fromMillisecondsSinceEpoch(
                      touchedSpot.x.toInt(),
                    );

                    final value = touchedSpot.y;
                    final formatedTimestamp = DateFormat.Hm().format(timestamp);
                    final text = '$value $suffix\nat $formatedTimestamp';
                    final textStyle = TextStyle(
                      color: touchedSpot.bar.gradient?.colors.first ??
                          touchedSpot.bar.color ??
                          Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    );
                    return LineTooltipItem(text, textStyle);
                  }).toList(),
                ),
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    minIncluded: false,
                    maxIncluded: false,
                    interval: preferredMonitoringUnit.interval.toDouble(),
                    reservedSize: switch (preferredMonitoringUnit) {
                      MonitoringUnit.kilowatts => AppSpacing.xxlg,
                      MonitoringUnit.watts => AppSpacing.xxxlg,
                    },
                    getTitlesWidget: (value, meta) {
                      final suffix = preferredMonitoringUnit.symbol;
                      return FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs,
                          ),
                          child: Text('${value.toStringAsFixed(0)} $suffix'),
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: AppSpacing.xxlg,
                    interval: (maxX - minX) / 4,
                    getTitlesWidget: (value, meta) {
                      final date = DateTime.fromMillisecondsSinceEpoch(
                        value.toInt(),
                      );
                      return Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                        child: Text(
                          DateFormat.Hm().format(date),
                        ),
                      );
                    },
                  ),
                ),
                topTitles: _emptyAxisTitles,
                rightTitles: _emptyAxisTitles,
              ),
              minX: minX,
              maxX: maxX,
              baselineX: baselineX,
              baselineY: baselineY,
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
      ],
    );
  }
}
