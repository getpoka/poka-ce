import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/pickers/account_selector_shelf.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  AccountModel createAccount(
    String id,
    String name, {
    int balance = 0,
    String? parentId,
    AccountType type = AccountType.assets,
    bool isDefault = false,
  }) {
    return AccountModel(
      id: id,
      name: name,
      type: type,
      balance: balance,
      parentId: parentId,
      isDefault: isDefault,
      createdAt: DateTime.utc(2024, 1, 1),
      updatedAt: DateTime.utc(2024, 1, 1),
    );
  }

  Widget createWidget({
    required List<AccountModel> accounts,
    String? selectedAccountId,
    ValueChanged<AccountModel>? onAccountSelected,
  }) {
    return TranslationProvider(
      child: MaterialApp(
        home: Scaffold(
          body: FTheme(
            data: lightTheme,
            child: AccountSelectorShelf(
              accounts: accounts,
              selectedAccountId: selectedAccountId,
              onAccountSelected: onAccountSelected ?? (_) {},
            ),
          ),
        ),
      ),
    );
  }

  group('AccountSelectorShelf', () {
    testWidgets('renders empty placeholder when accounts list is empty', (tester) async {
      await tester.pumpWidget(createWidget(accounts: []));
      await tester.pumpAndSettle();

      expect(find.text(t.accounts.noAccountsFound1), findsOneWidget);
    });

    testWidgets('excludes goal pockets from child pocket selector', (tester) async {
      final bca = createAccount('bca', 'BCA');
      final dailyPocket = createAccount('daily', 'Daily Spending', parentId: 'bca');
      final goalPocket = createAccount('goal_car', 'New Car Goal', parentId: 'bca', type: AccountType.goal);

      AccountModel? selected;
      await tester.pumpWidget(
        createWidget(
          accounts: [bca, dailyPocket, goalPocket],
          selectedAccountId: 'daily',
          onAccountSelected: (acc) => selected = acc,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('BCA'), findsOneWidget);
      expect(find.text('Daily Spending'), findsOneWidget);
      expect(find.text('New Car Goal'), findsNothing);

      await tester.tap(find.text('Daily Spending'));
      expect(selected?.id, 'daily');
    });
  });
}
