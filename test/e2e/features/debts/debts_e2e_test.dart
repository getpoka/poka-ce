import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';

import '../../test_setup.dart';

import 'package:poka_ce/features/debts/presentation/widgets/debt_card.dart';

void main() {
  testWidgets('Debts CRUD operations', (tester) async {
    final db = await pumpAppForTesting(tester);

    Future<void> settle() async {
      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 200));
      }
    }

    // Wait for Dashboard to settle
    await settle();

    // 1. Navigate to Debts from Dashboard Quick Actions
    final debtsAction = find.text('Debts');
    await tester.ensureVisible(debtsAction);
    await tester.tap(debtsAction);
    await settle();

    // 2. Create Debt
    final addBtn = find.byKey(const Key('debt-add-button')).first;
    await tester.ensureVisible(addBtn);
    await tester.tap(addBtn);
    await settle();

    // Fill the form
    final textFields = find.byType(FTextField);
    // Person name
    await tester.ensureVisible(textFields.at(0));
    await tester.enterText(textFields.at(0), 'John Doe');
    await tester.pump(const Duration(milliseconds: 100));

    // Amount
    await tester.ensureVisible(textFields.at(1));
    await tester.enterText(textFields.at(1), '50000');
    await tester.pump(const Duration(milliseconds: 100));

    // Note
    await tester.ensureVisible(textFields.at(2));
    await tester.enterText(textFields.at(2), 'Lunch money');
    await tester.pump(const Duration(milliseconds: 100));

    // Select Category
    final catSelector = find.byKey(const Key('debt-category-selector'));
    await tester.ensureVisible(catSelector);
    await tester.tap(catSelector);
    await settle();

    final categoryItem = find.text('Food & Dining').first;
    await tester.ensureVisible(categoryItem);
    await tester.tap(categoryItem);
    await settle(); // Wait for sheet to close

    // Select Account
    final accSelector = find.byKey(const Key('debt-account-selector'));
    await tester.ensureVisible(accSelector);
    await tester.tap(accSelector);
    await settle();

    final accountItem = find.text('Cash').first;
    await tester.ensureVisible(accountItem);
    await tester.tap(accountItem);
    await settle(); // Wait for sheet to close

    // Save
    await tester.ensureVisible(find.text('Create Record'));
    await tester.tap(find.text('Create Record'));
    await settle();

    // Verify it appears in the list
    await tester.ensureVisible(find.text('John Doe'));
    expect(find.text('John Doe'), findsOneWidget);

    // 3. Update Debt
    final debtCard = find.byType(DebtCard).first;
    await tester.ensureVisible(debtCard);

    // Slide right to reveal edit action
    await tester.drag(debtCard, const Offset(-500, 0));
    await settle();

    // Tap the edit icon (FPhosphorIcons.pencilSimple) in the action pane
    await tester.tap(find.byIcon(FPhosphorIcons.pencilSimple).first);
    await settle();

    // Change Person Name
    final editTextFields = find.byType(FTextField);
    await tester.ensureVisible(editTextFields.at(0));
    await tester.enterText(editTextFields.at(0), 'Jane Doe');
    await tester.pump(const Duration(milliseconds: 100));

    // Save Changes
    await tester.ensureVisible(find.text('Save Changes'));
    await tester.tap(find.text('Save Changes'));
    await settle();

    // Verify it is updated
    await tester.ensureVisible(find.text('Jane Doe'));
    expect(find.text('Jane Doe'), findsOneWidget);
    expect(find.text('John Doe'), findsNothing);

    // 4. Delete Debt
    final updatedDebtCard = find.byType(DebtCard).first;
    await tester.ensureVisible(updatedDebtCard);

    // Slide left to reveal delete action
    await tester.drag(updatedDebtCard, const Offset(500, 0));
    await settle();

    // Tap trash icon
    final trashIcon = find.byIcon(FPhosphorIcons.trash).first;
    await tester.ensureVisible(trashIcon);
    await tester.tap(trashIcon);
    await settle();

    // Confirm deletion dialog
    await tester.tap(find.text('Delete'));
    await settle();

    // Verify it is deleted
    expect(find.text('Jane Doe'), findsNothing);

    print('DEBTS TEST FINISHED');
    await tearDownAppForTesting(tester, db);
  });
}
