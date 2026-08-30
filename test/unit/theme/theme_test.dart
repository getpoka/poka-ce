import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poka_ce/theme/theme.dart';
import 'package:poka_ce/theme/tailwind.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Theme coverage', () {
    test('lightTheme and darkTheme are constructed', () {
      final light = lightTheme;
      final dark = darkTheme;
      expect(light.colors.primary, lightColors.primary);
      expect(dark.colors.primary, darkColors.primary);
      expect(light.typography.body.md.fontSize, isNotNull);
      expect(dark.typography.body.md.fontSize, isNotNull);
      expect(light.style.borderRadius, isNotNull);
    });

    test('AppColors copyWith, lerp, equality', () {
      const a = AppColors(
        income: TWind.emerald600,
        expense: TWind.red600,
        transfer: TWind.blue500,
        success: TWind.emerald500,
        warning: TWind.amber500,
      );
      final b = a.copyWith(income: TWind.emerald500);
      expect(b.income, TWind.emerald500);
      expect(b.expense, TWind.red600);
      final c = a.copyWith();
      expect(c, a);
      expect(a.hashCode, isNotNull);
      final lerped = a.lerp(b, 0.5);
      expect(lerped, isA<AppColors>());
      expect(a == b, isFalse);
      expect(a == a, isTrue);
    });

    test('AppStyle copyWith, lerp, equality', () {
      const s = AppStyle(iconBgOpacity: 0.12, iconBorderOpacity: 0.20);
      final s2 = s.copyWith(iconBgOpacity: 0.5);
      expect(s2.iconBgOpacity, 0.5);
      expect(s2.iconBorderOpacity, 0.20);
      expect(s.lerp(null, 0.5), s);
      final lerped = s.lerp(const AppStyle(iconBgOpacity: 0.2, iconBorderOpacity: 0.3), 0.5);
      expect(lerped.iconBgOpacity, closeTo(0.16, 0.01));
      expect(s == s2, isFalse);
      expect(s == const AppStyle(), isTrue);
      expect(s.hashCode, isNotNull);
      expect(s.xs, 8);
      expect(s.section, s.lg);
    });

    test('FColors extensions', () {
      expect(lightColors.app.income, TWind.emerald600);
      expect(darkColors.app.income, TWind.emerald400);
      expect(lightColors.app.transfer, TWind.indigo600);
    });

    test('FStyle extensions', () {
      final light = lightTheme;
      expect(light.style.app.iconBgOpacity, 0.12);
    });

    test('TW categories', () {
      expect(TWind.slate900, isNotNull);
      expect(TWind.white, isNotNull);
    });
  });
}
