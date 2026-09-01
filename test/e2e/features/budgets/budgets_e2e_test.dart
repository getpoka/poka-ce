import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';

import '../../test_setup.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:poka_ce/features/budgets/presentation/widgets/cards/budget_card.dart';

void main() {
  testWidgets('Budget CRUD operations', (tester) async {
    final db = await pumpAppForTesting(tester);

    Future<void> settle() async {
      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 200));
      }
    }

    // 1. Navigate to Budgets from Dashboard Quick Actions
    // Quick action uses FPhosphorIcons.chartPieSlice
    final budgetAction = find.byIcon(FPhosphorIcons.chartPieSlice).first;
    await tester.ensureVisible(budgetAction);
    await tester.tap(budgetAction);
    await settle();

    // Verify Budget list page is shown (add button exists)
    expect(find.byKey(const Key('budget-add-button')), findsOneWidget);

    // 2. Create Budget
    await tester.tap(find.byKey(const Key('budget-add-button')));
    await settle();

    // Find text fields (0 = name, 1 = amount, 2 = alertThreshold, 3 = resetDay)
    final textFields = find.byType(FTextFormField);
    await tester.enterText(textFields.at(0), 'My E2E Budget');
    await tester.enterText(textFields.at(1), '2000000');
    await settle();

    // Tap save
    await tester.ensureVisible(find.text('Create Budget').last);
    await tester.tap(find.text('Create Budget').last);
    await settle();

    // Verify it appears in the list
    await tester.ensureVisible(find.text('My E2E Budget').last);
    expect(find.text('My E2E Budget'), findsOneWidget);

    // 3. Update Budget
    final budgetCard = find
        .ancestor(
          of: find.text('My E2E Budget'),
          matching: find.byType(BudgetCard),
        )
        .first;

    // Slide left to reveal edit action
    await tester.drag(budgetCard, const Offset(-500, 0));
    await settle();

    // Tap the edit icon (FPhosphorIcons.pencilSimple) in the action pane
    await tester.tap(find.byIcon(FPhosphorIcons.pencilSimple).first);
    await settle();

    // Edit text
    final editTextFields = find.byType(FTextFormField);
    await tester.enterText(editTextFields.at(0), 'My E2E Budget Edited');
    await settle();

    // Tap save changes
    await tester.ensureVisible(find.text('Save Changes').last);
    await tester.tap(find.text('Save Changes').last);
    await settle();

    await tester.ensureVisible(find.text('My E2E Budget Edited').last);
    expect(find.text('My E2E Budget Edited'), findsOneWidget);

    // 4. Delete Budget
    final updatedBudgetCard = find
        .ancestor(
          of: find.text('My E2E Budget Edited'),
          matching: find.byType(BudgetCard),
        )
        .first;

    // Slide right to reveal delete action
    await tester.drag(updatedBudgetCard, const Offset(500, 0));
    await settle();

    // Tap the trash icon
    await tester.tap(find.byIcon(FPhosphorIcons.trash).first);
    await settle();

    // Confirm deletion dialog
    await tester.tap(find.text('Delete'));
    await settle();

    // Verify it is removed
    expect(find.text('My E2E Budget Edited'), findsNothing);

    print('BUDGET TEST FINISHED');
    await tearDownAppForTesting(tester, db);
  });
}
