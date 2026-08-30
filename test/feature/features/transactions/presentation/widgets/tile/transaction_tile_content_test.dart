import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/tile/transaction_tile_content.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.en));

  Widget wrap({
    required String catLabel,
    required Color catColor,
    bool hasMultipleItems = false,
    int itemCount = 1,
    required int amount,
    required TransactionType type,
    bool isBalanceVisible = true,
    bool isTransfer = false,
    String? accLabel,
    IconData? accIcon,
    Color? accColor,
    String? destAccLabel,
    Color? destAccColor,
    String? timeStr,
    String? note,
    TransactionAllocation? allocation,
    bool hasDebt = false,
    bool isRecurring = false,
  }) {
    return ProviderScope(
      overrides: [
        balanceVisibilityProvider.overrideWithValue(isBalanceVisible),
        settingsProvider.overrideWith(() => _FakeSettingsNotifier()),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: TransactionTileContent(
                catLabel: catLabel,
                catColor: catColor,
                hasMultipleItems: hasMultipleItems,
                itemCount: itemCount,
                amount: amount,
                type: type,
                isBalanceVisible: isBalanceVisible,
                isTransfer: isTransfer,
                accLabel: accLabel,
                accIcon: accIcon,
                accColor: accColor,
                destAccLabel: destAccLabel,
                destAccColor: destAccColor,
                timeStr: timeStr,
                note: note,
                allocation: allocation,
                hasDebt: hasDebt,
                isRecurring: isRecurring,
              ),
            ),
          ),
        ),
      ),
    );
  }

  group('TransactionTileContent', () {
    testWidgets('renders category, amount and note', (tester) async {
      await tester.pumpWidget(
        wrap(
          catLabel: 'Groceries',
          catColor: Colors.green,
          amount: 50000,
          type: TransactionType.expense,
          note: 'weekly shop',
        ),
      );
      await tester.pump();

      expect(find.text('Groceries'), findsOneWidget);
      expect(find.text('weekly shop'), findsOneWidget);
      expect(find.textContaining('50,000'), findsOneWidget);
    });

    testWidgets('shows item count badge for multiple items', (tester) async {
      await tester.pumpWidget(
        wrap(
          catLabel: 'Split',
          catColor: Colors.blue,
          hasMultipleItems: true,
          itemCount: 3,
          amount: 9000,
          type: TransactionType.expense,
        ),
      );
      await tester.pump();

      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('renders account label and time', (tester) async {
      await tester.pumpWidget(
        wrap(
          catLabel: 'Food',
          catColor: Colors.red,
          amount: 100,
          type: TransactionType.expense,
          accLabel: 'Cash Wallet',
          accIcon: FPhosphorIcons.wallet,
          accColor: Colors.indigo,
          timeStr: '10:00',
        ),
      );
      await tester.pump();

      expect(find.text('Cash Wallet'), findsOneWidget);
      expect(find.text('10:00'), findsOneWidget);
    });

    testWidgets('renders transfer destination', (tester) async {
      await tester.pumpWidget(
        wrap(
          catLabel: 'Transfer',
          catColor: Colors.amber,
          amount: 1000,
          type: TransactionType.transfer,
          isTransfer: true,
          accLabel: 'Bank',
          accIcon: FPhosphorIcons.bank,
          accColor: Colors.orange,
          destAccLabel: 'Pocket',
          destAccColor: Colors.purple,
        ),
      );
      await tester.pump();

      expect(find.text('Bank'), findsOneWidget);
      expect(find.text('Pocket'), findsOneWidget);
      expect(find.byIcon(FPhosphorIcons.arrowRight), findsOneWidget);
    });

    testWidgets('renders debt and recurring badges', (tester) async {
      await tester.pumpWidget(
        wrap(
          catLabel: 'Loan',
          catColor: Colors.red,
          amount: 2000,
          type: TransactionType.expense,
          hasDebt: true,
          allocation: TransactionAllocation.need,
        ),
      );
      await tester.pump();

      expect(find.text('Debt'), findsOneWidget);
      expect(find.text('Need'), findsOneWidget);

      await tester.pumpWidget(
        wrap(
          catLabel: 'Sub',
          catColor: Colors.blue,
          amount: 1000,
          type: TransactionType.expense,
          isRecurring: true,
        ),
      );
      await tester.pump();

      expect(find.text('Recurring'), findsOneWidget);
    });

    testWidgets('obscures amount when balance hidden', (tester) async {
      await tester.pumpWidget(
        wrap(
          catLabel: 'Secret',
          catColor: Colors.black,
          amount: 999999,
          type: TransactionType.income,
          isBalanceVisible: false,
        ),
      );
      await tester.pump();

      expect(find.textContaining('••••••'), findsWidgets);
    });
  });
}

class _FakeSettingsNotifier extends SettingsNotifier {
  @override
  SettingsState build() => const SettingsState();
}
