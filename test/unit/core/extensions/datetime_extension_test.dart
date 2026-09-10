import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:poka_ce/core/extensions/datetime_extension.dart';
import 'package:poka_ce/i18n/strings.g.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initializeDateFormatting();
  });

  tearDownAll(() {
    LocaleSettings.setLocale(AppLocale.en);
  });

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

    test('toFormattedDate respects Indonesian locale', () {
      final augustDate = DateTime(2026, 8, 15);
      expect(augustDate.toFormattedDate('en'), '15 Aug 2026');
      expect(augustDate.toFormattedDate('id'), '15 Agu 2026');
    });

    test('toRelativeDateString returns Today for today', () async {
      final now = DateTime.now();
      await LocaleSettings.setLocale(AppLocale.en);
      expect(now.toRelativeDateString(), 'Today');
      await LocaleSettings.setLocale(AppLocale.id);
      expect(now.toRelativeDateString(), 'Hari ini');
      await LocaleSettings.setLocale(AppLocale.en);
    });

    test('toRelativeDateString returns Yesterday for yesterday', () async {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      await LocaleSettings.setLocale(AppLocale.en);
      expect(yesterday.toRelativeDateString(), 'Yesterday');
      await LocaleSettings.setLocale(AppLocale.id);
      expect(yesterday.toRelativeDateString(), 'Kemarin');
      await LocaleSettings.setLocale(AppLocale.en);
    });

    test('toRelativeDateString returns formatted for older date', () {
      // 2026-01-07 was a Wednesday, well before "yesterday"
      final wednesday = DateTime(2026, 1, 7);
      expect(wednesday.toRelativeDateString('en'), 'Wed, 07 Jan');
      expect(wednesday.toRelativeDateString('id'), 'Rab, 07 Jan');
    });

    test('toRelativeDateString respects explicit locale parameter for Today and Yesterday', () {
      final now = DateTime.now();
      LocaleSettings.setLocaleSync(AppLocale.en);
      expect(now.toRelativeDateString('id'), 'Hari ini');
      expect(now.toRelativeDateString('en'), 'Today');

      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(yesterday.toRelativeDateString('id'), 'Kemarin');
      expect(yesterday.toRelativeDateString('en'), 'Yesterday');
    });

    test('toRelativeDateString falls back safely on unknown locale string', () {
      final now = DateTime.now();
      LocaleSettings.setLocaleSync(AppLocale.en);
      expect(() => now.toRelativeDateString('fr'), returnsNormally);
      expect(now.toRelativeDateString('fr'), 'Today');
    });
  });
}
