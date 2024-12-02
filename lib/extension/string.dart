/// Extension on [String] to provide additional string manipulation utilities.
extension StringX on String {
  /// Capitalizes the first character of the string while preserving the rest.
  ///
  /// Returns a new string with the first character
  /// in uppercase and the remaining
  /// characters unchanged. If the string is empty or has only one character,
  /// the entire string is converted to uppercase.
  ///
  /// Example:
  /// ```dart
  /// 'hello'.capitalize(); // Returns 'Hello'
  /// 'h'.capitalize();     // Returns 'H'
  /// ''.capitalize();      // Returns ''
  /// ```
  String capitalize() {
    return (length > 1) ? this[0].toUpperCase() + substring(1) : toUpperCase();
  }
}
