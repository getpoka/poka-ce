import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/database/converters/local_date_converter.dart';

/// Unit tests for [LocalDateConverter], [LocalDateTimeConverter], and temporal formatting helpers.
void main() {
  group('LocalDateConverter', () {
    const converter = LocalDateConverter();

    test('fromSql passes through the database string unchanged', () {
      expect(converter.fromSql('2026-09-28'), '2026-09-28');
    });

    test('toSql passes through the value string unchanged', () {
      expect(converter.toSql('2026-09-28'), '2026-09-28');
    });
  });

  group('LocalDateTimeConverter', () {
    const converter = LocalDateTimeConverter();

    test('fromSql passes through the database string unchanged', () {
      expect(converter.fromSql('2026-09-28T01:30:00'), '2026-09-28T01:30:00');
    });

    test('toSql passes through the value string unchanged', () {
      expect(converter.toSql('2026-09-28T01:30:00'), '2026-09-28T01:30:00');
    });
  });

  group('todayAsLocalDate', () {
    test('formats a given DateTime as YYYY-MM-DD with zero-padding', () {
      final date = DateTime(2026, 4, 5);
      expect(todayAsLocalDate(date), '2026-04-05');
    });

    test('formats today when no date is passed', () {
      final now = DateTime.now();
      final expectedY = now.year.toString().padLeft(4, '0');
      final expectedM = now.month.toString().padLeft(2, '0');
      final expectedD = now.day.toString().padLeft(2, '0');
      expect(todayAsLocalDate(), '$expectedY-$expectedM-$expectedD');
    });
  });

  group('formatAsLocalDateTime', () {
    test('formats a given DateTime as YYYY-MM-DDTHH:mm:ss with zero-padding', () {
      final dt = DateTime(2026, 3, 7, 9, 5, 2);
      expect(formatAsLocalDateTime(dt), '2026-03-07T09:05:02');
    });

    test('preserves double-digit units correctly', () {
      final dt = DateTime(2026, 12, 31, 23, 59, 58);
      expect(formatAsLocalDateTime(dt), '2026-12-31T23:59:58');
    });
  });

  group('nowAsLocalDateTime', () {
    test('formats a provided DateTime when given', () {
      final dt = DateTime(2026, 1, 2, 3, 4, 5);
      expect(nowAsLocalDateTime(dt), '2026-01-02T03:04:05');
    });

    test('formats current time when no argument is given', () {
      final before = DateTime.now();
      final str = nowAsLocalDateTime();
      final after = DateTime.now();

      expect(str, contains('T'));
      final parts = str.split('T');
      expect(parts.length, 2);
      expect(parts[0].split('-').length, 3);
      expect(parts[1].split(':').length, 3);

      final parsed = DateTime.parse(str);
      expect(parsed.isAfter(before.subtract(const Duration(seconds: 1))), isTrue);
      expect(parsed.isBefore(after.add(const Duration(seconds: 1))), isTrue);
    });
  });
}
