import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('StringExtension toColor', () {
    test('parses hex without #', () {
      const hex = 'FF5733';
      final color = hex.toColor();
      expect(color, const Color(0xFFFF5733));
    });

    test('parses hex with # prefix', () {
      const hex = '#FF5733';
      final color = hex.toColor();
      expect(color, const Color(0xFFFF5733));
    });

    test('returns default color on invalid hex', () {
      const invalid = 'ZZZZZZ';
      final color = invalid.toColor();
      expect(color, const Color(0xFFCCCCCC));
    });

    test('returns custom default on invalid hex', () {
      const invalid = 'not-a-color';
      const custom = Color(0xFF123456);
      final color = invalid.toColor(custom);
      expect(color, custom);
    });

    test('parses 6-char hex correctly', () {
      expect('000000'.toColor(), const Color(0xFF000000));
      expect('FFFFFF'.toColor(), const Color(0xFFFFFFFF));
    });
  });

  group('StringExtension formatAsNumber', () {
    test('formats integer with thousands separator', () {
      expect('50000'.formatAsNumber(), '50,000');
    });

    test('formats number with decimal part', () {
      expect('50000.5'.formatAsNumber(), '50,000.5');
    });

    test('empty integer part becomes zero', () {
      expect('.5'.formatAsNumber(), '0.5');
    });

    test('returns original on invalid number', () {
      expect('abc'.formatAsNumber(), 'abc');
    });

    test('formats with explicit locale', () {
      expect('50000.5'.formatAsNumber(localeFormat: 'id'), '50.000,5');
    });
  });

  group('StringExtension formatMathExpression', () {
    test('formats addition', () {
      expect('5000+10'.formatMathExpression(), '5,000 + 10');
    });

    test('formats subtraction', () {
      expect('5000-10'.formatMathExpression(), '5,000 - 10');
    });

    test('formats multiplication with × symbol', () {
      expect('2*3'.formatMathExpression(), '2 × 3');
    });

    test('formats division with ÷ symbol', () {
      expect('10/2'.formatMathExpression(), '10 ÷ 2');
    });

    test('formats decimal numbers within expression', () {
      expect('1.5+2.25'.formatMathExpression(), '1.5 + 2.25');
    });

    test('formats complex expression', () {
      expect('100*2+50/5'.formatMathExpression(), '100 × 2 + 50 ÷ 5');
    });

    test('ignores non-matching characters', () {
      expect('5+5'.formatMathExpression(), '5 + 5');
    });
  });

  group('StringExtension toMinorUnits', () {
    test('returns 0 for empty or whitespace string', () {
      expect(''.toMinorUnits(precision: 2), 0);
      expect('   '.toMinorUnits(precision: 2), 0);
    });

    test('parses integer string with precision 0', () {
      expect('50000'.toMinorUnits(precision: 0), 50000);
      expect('100'.toMinorUnits(precision: 0), 100);
    });

    test('parses decimal string with precision 2 (USD/IDR)', () {
      expect('50.25'.toMinorUnits(precision: 2), 5025);
      expect('10'.toMinorUnits(precision: 2), 1000);
      expect('0.5'.toMinorUnits(precision: 2), 50);
      expect('0.05'.toMinorUnits(precision: 2), 5);
      expect('6.25'.toMinorUnits(precision: 2), 625);
    });

    test('handles localized thousands and decimal separators', () {
      // "1,234.56" (dot decimal)
      expect('1,234.56'.toMinorUnits(precision: 2), 123456);
      // "1.234,56" (comma decimal)
      expect('1.234,56'.toMinorUnits(precision: 2), 123456);
      // "12,5" (comma decimal)
      expect('12,5'.toMinorUnits(precision: 2), 1250);
    });

    test('handles negative values', () {
      expect('-50.25'.toMinorUnits(precision: 2), -5025);
    });
  });
}
