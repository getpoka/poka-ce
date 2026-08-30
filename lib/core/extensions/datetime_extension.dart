import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toFormattedTime() {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  String toFormattedDate() {
    return DateFormat('dd MMM yyyy').format(this);
  }

  /// Formats the date to a relative string like 'Today', 'Yesterday', or 'Mon, 12 Jan'
  String toRelativeDateString() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final target = DateTime(toLocal().year, toLocal().month, toLocal().day);

    if (target == today) {
      return 'Today';
    } else if (target == yesterday) {
      return 'Yesterday';
    } else {
      final dateFormat = DateFormat('EEE, dd MMM');
      return dateFormat.format(toLocal());
    }
  }
}
