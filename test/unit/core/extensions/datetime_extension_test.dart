import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/extensions/datetime_extension.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('DateTimeExtension', () {
    test('toFormattedTime pads hour and minute', () {
      final dt = DateTime(2026, 1, 1, 5, 7);
      expect(dt.toFormattedTime(), '05:07');
      final dt2 = DateTime(2026, 1, 1, 15, 45);
      expect(dt2.toFormattedTime(), '15:45');
    });

    test('toFormattedDate formats correctly', () {
      final dt = DateTime(2026, 3, 15);
      expect(dt.toFormattedDate(), '15 Mar 2026');
    });

    test('toRelativeDateString returns Today for today', () {
      final now = DateTime.now();
      expect(now.toRelativeDateString(), 'Today');
    });

    test('toRelativeDateString returns Yesterday for yesterday', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(yesterday.toRelativeDateString(), 'Yesterday');
    });

    test('toRelativeDateString returns formatted for older date', () {
      final old = DateTime.now().subtract(const Duration(days: 5));
      final result = old.toRelativeDateString();
      // Should be like "Mon, 12 Jan"
      expect(result.contains(','), isTrue);
      expect(result, isNot('Today'));
      expect(result, isNot('Yesterday'));
    });
  });
}
