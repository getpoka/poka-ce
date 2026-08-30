/// Helper class for standardized DateTime operations across the application.
class DateTimeUtils {
  DateTimeUtils._();

  /// Returns the current time in UTC 0, as mandated by the architecture rules.
  /// Use this instead of `DateTime.now()` or `DateTime.now().toUtc()` to prevent timezone bugs.
  static DateTime nowUtc() {
    return DateTime.now().toUtc();
  }
}
