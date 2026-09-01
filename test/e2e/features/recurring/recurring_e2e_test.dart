import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/features/recurring/presentation/widgets/recurring_card.dart';

import '../../test_setup.dart';

void main() {
  testWidgets('Recurring CRUD operations', (tester) async {
    await pumpAppForTesting(tester);
    Future<void> settle() => tester.pumpAndSettle(const Duration(milliseconds: 200));
    await settle();

    // 1. Navigate to Recurring Page
    final recurringAction = find.byIcon(FPhosphorIcons.calendarDots).first;
    await tester.ensureVisible(recurringAction);
    await tester.tap(recurringAction);
    await settle();
    await settle();

    expect(find.text('Recurring'), findsWidgets);

    // 2. Create Recurring
    final addBtn = find.byKey(const Key('recurring-add-button')).first;
    await tester.ensureVisible(addBtn);
    await tester.tap(addBtn);
    await settle();

    // Fill the form
    final textFields = find.byType(FTextFormField);

    // Amount (index 0)
    await tester.ensureVisible(textFields.at(0));
    await tester.enterText(textFields.at(0), '75000');
    await tester.pump(const Duration(milliseconds: 100));

    // Date (index 1)
    await tester.ensureVisible(textFields.at(1));
    await tester.tap(textFields.at(1));
    await settle();

    // Select the 15th of the month
    final dateCell = find.text('15').first;
    await tester.ensureVisible(dateCell);
    await tester.tap(dateCell);
    await settle();

    // Note (index 2)
    await tester.ensureVisible(textFields.at(2));
    await tester.enterText(textFields.at(2), 'Monthly Subscription');
    await tester.pump(const Duration(milliseconds: 100));

    // Select Account
    final accSelector = find.byKey(const Key('recurring-account-selector'));
    await tester.ensureVisible(accSelector);
    await tester.tap(accSelector);
    await settle();

    final accountItem = find.text('Cash').first;
    await tester.ensureVisible(accountItem);
    await tester.tap(accountItem);
    await settle(); // Wait for sheet to close

    // Select Category
    final catSelector = find.byKey(const Key('recurring-category-selector'));
    await tester.ensureVisible(catSelector);
    await tester.tap(catSelector);
    await settle();

    final categoryItem = find.text('Food & Dining').first;
    await tester.ensureVisible(categoryItem);
    await tester.tap(categoryItem);
    await settle(); // Wait for sheet to close

    // Save
    final saveBtn = find.byType(FButton).last;
    await tester.ensureVisible(saveBtn);
    await tester.tap(saveBtn);
    await settle();

    // Verify it appears in the list (using the Card)
    await tester.ensureVisible(find.byType(RecurringCard).first);
    expect(find.text('Monthly Subscription'), findsWidgets);

    // 3. Update Recurring
    final recurringCard = find.byType(RecurringCard).first;
    await tester.ensureVisible(recurringCard);

    // Slide right to reveal edit action
    await tester.drag(recurringCard, const Offset(-500, 0));
    await settle();

    // Tap the edit icon (FPhosphorIcons.pencilSimple) in the action pane
    await tester.tap(find.byIcon(FPhosphorIcons.pencilSimple).first);
    await settle();

    // Change Note
    final editTextFields = find.byType(FTextFormField);
    await tester.ensureVisible(editTextFields.at(2));
    await tester.enterText(editTextFields.at(2), 'Updated Subscription');
    await tester.pump(const Duration(milliseconds: 100));

    // Save Changes
    final saveChangesBtn = find.text('Save Changes');
    await tester.ensureVisible(saveChangesBtn);
    await tester.tap(saveChangesBtn);
    await settle();

    // Verify it is updated
    expect(find.text('Updated Subscription'), findsWidgets);
    expect(find.text('Monthly Subscription'), findsNothing);

    // 4. Delete Recurring
    final updatedRecurringCard = find.byType(RecurringCard).first;
    await tester.ensureVisible(updatedRecurringCard);

    // Slide left to reveal delete action
    await tester.drag(updatedRecurringCard, const Offset(500, 0));
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
    expect(find.text('Updated Subscription'), findsNothing);
  });
}
