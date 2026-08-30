import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/features/settings/presentation/screens/licenses_page.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.en));

  Widget wrap() {
    return TranslationProvider(
      child: MaterialApp(
        builder: (context, child) => FTheme(data: lightTheme, child: child!),
        home: const LicensesScreen(),
      ),
    );
  }

  group('LicensesScreen', () {
    testWidgets('shows loading then empty state when no licenses registered', (tester) async {
      await tester.pumpWidget(wrap());
      await tester.pumpAndSettle();

      expect(find.text('Open Source Licenses'), findsOneWidget);
      expect(find.text('No licenses found'), findsOneWidget);
    });

    testWidgets('lists grouped licenses and expands on tap', (tester) async {
      LicenseRegistry.addLicense(
        () => Stream<LicenseEntry>.value(
          LicenseEntryWithLineBreaks(
            ['mit'],
            'MIT License\nPermission is hereby granted...',
          ),
        ),
      );

      await tester.pumpWidget(wrap());
      await tester.pumpAndSettle();

      expect(find.text('mit'), findsOneWidget);
      expect(find.text('MIT License'), findsWidgets);

      // Collapsed: license body hidden.
      expect(find.textContaining('Permission is hereby granted'), findsNothing);

      // Expand the tile.
      await tester.tap(find.text('mit'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Permission is hereby granted'), findsWidgets);
      expect(find.byIcon(FPhosphorIcons.caretUp), findsOneWidget);
    });
  });
}
