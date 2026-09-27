import 'package:intl/intl.dart';
import 'package:poka_ce/i18n/strings.g.dart';

/// Convenience formatting helpers on [DateTime].
extension DateTimeExtension on DateTime {
  /// Formats the time component as HH:mm with leading zeros based on device local time.
  String toFormattedTime() {
    final local = toLocal();
    final h = local.hour.toString().padLeft(2, '0');
    final m = local.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  /// Formats the date as 'dd MMM yyyy' (e.g. "12 Jan 2026") based on device local time.
  String toFormattedDate([String? locale]) {
    return DateFormat('dd MMM yyyy', locale ?? LocaleSettings.currentLocale.languageCode).format(toLocal());
  }

  /// Formats the date to a relative string like 'Today', 'Yesterday', or 'Mon, 12 Jan'
  String toRelativeDateString([String? locale]) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final target = DateTime(toLocal().year, toLocal().month, toLocal().day);
    final strings = locale != null ? AppLocaleUtils.parse(locale).translations : t;

    if (target == today) {
      return strings.common.today;
    } else if (target == yesterday) {
      return strings.common.yesterday;
    } else {
      final dateFormat = DateFormat('EEE, dd MMM', locale ?? LocaleSettings.currentLocale.languageCode);
      return dateFormat.format(toLocal());
    }
  }
}

/// Convenience formatting helpers on String-formatted ISO dates.
extension TemporalStringExtension on String {
  /// Formats the time component as HH:mm with leading zeros.
  ///
  /// Works with `'YYYY-MM-DDTHH:mm:ss'` wall-clock strings without timezone drift.
  String toFormattedTime() {
    if (length >= 16 && contains('T')) {
      final tIndex = indexOf('T');
      if (length >= tIndex + 6) {
        return substring(tIndex + 1, tIndex + 6);
      }
    }
    return DateTime.parse(this).toFormattedTime();
  }
}
