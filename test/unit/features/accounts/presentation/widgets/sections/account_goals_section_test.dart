import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/sections/account_goals_section.dart';
import 'package:poka_ce/features/goals/domain/goal_model.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_notifier.dart';
import 'package:poka_ce/features/goals/presentation/widgets/goal_card.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_empty_view.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  Widget createWidget({required String accountId, List<GoalItemState> goalStates = const []}) {
    return ProviderScope(
      overrides: [goalListStatesProvider.overrideWithValue(goalStates)],
      child: TranslationProvider(
        child: MaterialApp(
          home: Scaffold(
            body: FTheme(
              data: lightTheme,
              child: SingleChildScrollView(child: AccountGoalsSection(accountId: accountId)),
            ),
          ),
        ),
      ),
    );
  }

  group('AccountGoalsSection', () {
    testWidgets('shows empty state when no goals are linked to account', (tester) async {
      await tester.pumpWidget(createWidget(accountId: 'parent_1', goalStates: []));
      await tester.pumpAndSettle();

      expect(find.text('GOALS'), findsOneWidget);
      expect(find.text('Add Goal'), findsOneWidget);
      expect(find.byType(PokaEmptyView), findsOneWidget);
      expect(find.text('No goals yet'), findsOneWidget);
    });

    testWidgets('renders GoalCard list when goals belong to account', (tester) async {
      final goal1 = GoalModel(
        id: 'g1',
        accountId: 'goal_acc_1',
        name: 'New Car',
        targetAmount: 200000000,
        parentAccountId: 'parent_1',
        createdAt: DateTime.utc(2024, 1, 1),
        updatedAt: DateTime.utc(2024, 1, 1),
      );
      final goal2 = GoalModel(
        id: 'g2',
        accountId: 'goal_acc_2',
        name: 'Emergency Fund',
        targetAmount: 50000000,
        parentAccountId: 'parent_1',
        createdAt: DateTime.utc(2024, 1, 1),
        updatedAt: DateTime.utc(2024, 1, 1),
      );
      final otherGoal = GoalModel(
        id: 'g3',
        accountId: 'goal_acc_3',
        name: 'Other Bank Goal',
        targetAmount: 10000000,
        parentAccountId: 'parent_2',
        createdAt: DateTime.utc(2024, 1, 1),
        updatedAt: DateTime.utc(2024, 1, 1),
      );

      final states = [
        GoalItemState(goal: goal1, currentBalance: 50000000),
        GoalItemState(goal: goal2, currentBalance: 10000000),
        GoalItemState(goal: otherGoal, currentBalance: 5000000),
      ];

      await tester.pumpWidget(createWidget(accountId: 'parent_1', goalStates: states));
      await tester.pumpAndSettle();

      expect(find.text('GOALS (2)'), findsOneWidget);
      expect(find.text('New Car'), findsOneWidget);
      expect(find.text('Emergency Fund'), findsOneWidget);
      expect(find.text('Other Bank Goal'), findsNothing);
      expect(find.byType(GoalCard), findsNWidgets(2));
    });
  });
}
