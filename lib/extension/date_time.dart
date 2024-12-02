/// Extension methods for DateTime to provide
/// additional date comparison functionality.
extension DateTimeX on DateTime {
  /// Returns true if this date is today.
  ///
  /// Compares year, month, and day components with the current date.
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Checks if this date falls on the same calendar day as [other].
  ///
  /// Compares year, month, and day components while ignoring time components.
  ///
  /// Example:
  /// ```dart
  /// final date1 = DateTime(2024, 3, 15, 14, 30);
  /// final date2 = DateTime(2024, 3, 15, 9, 0);
  /// print(date1.isSameDay(date2)); // true
  /// ```
  bool isSameDay(DateTime other) {
    final val = year == other.year && month == other.month && day == other.day;
    return val;
  }

  /// Returns true if this date is yesterday.
  ///
  /// Compares year, month, and day components with yesterday's date.
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }
}
