import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('DateTimeUtils mutation hardening', () {
    test('nowUtc returns UTC (isUtc true) - mutant toUtc -> now would fail', () {
      final utc = DateTimeUtils.nowUtc();
      expect(utc.isUtc, isTrue, reason: 'must be UTC, not local');
    });

    test('nowUtc is close to DateTime.now().toUtc() within 1s', () {
      final before = DateTime.now().toUtc();
      final sut = DateTimeUtils.nowUtc();
      final after = DateTime.now().toUtc();
      expect(sut.isAfter(before.subtract(const Duration(seconds: 1))), isTrue);
      expect(sut.isBefore(after.add(const Duration(seconds: 1))), isTrue);
    });
  });
}
