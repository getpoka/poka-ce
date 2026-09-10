import 'package:intl/intl.dart';
import 'package:poka_ce/i18n/strings.g.dart';

/// Convenience formatting helpers on [DateTime].
extension DateTimeExtension on DateTime {
  /// Formats the time component as HH:mm with leading zeros.
  String toFormattedTime() {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  /// Formats the date as 'dd MMM yyyy' (e.g. "12 Jan 2026").
  String toFormattedDate([String? locale]) {
    return DateFormat('dd MMM yyyy', locale ?? LocaleSettings.currentLocale.languageCode).format(this);
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
