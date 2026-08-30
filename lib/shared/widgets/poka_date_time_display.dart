import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';

/// A widget that displays a DateTime.
/// It automatically converts UTC time from the domain layer to the local device time
/// to fulfill Rule 1.
class PokaDateTimeDisplay extends StatelessWidget {
  /// Creates a PokaDateTimeDisplay.
  const PokaDateTimeDisplay({
    required this.utcDateTime,
    this.format = 'dd MMM yyyy, HH:mm',
    this.style,
    super.key,
  });

  /// The UTC DateTime from the domain layer.
  final DateTime utcDateTime;

  /// The format string for the date.
  final String format;

  /// The text style.
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    // Convert to local time
    final localDateTime = utcDateTime.toLocal();
    final formatter = DateFormat(format);

    return Text(
      formatter.format(localDateTime),
      style: style ?? context.theme.typography.body.md,
    );
  }
}
