import 'dart:math';

import 'package:intl/intl.dart';

/// Standard placeholder string used across the app to mask sensitive financial amounts.
const String kPrivacyMask = '••••••';

/// Formatting helpers for numeric values (integers and doubles).
extension NumExtension on num {
  /// Converts the number to compact abbreviated string (e.g. 1.2K, 3.4M, 5.0B).
  ///
  /// [precision] is the ISO 4217 minor-unit exponent for the currency (e.g. 2 for USD, 0 for IDR).
  /// The raw value is divided by `10^precision` before formatting so that minor-unit amounts
  /// (e.g. 300 cents) are displayed as major-unit strings (e.g. "3.00").
  String toCompactFormat({int precision = 0, bool isVisible = true}) {
    if (!isVisible) return kPrivacyMask;
    final major = this / pow(10, precision);
    if (major >= 1000000000) return '${(major / 1000000000).toStringAsFixed(1)}B';
    if (major >= 1000000) return '${(major / 1000000).toStringAsFixed(1)}M';
    if (major >= 1000) return '${(major / 1000).toStringAsFixed(1)}K';
    return major.toStringAsFixed(0);
  }

  /// Formats the number as a currency string with symbol, decimals, and optional obfuscation.
  ///
  /// Expects the value in ISO 4217 **minor units** (e.g. cents for USD, whole rupiah for IDR).
  /// Divides by `10^precision` internally before formatting so that `300.toCurrencyFormat(precision: 2)`
  /// produces `"$ 3.00"` rather than `"$ 300.00"`.
  String toCurrencyFormat({required String symbol, required int precision, String? locale, bool isVisible = true}) {
    // Trim the symbol to ensure no double-spaces, then add exactly one space.
    final cleanSymbol = symbol.trim();
    final effectiveSymbol = cleanSymbol.isEmpty ? '' : '$cleanSymbol ';

    if (!isVisible) return '$effectiveSymbol$kPrivacyMask';

    // Convert minor units → major units before formatting.
    final majorValue = this / pow(10, precision);

    final format = NumberFormat.currency(
      locale: (locale == 'system') ? null : locale,
      symbol: effectiveSymbol,
      decimalDigits: precision,
    );

    return format.format(majorValue);
  }
}
