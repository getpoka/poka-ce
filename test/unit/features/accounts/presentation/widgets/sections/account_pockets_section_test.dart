import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/cards/account_mini_card.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/sections/account_pockets_section.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_empty_view.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  Widget createWidget({required String accountId, required List<AccountModel> pockets, int totalBalance = 1000000}) {
    return ProviderScope(
      overrides: [
        accountListProvider.overrideWith(() => _FakeAccountListNotifier(const AccountListState(accounts: []))),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          home: Scaffold(
            body: FTheme(
              data: lightTheme,
              child: SingleChildScrollView(
                child: AccountPocketsSection(accountId: accountId, pockets: pockets, totalBalance: totalBalance),
              ),
            ),
          ),
        ),
      ),
    );
  }

  group('AccountPocketsSection', () {
    testWidgets('shows empty state when no pockets are present', (tester) async {
      await tester.pumpWidget(createWidget(accountId: 'acc_1', pockets: []));
      await tester.pumpAndSettle();

      expect(find.text('POCKETS'), findsOneWidget);
      expect(find.text('Add Pocket'), findsOneWidget);
      expect(find.byType(PokaEmptyView), findsOneWidget);
      expect(find.text('No pockets yet'), findsOneWidget);
    });

    testWidgets('renders grid of AccountMiniCard when pockets exist', (tester) async {
      final pockets = [
        AccountModel(
          id: 'p1',
          name: 'Main Pocket',
          type: AccountType.assets,
          parentId: 'acc_1',
          balance: 600000,
          isDefault: true,
          createdAt: DateTime.utc(2024, 1, 1),
          updatedAt: DateTime.utc(2024, 1, 1),
        ),
        AccountModel(
          id: 'p2',
          name: 'Groceries',
          type: AccountType.assets,
          parentId: 'acc_1',
          balance: 400000,
          isDefault: false,
          createdAt: DateTime.utc(2024, 1, 1),
          updatedAt: DateTime.utc(2024, 1, 1),
        ),
      ];

      await tester.pumpWidget(createWidget(accountId: 'acc_1', pockets: pockets, totalBalance: 1000000));
      await tester.pumpAndSettle();

      expect(find.text('POCKETS'), findsOneWidget);
      expect(find.text('Main Pocket'), findsOneWidget);
      expect(find.text('Groceries'), findsOneWidget);
      expect(find.byType(AccountMiniCard), findsNWidgets(2));
    });
  });
}

class _FakeAccountListNotifier extends AccountListNotifier {
  _FakeAccountListNotifier(this._state);
  final AccountListState _state;

  @override
  Stream<AccountListState> build() => Stream.value(_state);
}
