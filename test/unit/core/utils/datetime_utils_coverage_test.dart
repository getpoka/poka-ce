import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('DateTimeUtils.nowUtc coverage', () {
    test('returns UTC time (isUtc true)', () {
      final result = DateTimeUtils.nowUtc();
      expect(result.isUtc, isTrue);
    });

    test('returns time within tolerance of DateTime.now().toUtc()', () {
      final before = DateTime.now().toUtc();
      final result = DateTimeUtils.nowUtc();
      final after = DateTime.now().toUtc();

      // allow 1 second tolerance on each side for execution delay
      expect(
        result.isAfter(before.subtract(const Duration(seconds: 1))),
        isTrue,
        reason: 'nowUtc should be after before -1s',
      );
      expect(
        result.isBefore(after.add(const Duration(seconds: 1))),
        isTrue,
        reason: 'nowUtc should be before after +1s',
      );
    });

    test('timeZoneOffset is zero', () {
      final result = DateTimeUtils.nowUtc();
      expect(result.timeZoneOffset, Duration.zero);
    });

    test('difference from DateTime.now().toUtc() is small (< 2s)', () {
      final expected = DateTime.now().toUtc();
      final actual = DateTimeUtils.nowUtc();
      final diff = actual.difference(expected).abs();
      expect(diff.inSeconds, lessThan(2));
    });
  });
}
