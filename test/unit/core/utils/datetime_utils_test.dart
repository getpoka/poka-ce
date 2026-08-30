import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('DateTimeUtils', () {
    test('nowUtc returns UTC timezone', () {
      final now = DateTimeUtils.nowUtc();
      expect(now.isUtc, true);
    });

    test('nowUtc is close to current time', () {
      final before = DateTime.now().toUtc();
      final now = DateTimeUtils.nowUtc();
      final after = DateTime.now().toUtc();
      expect(now.isAfter(before.subtract(const Duration(seconds: 1))), true);
      expect(now.isBefore(after.add(const Duration(seconds: 1))), true);
    });

    test('nowUtc different from local time if timezone offset', () {
      // Just verify it is not identical to non-UTC if we compare isUtc flag
      final utc = DateTimeUtils.nowUtc();
      expect(utc.timeZoneOffset, Duration.zero);
    });
  });
}
