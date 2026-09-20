import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:go_router/go_router.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/accounts/domain/account_aggregate.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/accounts/presentation/screens/account_detail_page.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/goals/domain/goal_model.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_notifier.dart';
import 'package:poka_ce/features/settings/domain/settings_model.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

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

class _FakeAccountListNotifier extends AccountListNotifier {
  _FakeAccountListNotifier(this._state);
  final AccountListState _state;

  @override
  Stream<AccountListState> build() => Stream.value(_state);
}

class _FakeGoalNotifier extends GoalNotifier {
  _FakeGoalNotifier(this._goals);
  final List<GoalModel> _goals;

  @override
  Stream<List<GoalModel>> build() => Stream.value(_goals);
}

class _FakeSettingsNotifier extends SettingsNotifier {
  _FakeSettingsNotifier(this._state);
  final SettingsState _state;

  @override
  SettingsState build() => _state;
}

class _FakeBalanceNotifier extends BalanceVisibility {
  _FakeBalanceNotifier(this._val);
  final bool _val;

  @override
  bool build() => _val;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  Widget wrapWithState(
    String accountId,
    AccountListState state, {
    List<GoalModel> goals = const [],
    List<TransactionModel> transactions = const [],
  }) {
    final router = GoRouter(
      initialLocation: '/accounts/$accountId',
      routes: [
        GoRoute(
          path: '/accounts/:accountId',
          builder: (context, routerState) => AccountDetailPage(accountId: routerState.pathParameters['accountId']!),
        ),
      ],
    );

    return ProviderScope(
      overrides: [
        accountListProvider.overrideWith(() => _FakeAccountListNotifier(state)),
        goalProvider.overrideWith(() => _FakeGoalNotifier(goals)),
        settingsProvider.overrideWith(() => _FakeSettingsNotifier(const SettingsState())),
        balanceVisibilityProvider.overrideWith(() => _FakeBalanceNotifier(true)),
        accountsStreamProvider.overrideWith((ref) => Stream.value(state.accounts)),
        categoriesStreamProvider.overrideWith((ref) => Stream.value([])),
        recentTransactionsStreamProvider.overrideWith((ref) => Stream.value(transactions)),
      ],
      child: TranslationProvider(
        child: MaterialApp.router(
          routerConfig: router,
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
        ),
      ),
    );
  }

  group('AccountDetailPage', () {
    testWidgets('shows loading indicator when account is not found in state', (tester) async {
      await tester.pumpWidget(wrapWithState('non_existent', const AccountListState(accounts: [], aggregates: [])));
      await tester.pump();

      expect(find.byType(FCircularProgress), findsOneWidget);
    });

    testWidgets('renders root account with pockets section and total balance', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final parent = _acc('parent_1', 'BCA Main', balance: 500000, color: '#10B981');
      final pocket = _acc('pocket_1', 'Snacks', balance: 100000, parentId: 'parent_1');
      final state = AccountListState(
        accounts: [parent, pocket],
        aggregates: [
          AccountAggregate(account: parent, pockets: [pocket]),
        ],
      );

      await tester.pumpWidget(wrapWithState('parent_1', state));
      await tester.pumpAndSettle();

      expect(find.text('BCA Main'), findsWidgets);
      expect(find.text('Pockets'), findsWidgets);
      expect(find.text('Snacks'), findsOneWidget);
      expect(find.text('GOALS'), findsOneWidget);
      expect(find.byIcon(FPhosphorIcons.scales), findsOneWidget);
      expect(find.byIcon(FPhosphorIcons.pencilSimple), findsOneWidget);
    });

    testWidgets('renders root account with both operational pocket and goal cards', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final parent = _acc('parent_1', 'BCA Main', balance: 500000, color: '#10B981');
      final pocket = _acc('pocket_1', 'Snacks', balance: 100000, parentId: 'parent_1');
      final goalPocket = _acc(
        'goal_acc_1',
        'Dream Trip',
        balance: 250000,
        parentId: 'parent_1',
        type: AccountType.goal,
      );
      final goal = GoalModel(
        id: 'g1',
        accountId: 'goal_acc_1',
        name: 'Dream Trip',
        targetAmount: 1000000,
        parentAccountId: 'parent_1',
        createdAt: DateTime.utc(2024, 1, 1),
        updatedAt: DateTime.utc(2024, 1, 1),
      );

      final state = AccountListState(
        accounts: [parent, pocket, goalPocket],
        aggregates: [
          AccountAggregate(account: parent, pockets: [pocket, goalPocket]),
        ],
      );

      await tester.pumpWidget(wrapWithState('parent_1', state, goals: [goal]));
      await tester.pumpAndSettle();

      expect(find.text('BCA Main'), findsWidgets);
      expect(find.text('Pockets'), findsWidgets);
      expect(find.text('Snacks'), findsOneWidget);
      expect(find.text('GOALS (1)'), findsOneWidget);
      expect(find.text('Dream Trip'), findsOneWidget);
    });

    testWidgets('renders pocket account and hides pockets section', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final parent = _acc('parent_1', 'BCA Main', balance: 500000);
      final pocket = _acc('pocket_1', 'Snacks', balance: 100000, parentId: 'parent_1');
      final state = AccountListState(
        accounts: [parent, pocket],
        aggregates: [
          AccountAggregate(account: parent, pockets: [pocket]),
        ],
      );

      await tester.pumpWidget(wrapWithState('pocket_1', state));
      await tester.pumpAndSettle();

      expect(find.text('Snacks'), findsWidgets);
      expect(find.text('Add Pocket'), findsNothing);
    });

    testWidgets('renders goal account with target action icon', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final parent = _acc('parent_1', 'BCA Main', balance: 500000);
      final goalPocket = _acc('goal_acc_1', 'Vacation', balance: 250000, parentId: 'parent_1', type: AccountType.goal);
      final goal = GoalModel(
        id: 'g1',
        accountId: 'goal_acc_1',
        name: 'Vacation',
        targetAmount: 1000000,
        parentAccountId: 'parent_1',
        createdAt: DateTime.utc(2024, 1, 1),
        updatedAt: DateTime.utc(2024, 1, 1),
      );

      final state = AccountListState(
        accounts: [parent, goalPocket],
        aggregates: [
          AccountAggregate(account: parent, pockets: [goalPocket]),
        ],
      );

      await tester.pumpWidget(wrapWithState('goal_acc_1', state, goals: [goal]));
      await tester.pumpAndSettle();

      expect(find.text('Vacation'), findsWidgets);
      expect(find.byIcon(FPhosphorIcons.target), findsOneWidget);
      expect(find.byIcon(FPhosphorIcons.scales), findsNothing);
    });
  });
}
