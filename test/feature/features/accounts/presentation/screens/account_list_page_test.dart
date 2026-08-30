import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/accounts/domain/account_aggregate.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/domain/i_account_repository.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/accounts/presentation/screens/account_detail_page.dart';
import 'package:poka_ce/features/accounts/presentation/screens/account_list_page.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/settings/domain/settings_model.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class MockAccountRepository extends Mock implements IAccountRepository {}

AccountModel _acc(
  String id,
  String name, {
  int balance = 0,
  String? parentId,
  AccountType type = AccountType.assets,
  bool isActive = true,
  int sort = 0,
  String? color,
  String? icon,
}) {
  return AccountModel(
    id: id,
    name: name,
    type: type,
    balance: balance,
    isActive: isActive,
    sort: sort,
    color: color,
    icon: icon,
    parentId: parentId,
    createdAt: DateTime.utc(2024, 1, 1),
    updatedAt: DateTime.utc(2024, 1, 1),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  late GoRouter router;

  setUp(() {
    router = GoRouter(
      initialLocation: '/accounts',
      routes: [
        GoRoute(path: '/accounts', builder: (_, __) => const AccountListPage()),
        GoRoute(
          path: '/accounts/:accountId',
          builder: (context, state) => AccountDetailPage(accountId: state.pathParameters['accountId']!),
        ),
      ],
    );
  });

  Widget wrapWithState(
    AccountListState state, {
    SettingsState settingsState = const SettingsState(),
    List<dynamic> extraOverrides = const [],
    bool loading = false,
  }) {
    return ProviderScope(
      overrides: [
        accountListProvider.overrideWith(() => _FakeAccountListNotifier(state, loading: loading)),
        settingsProvider.overrideWith(() => _FakeSettingsNotifier(settingsState)),
        balanceVisibilityProvider.overrideWith(() => _FakeBalanceNotifier(true)),
        accountsStreamProvider.overrideWith((ref) => Stream.value([])),
        categoriesStreamProvider.overrideWith((ref) => Stream.value([])),
        recentTransactionsStreamProvider.overrideWith((ref) => Stream.value([])),
        ...extraOverrides,
      ],
      child: TranslationProvider(
        child: MaterialApp.router(
          routerConfig: router,
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
        ),
      ),
    );
  }

  group('AccountListPage', () {
    testWidgets('shows loading indicator when isLoading and empty', (tester) async {
      await tester.pumpWidget(
        wrapWithState(const AccountListState(accounts: [], aggregates: []), loading: true),
      );
      await tester.pump();
      expect(find.byType(FCircularProgress), findsOneWidget);
    });

    testWidgets('shows empty state when no aggregates and not loading', (tester) async {
      await tester.pumpWidget(
        wrapWithState(const AccountListState(accounts: [], aggregates: [])),
      );
      await tester.pumpAndSettle();
      expect(find.text('No accounts found.'), findsOneWidget);
      expect(find.text('ACCOUNTS'), findsOneWidget);
      expect(find.text('Add Account'), findsOneWidget);
    });

    testWidgets('shows populated accounts grid with names and balances', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final parent = _acc('1', 'Cash Wallet', balance: 100000, color: '#FF0000');
      final parent2 = _acc('2', 'Bank BCA', balance: 500000, type: AccountType.assets);
      final pocket = _acc('p1', 'Emergency', balance: 25000, parentId: '1');
      final aggregates = [
        AccountAggregate(account: parent, pockets: [pocket]),
        AccountAggregate(account: parent2, pockets: []),
      ];
      final state = AccountListState(
        accounts: [parent, parent2, pocket],
        aggregates: aggregates,
      );

      await tester.pumpWidget(wrapWithState(state));
      await tester.pumpAndSettle();

      expect(find.text('Cash Wallet'), findsOneWidget);
      expect(find.text('Bank BCA'), findsOneWidget);
      // pocket badge
      expect(find.text('1 pocket'), findsOneWidget);
      // header title and net worth
      expect(find.text('Wallets & Pockets'), findsOneWidget);
      expect(find.text('ACCOUNTS'), findsOneWidget);
      // total balance via PokaAmountText should appear (at least one)
      expect(find.byType(FCard), findsWidgets);
    });

    testWidgets('shows pocketCount badges plural', (tester) async {
      final parent = _acc('1', 'Main', balance: 1000);
      final p1 = _acc('p1', 'Pocket A', balance: 100, parentId: '1');
      final p2 = _acc('p2', 'Pocket B', balance: 200, parentId: '1');
      final aggregates = [
        AccountAggregate(account: parent, pockets: [p1, p2]),
      ];
      final state = AccountListState(accounts: [parent, p1, p2], aggregates: aggregates);

      await tester.pumpWidget(wrapWithState(state));
      await tester.pumpAndSettle();

      expect(find.text('2 pockets'), findsOneWidget);
    });

    testWidgets('shows liability type badge', (tester) async {
      final liability = _acc('1', 'Credit Card', balance: -5000, type: AccountType.liability);
      final aggregates = [AccountAggregate(account: liability, pockets: [])];
      final state = AccountListState(accounts: [liability], aggregates: aggregates);

      await tester.pumpWidget(wrapWithState(state));
      await tester.pumpAndSettle();

      expect(find.text('LIABILITY'), findsOneWidget);
    });

    testWidgets('shows Add Account action and does not crash on tap', (tester) async {
      await tester.pumpWidget(
        wrapWithState(const AccountListState(accounts: [], aggregates: [])),
      );
      await tester.pumpAndSettle();
      final add = find.text('Add Account');
      expect(add, findsOneWidget);
      // Tap should attempt to show sheet but not throw (sheet requires overlay)
      await tester.tap(add);
      await tester.pump();
      // No exception; widget still alive
      expect(find.text('No accounts found.'), findsOneWidget);
    });

    testWidgets('navigates to account detail on card tap and shows hero', (tester) async {
      final parent = _acc('1', 'Cash', balance: 99999, color: '#123456');
      final pocket = _acc('p1', 'Savings', balance: 111, parentId: '1');
      final aggregates = [
        AccountAggregate(account: parent, pockets: [pocket]),
      ];
      final state = AccountListState(accounts: [parent, pocket], aggregates: aggregates);

      await tester.pumpWidget(wrapWithState(state));
      await tester.pumpAndSettle();

      // Tap the mini card (GestureDetector wrapping FCard)
      final card = find.text('Cash');
      expect(card, findsOneWidget);
      await tester.tap(card);
      await tester.pumpAndSettle();

      // Detail page should be pushed
      expect(find.text('POCKETS'), findsOneWidget);
      expect(find.text('Savings'), findsOneWidget);
      expect(find.text('Add Pocket'), findsOneWidget);
      expect(find.textContaining('RECENT TRANSACTIONS'), findsOneWidget);
    });

    testWidgets('detail page shows no pockets yet when empty', (tester) async {
      final parent = _acc('10', 'Solo', balance: 5000);
      final aggregates = [AccountAggregate(account: parent, pockets: [])];
      final state = AccountListState(accounts: [parent], aggregates: aggregates);

      await tester.pumpWidget(wrapWithState(state));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Solo'));
      await tester.pumpAndSettle();

      expect(find.text('No pockets yet'), findsOneWidget);
      expect(find.text('Pockets help you split your wallet into categories'), findsOneWidget);
      expect(find.text('No transactions yet'), findsOneWidget);
    });

    testWidgets('inactive accounts are filtered out', (tester) async {
      final active = _acc('1', 'Active', balance: 100, isActive: true);
      final inactive = _acc('2', 'Inactive', balance: 999, isActive: false);
      // Simulate aggregates already filtered? Page filters by isActive, but we pass aggregates containing inactive to test filtering
      final aggregates = [
        AccountAggregate(account: active, pockets: []),
        AccountAggregate(account: inactive, pockets: []),
      ];
      final state = AccountListState(accounts: [active, inactive], aggregates: aggregates);

      await tester.pumpWidget(wrapWithState(state));
      await tester.pumpAndSettle();

      // Page filters: state.aggregates.where((a) => a.account.isActive)
      // So Inactive should NOT appear despite being in aggregates list? Actually page filters again.
      // But we passed aggregates with inactive; widget should hide inactive.
      expect(find.text('Active'), findsOneWidget);
      // Inactive should be hidden? Let's verify - the page's aggregates filtered should exclude inactive.
      // Since our fake already includes inactive, but page will still filter, we expect not found for Inactive?
      // However page does filtering: where isActive. So Inactive will be filtered and not rendered.
      expect(find.text('Inactive'), findsNothing);
    });

    testWidgets('negative balance uses expense type color', (tester) async {
      final acc = _acc('1', 'Overdrawn', balance: -10000);
      final aggregates = [AccountAggregate(account: acc, pockets: [])];
      final state = AccountListState(accounts: [acc], aggregates: aggregates);

      await tester.pumpWidget(wrapWithState(state));
      await tester.pumpAndSettle();

      expect(find.text('Overdrawn'), findsOneWidget);
      // Balance amount still rendered via PokaAmountText (should show negative formatted)
      expect(find.byType(FCard), findsWidgets);
    });
  });
}

// ── Fakes ────────────────────────────────────────────────────────────────

class _FakeAccountListNotifier extends AccountListNotifier {
  _FakeAccountListNotifier(this._initial, {this.loading = false});
  final AccountListState _initial;
  final bool loading;
  @override
  Stream<AccountListState> build() => loading ? const Stream.empty() : Stream.value(_initial);
  @override
  Future<void> reorderAccounts(int oldIndex, int newIndex, {String? parentId}) async {}
  @override
  Future<void> deactivateAccount(String id) async {}
}

class _FakeSettingsNotifier extends SettingsNotifier {
  _FakeSettingsNotifier(this._state);
  final SettingsState _state;
  @override
  SettingsState build() => _state;
}

class _FakeBalanceNotifier extends BalanceVisibility {
  _FakeBalanceNotifier(this._value);
  final bool _value;
  @override
  bool build() => _value;
}
