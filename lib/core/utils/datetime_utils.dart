/// Helper class for standardized DateTime operations across the application.
class DateTimeUtils {
  new _();

  /// Returns the current time in UTC, backed by Dart stdlib [DateTime.timestamp].
  static DateTime nowUtc() => DateTime.timestamp();
}
