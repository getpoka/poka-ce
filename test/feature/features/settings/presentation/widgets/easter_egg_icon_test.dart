import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/features/settings/presentation/widgets/easter_egg_icon.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  Widget buildApp() {
    return TranslationProvider(
      child: MaterialApp(
        builder: (context, child) => FTheme(
          data: lightTheme,
          child: FToaster(child: child!),
        ),
        home: const Scaffold(body: Center(child: EasterEggIcon())),
      ),
    );
  }

  Finder eggDialogImage() => find.byWidgetPredicate(
    (w) => w is Image && w.image is AssetImage && (w.image as AssetImage).assetName.contains('hasbullah'),
  );

  group('EasterEggIcon', () {
    testWidgets('renders the logo asset', (tester) async {
      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();

      expect(
        find.byWidgetPredicate(
          (w) => w is Image && w.image is AssetImage && (w.image as AssetImage).assetName.contains('logo'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('shows remaining taps toast on intermediate taps', (tester) async {
      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();

      // First tap starts the sequence (no toast). Second to fourth taps show toasts.
      await tester.tap(find.byType(EasterEggIcon));
      await tester.pump(const Duration(milliseconds: 100));
      await tester.tap(find.byType(EasterEggIcon));
      await tester.pump(const Duration(milliseconds: 100));
      await tester.tap(find.byType(EasterEggIcon));
      await tester.pump(const Duration(milliseconds: 100));
      await tester.tap(find.byType(EasterEggIcon));
      await tester.pumpAndSettle(const Duration(milliseconds: 100));

      expect(find.textContaining('taps away from a surprise'), findsOneWidget);
    });

    testWidgets('sequence resets after 2 seconds of inactivity', (tester) async {
      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(EasterEggIcon));
      await tester.pump(const Duration(milliseconds: 100));
      await tester.tap(find.byType(EasterEggIcon));
      await tester.pump(const Duration(milliseconds: 100));

      // Wait past the reset window.
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Fresh sequence: first tap again starts from zero, so no surprise dialog yet.
      await tester.tap(find.byType(EasterEggIcon));
      await tester.pump(const Duration(milliseconds: 100));
      await tester.tap(find.byType(EasterEggIcon));
      await tester.pumpAndSettle(const Duration(milliseconds: 100));

      expect(eggDialogImage(), findsNothing);
    });

    testWidgets('seven rapid taps reveal the easter egg dialog', (tester) async {
      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(EasterEggIcon));
      await tester.pump(const Duration(milliseconds: 50));
      for (var i = 0; i < 6; i++) {
        await tester.tap(find.byType(EasterEggIcon));
        await tester.pump(const Duration(milliseconds: 50));
      }
      await tester.pumpAndSettle();

      expect(find.textContaining('easter egg'), findsOneWidget);
      expect(eggDialogImage(), findsOneWidget);

      // The easter egg dialog is presented with the hasbullah asset.
      expect(eggDialogImage(), findsOneWidget);
    });
  });
}
