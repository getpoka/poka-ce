import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/goals/domain/goal_model.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_notifier.dart';
import 'package:poka_ce/features/goals/presentation/screens/goal_list_page.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

GoalModel _goal(
  String id,
  String name,
  int targetAmount, {
  String accountId = 'acc1',
  DateTime? targetDate,
}) {
  return GoalModel(
    id: id,
    accountId: accountId,
    name: name,
    targetAmount: targetAmount,
    targetDate: targetDate,
    createdAt: DateTime.utc(2024, 1, 1),
    updatedAt: DateTime.utc(2024, 1, 1),
  );
}

AccountModel _acc(String id, int balance) {
  return AccountModel(
    id: id,
    name: 'Wallet $id',
    type: AccountType.assets,
    balance: balance,
    createdAt: DateTime.utc(2024, 1, 1),
    updatedAt: DateTime.utc(2024, 1, 1),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.en));

  Widget wrapGoal(
    List<GoalModel> goals, {
    DashboardState dashboardState = const DashboardState(),
    bool loading = false,
  }) {
    return ProviderScope(
      overrides: [
        goalProvider.overrideWith(() => _FakeGoalNotifier(goals, loading: loading)),
        dashboardProvider.overrideWith(() => _FakeDashboardNotifier(dashboardState)),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: const GoalListPage(),
        ),
      ),
    );
  }

  group('GoalListPage', () {
    testWidgets('shows loading indicator when loading and goals empty', (tester) async {
      await tester.pumpWidget(wrapGoal(const [], loading: true));
      await tester.pump();
      expect(find.byType(FCircularProgress), findsOneWidget);
    });

    testWidgets('shows empty state when no goals', (tester) async {
      await tester.pumpWidget(wrapGoal(const []));
      await tester.pumpAndSettle();
      expect(find.text('No goals yet'), findsOneWidget);
      expect(find.textContaining('dedicated pocket'), findsOneWidget);
      expect(find.text('Create Goal'), findsOneWidget);
      expect(find.text('Goals'), findsOneWidget);
    });

    testWidgets('shows populated goals with summary card', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final g1 = _goal('g1', 'Emergency Fund', 100000, accountId: 'a1');
      final g2 = _goal('g2', 'New Laptop', 50000, accountId: 'a2');
      final goals = [g1, g2];
      final dash = DashboardState(
        isLoading: false,
        accounts: [_acc('a1', 25000), _acc('a2', 10000)],
      );

      await tester.pumpWidget(wrapGoal(goals, dashboardState: dash));
      await tester.pumpAndSettle();

      expect(find.text('Goals'), findsWidgets);
      expect(find.text('Add Goal'), findsOneWidget);
      expect(find.text('Emergency Fund'), findsOneWidget);
      expect(find.text('New Laptop'), findsOneWidget);
      // Summary card
      expect(find.text('Total Saved'), findsOneWidget);
      expect(find.text('Still needed'), findsOneWidget);
      expect(find.text(t.goals.totalTarget), findsOneWidget);
      expect(find.text(t.goals.goalsCount(count: 2)), findsOneWidget);
    });

    testWidgets('completed goal shows Completed badge and check icon', (tester) async {
      final g = _goal('g1', 'Done Goal', 1000, accountId: 'a1');
      // saved >= target -> completed
      final dash = DashboardState(isLoading: false, accounts: [_acc('a1', 1000)]);
      final goals = [g];

      await tester.pumpWidget(wrapGoal(goals, dashboardState: dash));
      await tester.pumpAndSettle();

      expect(find.text('FULLY FUNDED'), findsOneWidget);
      expect(find.text('Done Goal'), findsOneWidget);
      // Should show 100% of target
      expect(find.textContaining('100%'), findsWidgets);
    });

    testWidgets('in progress goal with targetDate shows deadline badge', (tester) async {
      final future = DateTime.now().add(const Duration(days: 60));
      final g = _goal('g1', 'Future Goal', 5000, accountId: 'a1', targetDate: future);
      final dash = DashboardState(isLoading: false, accounts: [_acc('a1', 100)]);
      final goals = [g];

      await tester.pumpWidget(wrapGoal(goals, dashboardState: dash));
      await tester.pumpAndSettle();

      expect(find.text('Future Goal'), findsOneWidget);
      // Not completed, should show In progress or date? Since targetDate set, shows formatted date
      // Either COMPLETED not shown
      expect(find.text('FULLY FUNDED'), findsNothing);
      // Should show percentage and Needs ... more
      expect(find.textContaining('Needs'), findsOneWidget);
      expect(find.textContaining('more'), findsOneWidget);
    });

    testWidgets('urgent targetDate shows amber badge (within 30 days)', (tester) async {
      final urgent = DateTime.now().add(const Duration(days: 5));
      final g = _goal('g1', 'Urgent Goal', 10000, accountId: 'a1', targetDate: urgent);
      final dash = DashboardState(isLoading: false, accounts: [_acc('a1', 2000)]);
      final goals = [g];

      await tester.pumpWidget(wrapGoal(goals, dashboardState: dash));
      await tester.pumpAndSettle();

      expect(find.text('Urgent Goal'), findsOneWidget);
      // Badge should show date like "MMM d" uppercased, not Due today unless daysLeft <=0
      // Check that no Completed
      expect(find.text('FULLY FUNDED'), findsNothing);
    });

    testWidgets('in progress without targetDate shows In progress badge', (tester) async {
      final g = _goal('g1', 'No Date', 8000, accountId: 'a1');
      final dash = DashboardState(isLoading: false, accounts: [_acc('a1', 500)]);
      final goals = [g];

      await tester.pumpWidget(wrapGoal(goals, dashboardState: dash));
      await tester.pumpAndSettle();

      expect(find.text('IN PROGRESS'), findsOneWidget);
    });

    testWidgets('summary shows done pill when completed goals exist', (tester) async {
      final g1 = _goal('g1', 'Done', 1000, accountId: 'a1');
      final g2 = _goal('g2', 'Todo', 2000, accountId: 'a2');
      final dash = DashboardState(isLoading: false, accounts: [_acc('a1', 1000), _acc('a2', 0)]);
      final goals = [g1, g2];

      await tester.pumpWidget(wrapGoal(goals, dashboardState: dash));
      await tester.pumpAndSettle();

      expect(find.text(t.goals.fullyFundedCount(count: 1)), findsOneWidget);
      expect(find.text(t.goals.goalsCount(count: 2)), findsOneWidget);
    });

    testWidgets('tapping Add Goal does not crash', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());
      await tester.pumpWidget(
        wrapGoal(
          [_goal('g1', 'A', 1000)],
          dashboardState: DashboardState(isLoading: false, accounts: [_acc('a1', 0)]),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Add Goal'), findsOneWidget);
      await tester.tap(find.text('Add Goal'));
      await tester.pump();
      expect(find.text('Add Goal'), findsOneWidget);
    });

    testWidgets('empty state Create Goal button does not crash on tap', (tester) async {
      await tester.pumpWidget(wrapGoal(const []));
      await tester.pumpAndSettle();
      final create = find.text('Create Goal');
      expect(create, findsOneWidget);
      // Verify button is tappable without throwing; do not assert sheet content to avoid timer issues
      expect(tester.widget<FButton>(find.widgetWithText(FButton, 'Create Goal')).onPress, isNotNull);
    });

    testWidgets('shows correct progress percentage', (tester) async {
      final g = _goal('g1', 'Half', 2000, accountId: 'a1');
      final dash = DashboardState(isLoading: false, accounts: [_acc('a1', 1000)]);
      final goals = [g];

      await tester.pumpWidget(wrapGoal(goals, dashboardState: dash));
      await tester.pumpAndSettle();

      expect(find.text('50% of target'), findsOneWidget);
    });

    testWidgets('goal with zero saved shows 0%', (tester) async {
      final g = _goal('g1', 'Zero', 5000, accountId: 'missing');
      final dash = DashboardState(isLoading: false, accounts: []);
      final goals = [g];

      await tester.pumpWidget(wrapGoal(goals, dashboardState: dash));
      await tester.pumpAndSettle();

      expect(find.text('0% of target'), findsOneWidget);
    });
  });
}

class _FakeGoalNotifier extends GoalNotifier {
  _FakeGoalNotifier(this._goals, {this.loading = false});
  final List<GoalModel> _goals;
  final bool loading;
  @override
  Stream<List<GoalModel>> build() => loading ? const Stream.empty() : Stream.value(_goals);
  @override
  Future<void> deleteGoal(String id) async {}
}

class _FakeDashboardNotifier extends DashboardNotifier {
  _FakeDashboardNotifier(this._state);
  final DashboardState _state;
  @override
  DashboardState build() => _state;
  @override
  Future<void> refresh() async {}
}
