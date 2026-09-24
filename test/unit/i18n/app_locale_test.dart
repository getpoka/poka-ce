import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/i18n/strings.g.dart';

/// Verifies Malay and Vietnamese locales are registered and resolve strings.
void main() {
  group('AppLocale ms/vi support', () {
    test('AppLocale values contain ms and vi', () {
      expect(AppLocale.values, contains(AppLocale.ms));
      expect(AppLocale.values, contains(AppLocale.vi));
      expect(AppLocale.ms.languageCode, 'ms');
      expect(AppLocale.vi.languageCode, 'vi');
    });

    test('Malay translations resolve', () async {
      final t = await AppLocale.ms.build();
      expect(t.settings.title, 'Tetapan');
      expect(t.settings.malay, 'Bahasa Melayu');
      expect(t.settings.vietnam, 'Tiếng Việt');
      expect(t.settings.title, isNotEmpty);
    });

    test('Vietnamese translations resolve', () async {
      final t = await AppLocale.vi.build();
      expect(t.settings.malay, 'Bahasa Melayu');
      expect(t.settings.vietnam, 'Tiếng Việt');
      expect(t.settings.title, isNotEmpty);
    });

    test('LocaleSettings round-trips ms and vi', () {
      LocaleSettings.setLocaleSync(AppLocale.ms);
      expect(LocaleSettings.currentLocale, AppLocale.ms);

      LocaleSettings.setLocaleSync(AppLocale.vi);
      expect(LocaleSettings.currentLocale, AppLocale.vi);

      LocaleSettings.setLocaleSync(AppLocale.en);
      expect(LocaleSettings.currentLocale, AppLocale.en);
    });
  });
}
