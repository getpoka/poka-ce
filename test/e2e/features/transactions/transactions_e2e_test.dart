import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';

import '../../test_setup.dart';

import 'package:poka_ce/features/transactions/presentation/widgets/tile/transaction_tile.dart';

void main() {
  testWidgets('Transaction CRUD operations', (tester) async {
    final db = await pumpAppForTesting(tester);

    Future<void> settle() async {
      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 200));
      }
    }

    // Wait for Dashboard to settle
    await settle();

    // 1. Navigate to Transactions from Bottom Navigation Bar
    // The second item is Transactions
    final transactionTab = find.text('Transactions');
    await tester.ensureVisible(transactionTab);
    await tester.tap(transactionTab);
    await settle();

    // 2. Create Transaction
    // Tap the FAB (which has Key('transaction-add-button'))
    final addBtn = find.byKey(const Key('transaction-add-button'));
    await tester.ensureVisible(addBtn);
    await tester.tap(addBtn);
    await settle();

    // Type Amount using Numpad (find text on numpad keys)
    // Let's enter 150000
    await tester.ensureVisible(find.byKey(const Key('numpad-1')));
    await tester.tap(find.byKey(const Key('numpad-1')));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.ensureVisible(find.byKey(const Key('numpad-5')));
    await tester.tap(find.byKey(const Key('numpad-5')));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.ensureVisible(find.byKey(const Key('numpad-0')));
    await tester.tap(find.byKey(const Key('numpad-0')));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tap(find.byKey(const Key('numpad-0')));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tap(find.byKey(const Key('numpad-0')));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tap(find.byKey(const Key('numpad-0')));
    await settle();

    // Pick a note (so we can find it easily later)
    // Tap the note area (usually has 'Add note' or FPhosphorIcons.notePencil)
    final noteIcon = find.byIcon(FPhosphorIcons.notePencil).first;
    await tester.ensureVisible(noteIcon);
    await tester.tap(noteIcon);
    await settle(); // Wait for dialog animation

    // Dialog opens, type note
    final noteField = find.byType(EditableText).last;
    await tester.enterText(noteField, 'E2E Transaction');
    await settle();

    // Tap Save note
    await tester.tap(find.text('Save').last);
    await settle(); // Wait for dialog to close

    // Tap OK (check icon) to save transaction
    final okBtn = find.byKey(const Key('numpad-ok'));
    await tester.ensureVisible(okBtn);
    await tester.tap(okBtn);
    await settle();

    // Wait for list to refresh
    await settle();

    // Debug: print widgets
    for (final widget in tester.allWidgets) {
      if (widget is Text) {
        print('Found text: "${widget.data}"');
      }
    }

    // Verify it appears in the list
    await tester.ensureVisible(find.text('E2E Transaction').last);
    expect(find.text('E2E Transaction'), findsOneWidget);

    // 3. Update Transaction
    final txTile = find
        .ancestor(
          of: find.text('E2E Transaction'),
          matching: find.byType(RecentTransactionTile),
        )
        .first;

    // Slide right to reveal edit action
    await tester.drag(txTile, const Offset(-500, 0));
    await settle();

    // Tap the edit icon (FPhosphorIcons.pencilSimple) in the action pane
    await tester.tap(find.byIcon(FPhosphorIcons.pencilSimple).first);
    await settle();

    // Edit note
    final noteIconEdit = find.byIcon(FPhosphorIcons.notePencil).first;
    await tester.ensureVisible(noteIconEdit);
    await tester.tap(noteIconEdit);
    await settle();

    final noteFieldEdit = find.byType(EditableText).last;
    await tester.enterText(noteFieldEdit, 'E2E Transaction Edited');
    await settle();

    await tester.tap(find.text('Save').last);
    await settle();

    // Tap OK
    final okBtnEdit = find.byKey(const Key('numpad-ok'));
    await tester.ensureVisible(okBtnEdit);
    await tester.tap(okBtnEdit);
    await settle();

    // Verify it is updated
    await tester.ensureVisible(find.text('E2E Transaction Edited').last);
    expect(find.text('E2E Transaction Edited'), findsOneWidget);

    // 4. Delete Transaction
    final updatedTxTile = find
        .ancestor(
          of: find.text('E2E Transaction Edited'),
          matching: find.byType(RecentTransactionTile),
        )
        .first;

    // Slide left to reveal delete action
    await tester.drag(updatedTxTile, const Offset(500, 0));
    await settle();

    // Tap the trash icon
    await tester.tap(find.byIcon(FPhosphorIcons.trash).first);
    await settle();

    // Confirm deletion dialog
    await tester.tap(find.text('Delete'));
    await settle();

    // Verify it is removed
    expect(find.text('E2E Transaction Edited'), findsNothing);

    print('TRANSACTIONS TEST FINISHED');
    await db.close();
  });
}
