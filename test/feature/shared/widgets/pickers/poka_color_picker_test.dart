import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/pickers/poka_color_picker.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.en));

  Widget wrap({String? selectedColor, required ValueChanged<String> onSelected}) {
    return TranslationProvider(
      child: MaterialApp(
        builder: (context, child) => FTheme(data: lightTheme, child: child!),
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: PokaColorPicker(
              selectedColor: selectedColor,
              onColorSelected: onSelected,
            ),
          ),
        ),
      ),
    );
  }

  group('PokaColorPicker', () {
    testWidgets('renders preset colors and custom item', (tester) async {
      String? selected;
      await tester.pumpWidget(wrap(onSelected: (c) => selected = c));
      await tester.pump();

      expect(find.byType(PokaColorPicker), findsOneWidget);
      // 9 presets + 1 custom = 10 swatch containers (36x36)
      expect(find.byType(GestureDetector), findsWidgets);
      expect(find.byIcon(FPhosphorIcons.palette), findsOneWidget);
      // 9 preset circles have no check icon (nothing selected)
      expect(find.byIcon(FPhosphorIcons.check), findsNothing);
    });

    testWidgets('selecting a preset invokes the callback', (tester) async {
      String? selected;
      await tester.pumpWidget(wrap(onSelected: (c) => selected = c));
      await tester.pump();

      // Tap the first color swatch (a 36x36 circle). There are 10 items total.
      final swatches = find.byType(GestureDetector);
      await tester.tap(swatches.first);
      await tester.pump();

      expect(selected, isNotNull);
      expect(selected, matches(RegExp(r'^#[0-9A-F]{6}$')));
    });

    testWidgets('marks the selected preset with a check icon', (tester) async {
      await tester.pumpWidget(
        wrap(selectedColor: '#3B82F6', onSelected: (_) {}),
      );
      await tester.pump();

      expect(find.byIcon(FPhosphorIcons.check), findsOneWidget);
    });

    testWidgets('marks a custom color as selected', (tester) async {
      await tester.pumpWidget(
        wrap(selectedColor: '#123456', onSelected: (_) {}),
      );
      await tester.pump();

      // Custom color selected -> shows a check inside the custom swatch.
      expect(find.byIcon(FPhosphorIcons.check), findsWidgets);
      expect(find.byIcon(FPhosphorIcons.palette), findsNothing);
    });

    testWidgets('opening custom sheet and applying returns hex color', (tester) async {
      String? selected;
      await tester.pumpWidget(wrap(onSelected: (c) => selected = c));
      await tester.pump();

      await tester.tap(find.byIcon(FPhosphorIcons.palette));
      await tester.pumpAndSettle();

      expect(find.text('Custom Color'), findsOneWidget);
      expect(find.text('Hex Color Code'), findsOneWidget);

      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();

      expect(selected, isNotNull);
      expect(selected, matches(RegExp(r'^#[0-9A-F]{6}$')));
    });

    testWidgets('custom sheet cancel closes without selecting', (tester) async {
      String? selected;
      await tester.pumpWidget(wrap(onSelected: (c) => selected = c));
      await tester.pump();

      await tester.tap(find.byIcon(FPhosphorIcons.palette));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(find.text('Custom Color'), findsNothing);
      expect(selected, isNull);
    });
  });
}
