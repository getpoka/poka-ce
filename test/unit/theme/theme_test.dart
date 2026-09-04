import 'dart:ui' show FontFeature;

import 'package:flutter/material.dart' show FontWeight;
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poka_ce/theme/tailwind.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
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

    test('AppStyle spacing scale getters', () {
      const s = AppStyle();
      expect(s.xs, 8);
      expect(s.sm, 12);
      expect(s.md, 16);
      expect(s.lg, 20);
      expect(s.xl, 24);
      expect(s.xxl, 32);
      expect(s.xl3, 40);
      expect(s.xl4, 48);
      expect(s.section, 20);
      expect(s.sectionContent, 16);
    });

    test('AppStyle copyWith only iconBorderOpacity keeps iconBgOpacity', () {
      const s = AppStyle(iconBgOpacity: 0.3, iconBorderOpacity: 0.4);
      final s2 = s.copyWith(iconBorderOpacity: 0.9);
      expect(s2.iconBgOpacity, 0.3);
      expect(s2.iconBorderOpacity, 0.9);
    });

    test('AppStyle equality considers iconBorderOpacity', () {
      const a = AppStyle(iconBgOpacity: 0.1, iconBorderOpacity: 0.2);
      const b = AppStyle(iconBgOpacity: 0.1, iconBorderOpacity: 0.3);
      expect(a == b, isFalse);
      const c = AppStyle(iconBgOpacity: 0.1, iconBorderOpacity: 0.2);
      expect(a == c, isTrue);
    });

    test('FColors copyWith keeps other fields', () {
      const a = AppColors(
        income: TWind.emerald600,
        expense: TWind.red600,
        transfer: TWind.blue500,
        success: TWind.emerald500,
        warning: TWind.amber500,
      );
      final b = a.copyWith(expense: TWind.red400);
      expect(b.expense, TWind.red400);
      expect(b.income, TWind.emerald600);
    });
  });

  group('PokaTypographyRoles', () {
    final typography = lightTheme.typography;

    test('font families are configured for display (Plus Jakarta Sans) and body (Inter)', () {
      expect(typography.display.md.fontFamily, contains('PlusJakartaSans'));
      expect(typography.body.md.fontFamily, contains('Inter'));
      expect(typography.display.md.fontFeatures, contains(const FontFeature.tabularFigures()));
      expect(typography.body.md.fontFeatures, contains(const FontFeature.tabularFigures()));
    });

    test('amountHero is body.xl2 bold with tight tracking and tabular figures', () {
      final style = typography.amountHero;
      expect(style.fontSize, typography.body.xl2.fontSize);
      expect(style.fontWeight, FontWeight.w800);
      expect(style.letterSpacing, -1);
      expect(style.height, 1);
      expect(style.fontFeatures, contains(const FontFeature.tabularFigures()));
    });

    test('amountSection is body.xl bold with tabular figures', () {
      final style = typography.amountSection;
      expect(style.fontSize, typography.body.xl.fontSize);
      expect(style.fontWeight, FontWeight.w700);
      expect(style.letterSpacing, -0.5);
      expect(style.height, 1);
      expect(style.fontFeatures, contains(const FontFeature.tabularFigures()));
    });

    test('title roles derive from display/body scales', () {
      expect(typography.titleScreen.fontWeight, FontWeight.w600);
      expect(typography.titleScreen.fontFamily, contains('PlusJakartaSans'));
      expect(typography.titleCard.fontWeight, FontWeight.w600);
      expect(typography.titleCard.fontFamily, contains('PlusJakartaSans'));
      expect(typography.titleItem.fontWeight, FontWeight.w600);
      expect(typography.titleScreen.fontSize, typography.display.lg.fontSize);
    });

    test('body roles map to body scale', () {
      expect(typography.bodyPrimary, typography.body.sm);
      expect(typography.bodySecondary, typography.body.xs);
      expect(typography.bodyPrimary.fontFamily, contains('Inter'));
    });

    test('label roles have semantic styling', () {
      expect(typography.labelSection.fontSize, 12);
      expect(typography.labelSection.fontWeight, FontWeight.w700);
      expect(typography.labelSection.fontFamily, contains('PlusJakartaSans'));
      expect(typography.labelField.fontSize, 12);
      expect(typography.labelField.fontWeight, FontWeight.w600);
      expect(typography.caption, typography.body.xs2);
      expect(typography.labelBadge.fontSize, 9);
    });

    test('amount roles have semantic styling with tabular figures', () {
      expect(typography.amountTile.fontSize, 13);
      expect(typography.amountTile.fontWeight, FontWeight.w600);
      expect(typography.amountTile.fontFeatures, contains(const FontFeature.tabularFigures()));
      expect(typography.amountCard.fontSize, 15);
      expect(typography.amountCard.fontWeight, FontWeight.w700);
      expect(typography.amountCard.fontFeatures, contains(const FontFeature.tabularFigures()));
    });

    test('dark theme exposes the same roles', () {
      final dark = darkTheme.typography;
      expect(dark.amountHero.fontWeight, FontWeight.w800);
      expect(dark.amountHero.fontFeatures, contains(const FontFeature.tabularFigures()));
      expect(dark.amountSection.fontWeight, FontWeight.w700);
      expect(dark.titleScreen.fontWeight, FontWeight.w600);
      expect(dark.labelSection.fontFamily, contains('PlusJakartaSans'));
    });
  });
}
