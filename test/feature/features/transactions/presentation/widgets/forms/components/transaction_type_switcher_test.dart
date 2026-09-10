import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/forms/components/transaction_type_switcher.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

Widget _wrap(Widget child) {
  return TranslationProvider(
    child: MaterialApp(
      builder: (context, c) => FTheme(data: lightTheme, child: c!),
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await LocaleSettings.setLocale(AppLocale.id);
    await LocaleSettings.setLocale(AppLocale.en);
  });

  tearDown(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  group('TransactionTypeSwitcher', () {
    testWidgets('renders English tab labels by default', (tester) async {
      LocaleSettings.setLocaleSync(AppLocale.en);
      var selected = TransactionType.expense;

      await tester.pumpWidget(
        _wrap(
          TransactionTypeSwitcher(
            selectedType: selected,
            onChanged: (type) => selected = type,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Income'), findsOneWidget);
      expect(find.text('Expense'), findsOneWidget);
      expect(find.text('Transfer'), findsOneWidget);
    });

    testWidgets('renders Indonesian tab labels when locale is id', (tester) async {
      LocaleSettings.setLocaleSync(AppLocale.id);
      var selected = TransactionType.income;

      await tester.pumpWidget(
        _wrap(
          TransactionTypeSwitcher(
            selectedType: selected,
            onChanged: (type) => selected = type,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Pemasukan'), findsOneWidget);
      expect(find.text('Pengeluaran'), findsOneWidget);
      expect(find.text('Transfer'), findsOneWidget);
    });

    testWidgets('calls onChanged when a different tab is tapped', (tester) async {
      LocaleSettings.setLocaleSync(AppLocale.en);
      TransactionType? changedType;

      await tester.pumpWidget(
        _wrap(
          TransactionTypeSwitcher(
            selectedType: TransactionType.expense,
            onChanged: (type) => changedType = type,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Income'));
      await tester.pumpAndSettle();

      expect(changedType, TransactionType.income);
    });

    testWidgets('disables interaction and sets opacity when disabled is true', (tester) async {
      await tester.pumpWidget(
        _wrap(
          TransactionTypeSwitcher(
            selectedType: TransactionType.expense,
            onChanged: (_) {},
            disabled: true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final ignorePointer = tester.widget<IgnorePointer>(
        find.descendant(of: find.byType(TransactionTypeSwitcher), matching: find.byType(IgnorePointer)).first,
      );
      expect(ignorePointer.ignoring, isTrue);

      final opacity = tester.widget<Opacity>(
        find.descendant(of: find.byType(TransactionTypeSwitcher), matching: find.byType(Opacity)).first,
      );
      expect(opacity.opacity, 0.6);
    });
  });
}
