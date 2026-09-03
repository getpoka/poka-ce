import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/accounts/domain/account_aggregate.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/sections/goal_account_section.dart';
import 'package:poka_ce/features/goals/domain/goal_model.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class _FakeGoalNotifier extends GoalNotifier {
  final List<GoalModel> goals;
  _FakeGoalNotifier(this.goals);
  @override
  Stream<List<GoalModel>> build() => Stream.value(goals);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  AccountModel goalAccount(String id, String name, {int balance = 0}) => AccountModel(
    id: id,
    name: name,
    type: AccountType.goal,
    balance: balance,
    isActive: true,
    createdAt: DateTime.utc(2024, 1, 1),
    updatedAt: DateTime.utc(2024, 1, 1),
  );

  GoalModel goal(String id, String accountId, String name) => GoalModel(
    id: id,
    accountId: accountId,
    name: name,
    targetAmount: 1000,
    createdAt: DateTime.utc(2024, 1, 1),
    updatedAt: DateTime.utc(2024, 1, 1),
  );

  Widget buildApp(List<AccountAggregate> aggregates, {List<GoalModel> goals = const []}) {
    final container = ProviderContainer(
      overrides: [goalProvider.overrideWith(() => _FakeGoalNotifier(goals))],
    );
    return UncontrolledProviderScope(
      container: container,
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: Scaffold(
            body: SingleChildScrollView(
              child: GoalAccountSection(aggregates: aggregates, totalAssets: 2000),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('collapsed by default shows only section header', (tester) async {
    final aggregate = AccountAggregate(account: goalAccount('g1', 'Trip Fund', balance: 500));
    await tester.pumpWidget(buildApp([aggregate]));
    await tester.pumpAndSettle();

    expect(find.text('GOALS & SAVINGS'), findsOneWidget);
    expect(find.text('Trip Fund'), findsNothing);
  });

  testWidgets('expanding reveals goal account mini cards', (tester) async {
    final aggregate = AccountAggregate(account: goalAccount('g1', 'Trip Fund', balance: 500));
    await tester.pumpWidget(buildApp([aggregate]));
    await tester.pumpAndSettle();

    await tester.tap(find.text('GOALS & SAVINGS'));
    await tester.pumpAndSettle();

    expect(find.text('Trip Fund'), findsOneWidget);
    expect(find.text('25% of assets'), findsOneWidget);
  });

  testWidgets('collapsing again hides the cards', (tester) async {
    final aggregate = AccountAggregate(account: goalAccount('g1', 'Trip Fund', balance: 500));
    await tester.pumpWidget(buildApp([aggregate]));
    await tester.pumpAndSettle();

    await tester.tap(find.text('GOALS & SAVINGS'));
    await tester.pumpAndSettle();
    expect(find.text('Trip Fund'), findsOneWidget);

    await tester.tap(find.text('GOALS & SAVINGS'));
    await tester.pumpAndSettle();
    expect(find.text('Trip Fund'), findsNothing);
  });
}
