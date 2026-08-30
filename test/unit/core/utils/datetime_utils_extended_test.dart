import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('DateTimeUtils extended', () {
    test('nowUtc returns UTC', () {
      expect(DateTimeUtils.nowUtc().isUtc, true);
    });

    test('nowUtc timeZoneOffset zero', () {
      expect(DateTimeUtils.nowUtc().timeZoneOffset, Duration.zero);
    });

    test('nowUtc is close to DateTime.now().toUtc()', () {
      final before = DateTime.now().toUtc().subtract(const Duration(seconds: 1));
      final now = DateTimeUtils.nowUtc();
      final after = DateTime.now().toUtc().add(const Duration(seconds: 1));
      expect(now.isAfter(before), true);
      expect(now.isBefore(after), true);
    });

    test('nowUtc successive calls are non-decreasing', () async {
      final a = DateTimeUtils.nowUtc();
      await Future.delayed(const Duration(milliseconds: 5));
      final b = DateTimeUtils.nowUtc();
      expect(b.isAfter(a) || b.isAtSameMomentAs(a), true);
    });

    test('nowUtc year sanity', () {
      final now = DateTimeUtils.nowUtc();
      expect(now.year, greaterThanOrEqualTo(2024));
    });

    test('nowUtc toIso8601 ends with Z', () {
      final now = DateTimeUtils.nowUtc();
      expect(now.toIso8601String().endsWith('Z'), true);
    });

    test('multiple calls not identical object but close', () {
      final a = DateTimeUtils.nowUtc();
      final b = DateTimeUtils.nowUtc();
      expect(a, isNot(same(b)));
      expect((b.difference(a).inMilliseconds).abs(), lessThan(100));
    });
  });
}
