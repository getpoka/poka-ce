import 'package:intl/intl.dart';

extension NumExtension on num {
  String toCompactFormat() {
    if (this >= 1000000000) return '${(this / 1000000000).toStringAsFixed(1)}B';
    if (this >= 1000000) return '${(this / 1000000).toStringAsFixed(1)}M';
    if (this >= 1000) return '${(this / 1000).toStringAsFixed(1)}K';
    return toStringAsFixed(0);
  }

  String toCurrencyFormat({
    required String symbol,
    required int precision,
    String? locale,
    bool isVisible = true,
  }) {
    // Trim the symbol to ensure no double-spaces, then add exactly one space.
    final cleanSymbol = symbol.trim();
    final effectiveSymbol = cleanSymbol.isEmpty ? '' : '$cleanSymbol ';

    if (!isVisible) return '$effectiveSymbol••••••';

    final format = NumberFormat.currency(
      locale: (locale == 'system') ? null : locale,
      symbol: effectiveSymbol,
      decimalDigits: precision,
    );

    return format.format(this);
  }
}
