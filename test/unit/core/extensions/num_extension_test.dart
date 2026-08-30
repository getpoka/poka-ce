import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/extensions/num_extension.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('NumExtension toCompactFormat', () {
    test('returns 0 for zero', () {
      expect(0.toCompactFormat(), '0');
    });

    test('returns plain number for values below 1000', () {
      expect(999.toCompactFormat(), '999');
      expect(500.toCompactFormat(), '500');
      expect(1.toCompactFormat(), '1');
    });

    test('formats 1000 as 1.0K', () {
      expect(1000.toCompactFormat(), '1.0K');
    });

    test('formats values in K range', () {
      expect(1500.toCompactFormat(), '1.5K');
      expect(12345.toCompactFormat(), '12.3K');
    });

    test('formats 1M range', () {
      expect(1000000.toCompactFormat(), '1.0M');
      expect(2500000.toCompactFormat(), '2.5M');
      expect(1500000.toCompactFormat(), '1.5M');
    });

    test('formats 1B range', () {
      expect(1000000000.toCompactFormat(), '1.0B');
      expect(2500000000.toCompactFormat(), '2.5B');
      expect(1000000000.toCompactFormat(), '1.0B');
    });

    test('handles double values', () {
      expect(1234.56.toCompactFormat(), '1.2K');
      expect(1234567.89.toCompactFormat(), '1.2M');
    });

    test('boundary - 999999 stays in K', () {
      // 999999 / 1000 = 999.999 -> 1000.0K
      expect(999999.toCompactFormat(), '1000.0K');
    });

    test('boundary - just below 1B stays in M', () {
      expect(999999999.toCompactFormat(), '1000.0M');
    });
  });

  group('NumExtension toCurrencyFormat', () {
    test('returns masked value when isVisible false', () {
      expect(1000.toCurrencyFormat(symbol: 'IDR', precision: 0, isVisible: false), 'IDR ••••••');
      expect(0.toCurrencyFormat(symbol: 'USD', precision: 0, isVisible: false), 'USD ••••••');
      expect(999.99.toCurrencyFormat(symbol: 'EUR', precision: 0, isVisible: false), 'EUR ••••••');
    });

    test('returns default visible true when not specified', () {
      // isVisible defaults to true, so should not be masked
      final result = 1000.toCurrencyFormat(symbol: 'IDR', precision: 0);
      expect(result.contains('IDR'), isTrue);
      expect(result.contains('••••••'), isFalse);
    });

    test('formats visible currency with IDR', () {
      expect(0.toCurrencyFormat(symbol: 'IDR', precision: 2), 'IDR 0.00');
      expect(1234.5.toCurrencyFormat(symbol: 'IDR', precision: 2), 'IDR 1,234.50');
      expect(1000000.toCurrencyFormat(symbol: 'IDR', precision: 2), 'IDR 1,000,000.00');
    });

    test('formats visible currency with USD', () {
      final result = 1234.56.toCurrencyFormat(symbol: 'USD', precision: 2);
      expect(result, 'USD 1,234.56');
    });

    test('formats negative amount when visible', () {
      final result = (-500).toCurrencyFormat(symbol: 'IDR', precision: 2);
      expect(result.contains('IDR'), isTrue);
      expect(result.contains('500.00'), isTrue);
    });

    test('formats double fractional amount', () {
      expect(0.5.toCurrencyFormat(symbol: 'IDR', precision: 2), 'IDR 0.50');
      expect(99.9.toCurrencyFormat(symbol: 'USD', precision: 2), 'USD 99.90');
    });
  });
}
