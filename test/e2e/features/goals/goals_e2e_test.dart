import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';

import '../../test_setup.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:poka_ce/features/goals/presentation/widgets/cards/goal_card.dart';

void main() {
  testWidgets('Goal CRUD operations', (tester) async {
    final db = await pumpAppForTesting(tester);

    Future<void> settle() async {
      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 200));
      }
    }

    // 1. Navigate to Goals from Dashboard Quick Actions
    // Quick action uses FPhosphorIcons.target
    final goalAction = find.byIcon(FPhosphorIcons.target).first;
    await tester.ensureVisible(goalAction);
    await tester.tap(goalAction);
    await settle();

    // Verify Goal list page is shown (add button exists)
    expect(find.byKey(const Key('goal-add-button')), findsOneWidget);

    // 2. Create Goal
    await tester.tap(find.byKey(const Key('goal-add-button')));
    await settle();

    // Find text fields (0 = name, 1 = amount)
    final textFields = find.byType(FTextField);
    await tester.enterText(textFields.at(0), 'My E2E Goal');
    await tester.enterText(textFields.at(1), '5000000');
    await settle();

    // Tap save
    await tester.ensureVisible(find.text('Create Goal').last);
    await tester.tap(find.text('Create Goal').last);
    await settle();

    // Verify it appears in the list
    await tester.ensureVisible(find.text('My E2E Goal'));
    expect(find.text('My E2E Goal'), findsOneWidget);

    // 3. Update Goal
    final goalCard = find
        .ancestor(
          of: find.text('My E2E Goal'),
          matching: find.byType(GoalCard),
        )
        .first;

    // Slide left to reveal edit action
    await tester.drag(goalCard, const Offset(-500, 0));
    await settle();

    // Tap the edit icon (FPhosphorIcons.pencilSimple) in the action pane
    await tester.tap(find.byIcon(FPhosphorIcons.pencilSimple).first);
    await settle();

    // Edit text
    final editTextFields = find.byType(FTextField);
    await tester.enterText(editTextFields.at(0), 'My E2E Goal Edited');
    await settle();

    // Tap save changes
    await tester.ensureVisible(find.text('Save Changes'));
    await tester.tap(find.text('Save Changes'));
    await settle();

    await tester.ensureVisible(find.text('My E2E Goal Edited'));
    expect(find.text('My E2E Goal Edited'), findsOneWidget);

    // 4. Delete Goal
    final updatedGoalCard = find
        .ancestor(
          of: find.text('My E2E Goal Edited'),
          matching: find.byType(GoalCard),
        )
        .first;

    // Slide right to reveal delete action
    await tester.drag(updatedGoalCard, const Offset(500, 0));
    await settle();

    // Tap the trash icon
    await tester.tap(find.byIcon(FPhosphorIcons.trash).first);
    await settle();

    // Confirm deletion dialog
    await tester.tap(find.text('Delete'));
    await settle();

    // Verify it is removed
    expect(find.text('My E2E Goal Edited'), findsNothing);

    print('GOAL TEST FINISHED');
    await tearDownAppForTesting(tester, db);
  });
}
