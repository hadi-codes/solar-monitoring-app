import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:solar_monitor/extension/extension.dart';
import 'package:solar_monitor/l10n/l10n.dart';
import 'package:solar_monitor/monitoring/monitoring.dart';
import 'package:time_range_picker/time_range_picker.dart';

/// {@template monitoring_date_picker}
/// A widget that displays a date picker with navigation controls
/// and an optional time range picker.
///
/// The widget consists of:
/// - Back/forward arrows to navigate between dates
/// - A date button that opens a calendar picker when pressed
/// - A time range picker button that allows selecting specific hours
/// within the selected date
///
/// The date button displays:
/// - "Today" for the current date
/// - "Yesterday" for the previous day
/// - The formatted date (MMM d, yyyy) for all other dates
///
/// Example:
/// ```dart
/// MonitoringDatePicker(
///   currentDate: DateTime.now(),
///   onDateChanged: (newDate) => print(newDate),
///   selectedTimeRange: (startTime, endTime),
///   onDateTimeRangeChanged: (newRange) => print(newRange),
/// )
/// ```
/// {@endtemplate}
class MonitoringDatePicker extends StatelessWidget {
  const MonitoringDatePicker({
    required this.currentDate,
    super.key,
    this.onDateChanged,
    this.selectedTimeRange,
    this.onDateTimeRangeChanged,
  });
  final DateTime currentDate;
  final ValueChanged<DateTime>? onDateChanged;
  final MonitoringTimeRange? selectedTimeRange;
  final TimeRangeCallback? onDateTimeRangeChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            onDateChanged?.call(
              currentDate.subtract(
                const Duration(days: 1),
              ),
            );
          },
        ),
        OutlinedButton(
          onPressed: () async {
            final newDate = await showDatePicker(
              context: context,
              initialDate: currentDate,
              firstDate: DateTime(2017),
              lastDate: DateTime.now(),
            );
            if (newDate == null) return;

            onDateChanged?.call(newDate);
          },
          child: Text(currentDate.formatted(context)),
        ),
        const Spacer(),
        TimeRangeButtonPicker(
          date: currentDate,
          selectedTimeRange: selectedTimeRange,
          onTimeRangeChanged: onDateTimeRangeChanged,
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: currentDate.isToday
              ? null
              : () {
                  onDateChanged?.call(
                    currentDate.add(
                      const Duration(days: 1),
                    ),
                  );
                },
        ),
      ],
    );
  }
}

extension on DateTime {
  String formatted(BuildContext context) {
    final l10n = context.l10n;
    if (isToday) {
      return l10n.today;
    } else if (isYesterday) {
      return l10n.yesterday;
    } else {
      return DateFormat.yMMMd().format(this);
    }
  }
}

/// {@template time_range_callback}
/// A callback function that is called when the time range is changed.
/// {@endtemplate}
typedef TimeRangeCallback = void Function(
  MonitoringTimeRange? newTimeRange,
);

///{@template time_range_button_picker}
///A button that opens a time range picker to allow the user to select a time
///range. the button has two states, one when no time range is selected and
///another when a time range is selected.
/// - When no time range is selected, the button shows an icon that opens the
/// time range picker when pressed.
/// - When a time range is selected, the button will nullify the selected time
/// range when pressed.
///
///{@endtemplate}
class TimeRangeButtonPicker extends StatelessWidget {
  const TimeRangeButtonPicker({
    required this.selectedTimeRange,
    required this.date,
    super.key,
    this.onTimeRangeChanged,
  });
  final DateTime date;
  final TimeRangeCallback? onTimeRangeChanged;
  final MonitoringTimeRange? selectedTimeRange;
  @override
  Widget build(BuildContext context) {
    MonitoringTimeRange convertTimeRangeToDateTimeRange(
      TimeRange timeRange,
    ) {
      final start = timeRange.startTime.toDateTime(date);
      final end = timeRange.endTime.toDateTime(date);

      if (start.isBefore(end)) {
        return (start, end);
      } else {
        return (end, start);
      }
    }

    Future<void> onPressed() async {
      final timeRange = await showTimeRangePicker(
        context: context,
        rotateLabels: false,
        clockRotation: 180,
        builder: (context, child) {
          final brightness = Theme.of(context).brightness;
          if (brightness == Brightness.dark) {
            return Theme(
              data: Theme.of(context).copyWith(
                brightness: Brightness.light,
              ),
              child: child!,
            );
          }
          return child!;
        },
        ticks: 12,
        ticksColor: Theme.of(context).colorScheme.onSurface,
        ticksOffset: -12,
        labels: ['24 h', '3 h', '6 h', '9 h', '12 h', '15 h', '18 h', '21 h']
            .asMap()
            .entries
            .map((e) {
          return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
        }).toList(),
        labelOffset: -30,
        padding: 55,
        start: const TimeOfDay(hour: 1, minute: 0),
        end: const TimeOfDay(hour: 19, minute: 00),
        snap: true,
      ) as TimeRange?;
      if (timeRange == null) return;

      final newSelectedDateRange = convertTimeRangeToDateTimeRange(timeRange);

      onTimeRangeChanged?.call(newSelectedDateRange);
    }

    if (selectedTimeRange == null) {
      return IconButton(
        onPressed: onPressed,
        icon: const Icon(MingCute.time_line),
      );
    }

    final start = selectedTimeRange!.$1;
    final end = selectedTimeRange!.$2;
    final timeFormat = DateFormat.Hm();

    return TextButton(
      onPressed: () => onTimeRangeChanged?.call(null),
      child: Text(
        '${timeFormat.format(start)} - ${timeFormat.format(end)}',
      ),
    );
  }
}

extension on TimeOfDay {
  DateTime toDateTime([DateTime? date]) {
    final now = date ?? DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }
}
