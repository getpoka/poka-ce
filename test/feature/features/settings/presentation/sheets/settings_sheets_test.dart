import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/features/settings/domain/currency_model.dart';
import 'package:poka_ce/features/settings/presentation/sheets/currency_picker_sheet.dart';
import 'package:poka_ce/features/settings/presentation/sheets/language_picker_sheet.dart';
import 'package:poka_ce/features/settings/presentation/sheets/number_format_picker_sheet.dart';
import 'package:poka_ce/features/settings/presentation/sheets/theme_picker_sheet.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';
import 'package:poka_ce/features/settings/presentation/widgets/currency_search_list.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.setLocale(AppLocale.en);

  Widget buildTestableWidget(Widget child) {
    return TranslationProvider(
      child: MaterialApp(
        builder: (context, child) => FTheme(
          data: lightTheme,
          child: child!,
        ),
        home: Scaffold(body: child),
      ),
    );
  }

  group('Settings Sheets', () {
    testWidgets('NumberFormatPickerSheet renders and pops value', (tester) async {
      String? result;
      await tester.pumpWidget(
        buildTestableWidget(
          Builder(
            builder: (context) => FButton(
              onPress: () async {
                result = await showNumberFormatPickerSheet(context, 'system');
              },
              child: const Text('Show'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      expect(find.text('App Default'), findsOneWidget);
      expect(find.text('1.000.000,00'), findsOneWidget);
      expect(find.text('1,000,000.00'), findsOneWidget);
      expect(find.text('1 000 000,00'), findsOneWidget);

      await tester.tap(find.text('1.000.000,00'));
      await tester.pumpAndSettle();

      expect(result, 'id_ID');
    });

    testWidgets('NumberFormatPickerSheet pops system format', (tester) async {
      String? result;
      await tester.pumpWidget(
        buildTestableWidget(
          Builder(
            builder: (context) => FButton(
              onPress: () async {
                result = await showNumberFormatPickerSheet(context, 'en_US');
              },
              child: const Text('Show'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('App Default'));
      await tester.pumpAndSettle();

      expect(result, 'system');
    });

    testWidgets('ThemePickerSheet renders and pops value', (tester) async {
      String? result;
      await tester.pumpWidget(
        buildTestableWidget(
          Builder(
            builder: (context) => FButton(
              onPress: () async {
                result = await showThemePickerSheet(context, 'system');
              },
              child: const Text('Show'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      expect(find.text('System'), findsOneWidget); // Assuming translation
      expect(find.text('Light'), findsOneWidget);
      expect(find.text('Dark'), findsOneWidget);

      await tester.tap(find.text('Light'));
      await tester.pumpAndSettle();

      expect(result, 'light');
    });

    testWidgets('LanguagePickerSheet renders and pops value', (tester) async {
      String? result;
      await tester.pumpWidget(
        buildTestableWidget(
          Builder(
            builder: (context) => FButton(
              onPress: () async {
                result = await showLanguagePickerSheet(context, 'en');
              },
              child: const Text('Show'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      expect(find.text('English'), findsOneWidget);
      expect(find.text('Indonesia'), findsOneWidget);

      await tester.tap(find.text('Indonesia'));
      await tester.pumpAndSettle();

      expect(result, 'id');
    });

    testWidgets('CurrencyPickerSheet renders and pops value', (tester) async {
      final currency = CurrencyModel(
        id: 'USD',
        code: 'USD',
        name: 'US Dollar',
        symbol: '\$',
        precision: 2,
      );
      CurrencyModel? result;
      await tester.pumpWidget(
        buildTestableWidget(
          Builder(
            builder: (context) => FButton(
              onPress: () async {
                result = await showCurrencyPickerSheet(context, [currency], currency);
              },
              child: const Text('Show'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      expect(find.text('US Dollar'), findsOneWidget);

      // The tapping on list tile in CurrencySearchList should pop the sheet
      await tester.tap(find.text('US Dollar'));
      await tester.pumpAndSettle();

      expect(result, currency);
    });
  });

  group('CurrencySearchList', () {
    testWidgets('renders list and filters by search', (tester) async {
      final currencies = [
        CurrencyModel(id: 'USD', code: 'USD', name: 'US Dollar', symbol: '\$', precision: 2),
        CurrencyModel(id: 'EUR', code: 'EUR', name: 'Euro', symbol: '€', precision: 2),
      ];

      CurrencyModel? selected;

      await tester.pumpWidget(
        buildTestableWidget(
          CurrencySearchList(
            currencies: currencies,
            selectedCurrency: currencies[0],
            onSelect: (c) => selected = c,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('US Dollar'), findsOneWidget);
      expect(find.text('Euro'), findsOneWidget);

      // Search for Euro
      await tester.enterText(find.byType(FTextField), 'Eur');
      await tester.pumpAndSettle();

      expect(find.text('US Dollar'), findsNothing);
      expect(find.text('Euro'), findsOneWidget);

      await tester.tap(find.text('Euro'));
      expect(selected, currencies[1]);

      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pump(const Duration(milliseconds: 200));
    });
  });
}
