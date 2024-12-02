import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solar_monitor/monitoring/monitoring.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('MonitoringDatePicker', () {
    testWidgets('renders current date', (tester) async {
      final currentDate = DateTime(2024, 3, 20);

      await tester.pumpApp(
        MonitoringDatePicker(
          currentDate: currentDate,
        ),
      );

      expect(find.text('Mar 20, 2024'), findsOneWidget);
    });

    testWidgets('shows "Today" for current date', (tester) async {
      final currentDate = DateTime.now();

      await tester.pumpApp(
        MonitoringDatePicker(
          currentDate: currentDate,
        ),
      );

      expect(find.text('Today'), findsOneWidget);
    });

    testWidgets('calls onDateChanged when back button pressed', (tester) async {
      final currentDate = DateTime(2024, 3, 20);
      var dateChanged = false;
      DateTime? newDate;

      await tester.pumpApp(
        MonitoringDatePicker(
          currentDate: currentDate,
          onDateChanged: (date) {
            dateChanged = true;
            newDate = date;
          },
        ),
      );

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pump();

      expect(dateChanged, isTrue);
      expect(
        newDate,
        DateTime(2024, 3, 19),
      );
    });

    testWidgets('forward button disabled for current date', (tester) async {
      final currentDate = DateTime.now();

      await tester.pumpApp(
        MonitoringDatePicker(
          currentDate: currentDate,
        ),
      );

      final forwardButton = tester.widget<IconButton>(
        find.byType(IconButton).last,
      );
      expect(forwardButton.onPressed, isNull);
    });

    group('TimeRangeButtonPicker', () {
      testWidgets('shows icon when no time range selected', (tester) async {
        await tester.pumpApp(
          TimeRangeButtonPicker(
            date: DateTime.now(),
            selectedTimeRange: null,
          ),
        );

        expect(find.byType(IconButton), findsOneWidget);
      });

      testWidgets('shows time range when selected', (tester) async {
        final now = DateTime.now();
        final timeRange = (
          DateTime(now.year, now.month, now.day, 10),
          DateTime(now.year, now.month, now.day, 14),
        );

        await tester.pumpApp(
          TimeRangeButtonPicker(
            date: now,
            selectedTimeRange: timeRange,
          ),
        );

        expect(find.text('10:00 - 14:00'), findsOneWidget);
      });

      testWidgets('clears time range when clicked with selection',
          (tester) async {
        final now = DateTime.now();
        final timeRange = (
          DateTime(now.year, now.month, now.day, 10),
          DateTime(now.year, now.month, now.day, 14),
        );
        var timeRangeCleared = false;

        await tester.pumpApp(
          TimeRangeButtonPicker(
            date: now,
            selectedTimeRange: timeRange,
            onTimeRangeChanged: (range) {
              timeRangeCleared = range == null;
            },
          ),
        );

        await tester.tap(find.text('10:00 - 14:00'));
        await tester.pump();

        expect(timeRangeCleared, isTrue);
      });
    });
  });
}
