import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  Color toColor([Color defaultColor = const Color(0xFFCCCCCC)]) {
    try {
      final hexCodeClean = replaceAll('#', '');
      return Color(int.parse('FF$hexCodeClean', radix: 16));
    } on Exception catch (_) {
      return defaultColor;
    }
  }

  /// Formats a raw number string (e.g. "50000.5") into a localized string (e.g. "50,000.5" or "50.000,5")
  String formatAsNumber({String localeFormat = 'system'}) {
    final fmt = NumberFormat('#,##0', localeFormat == 'system' ? null : localeFormat);
    final decimalSep = fmt.symbols.DECIMAL_SEP;

    try {
      final parts = split('.');
      final intPart = parts[0].isEmpty ? '0' : parts[0];
      final formattedInt = fmt.format(int.parse(intPart));
      if (parts.length > 1) {
        return '$formattedInt$decimalSep${parts[1]}';
      }
      return formattedInt;
    } on Exception catch (_) {
      return this;
    }
  }

  /// Evaluates and formats a raw math expression string, e.g. "5000+10.5" -> "5,000 + 10,5"
  String formatMathExpression({String localeFormat = 'system'}) {
    final regex = RegExp(r'(\d+(?:\.\d*)?)|([+\-*/])');
    final matches = regex.allMatches(this);

    final buffer = StringBuffer();
    for (final match in matches) {
      final text = match.group(0)!;
      if (text == '+' || text == '-' || text == '*' || text == '/') {
        if (text == '*') {
          buffer.write(' × ');
        } else if (text == '/') {
          buffer.write(' ÷ ');
        } else {
          buffer.write(' $text ');
        }
      } else {
        buffer.write(text.formatAsNumber(localeFormat: localeFormat));
      }
    }
    return buffer.toString().trim();
  }
}
