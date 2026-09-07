import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/dialogs/poka_insufficient_balance_dialog.dart';
import 'package:poka_ce/theme/theme.dart';

Widget wrapHost({
  required void Function(bool?) onResult,
  String? confirmText,
  String? cancelText,
}) {
  return TranslationProvider(
    child: MaterialApp(
      builder: (context, c) => FTheme(data: lightTheme, child: c!),
      home: Scaffold(
        body: Builder(
          builder: (context) => Center(
            child: ElevatedButton(
              onPressed: () async {
                final r = await showPokaInsufficientBalanceDialog(
                  context,
                  accountName: 'Main Wallet',
                  formattedAmount: 'Rp 50.000',
                  formattedBalance: 'Rp 10.000',
                  confirmText: confirmText,
                  cancelText: cancelText,
                );
                onResult(r);
              },
              child: const Text('Open Dialog'),
            ),
          ),
        ),
      ),
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => LocaleSettings.setLocaleSync(AppLocale.en));

  group('showPokaInsufficientBalanceDialog', () {
    testWidgets('shows headline, details and negative balance warning', (tester) async {
      await tester.pumpWidget(wrapHost(onResult: (_) {}));
      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Insufficient Balance'), findsOneWidget);
      expect(
        find.textContaining('Main Wallet'),
        findsOneWidget,
      );
      expect(
        find.textContaining('Rp 50.000'),
        findsOneWidget,
      );
      expect(
        find.textContaining('Rp 10.000'),
        findsOneWidget,
      );
      expect(
        find.text('Your account balance will become negative if you proceed.'),
        findsOneWidget,
      );
      expect(find.text('Check Again'), findsOneWidget);
      expect(find.text('Continue Anyway'), findsOneWidget);
    });

    testWidgets('clicking Continue Anyway pops with true', (tester) async {
      bool? result;
      await tester.pumpWidget(wrapHost(onResult: (v) => result = v));
      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Continue Anyway'));
      await tester.pumpAndSettle();

      expect(result, isTrue);
    });

    testWidgets('clicking Check Again pops with false', (tester) async {
      bool? result;
      await tester.pumpWidget(wrapHost(onResult: (v) => result = v));
      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Check Again'));
      await tester.pumpAndSettle();

      expect(result, isFalse);
    });

    testWidgets('custom confirmText and cancelText override default labels', (tester) async {
      await tester.pumpWidget(
        wrapHost(
          onResult: (_) {},
          confirmText: 'Yes, proceed',
          cancelText: 'Go back',
        ),
      );
      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Yes, proceed'), findsOneWidget);
      expect(find.text('Go back'), findsOneWidget);
    });
  });
}
