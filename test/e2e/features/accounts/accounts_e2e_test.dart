import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';

import '../../test_setup.dart';

import 'package:poka_ce/features/accounts/presentation/widgets/cards/account_mini_card.dart';

void main() {
  testWidgets('Account CRUD operations', (tester) async {
    final db = await pumpAppForTesting(tester);

    Future<void> settle() async {
      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 200));
      }
    }

    // 1. Navigate to Accounts using Bottom Navigation Bar
    final navBar = find.byType(FBottomNavigationBar);
    final accountsTab = find
        .descendant(
          of: navBar,
          matching: find.byIcon(FPhosphorIcons.wallet),
        )
        .first;
    await tester.tap(accountsTab);
    await settle();

    // Verify Account list page is shown (add button exists)
    expect(find.byKey(const Key('account-add-button')), findsOneWidget);

    // 2. Create Account
    await tester.tap(find.byKey(const Key('account-add-button')));
    await settle();

    // Find the text field and enter name (Assume it's the first text field for name)
    final nameField = find.byType(FTextField).first;
    await tester.enterText(nameField, 'My E2E Account');
    await settle();

    // Tap save
    await tester.ensureVisible(find.text('Save'));
    await tester.tap(find.text('Save'));
    await settle();

    // Verify it appears in the list
    await tester.ensureVisible(find.text('My E2E Account'));
    expect(find.text('My E2E Account'), findsOneWidget);

    // 3. Update Account
    final accountCard = find
        .ancestor(
          of: find.text('My E2E Account'),
          matching: find.byType(AccountMiniCard),
        )
        .first;

    final dotsMenu = find
        .descendant(
          of: accountCard,
          matching: find.byIcon(FPhosphorIcons.dotsThreeVertical),
        )
        .first;

    await tester.ensureVisible(dotsMenu);
    await tester.tap(dotsMenu);
    await settle();

    // Tap the edit icon in the sheet (FPhosphorIcons.pencilSimple)
    await tester.tap(find.byIcon(FPhosphorIcons.pencilSimple).first);
    await settle();

    // Edit text
    final editNameField = find.byType(FTextField).first;
    await tester.enterText(editNameField, 'My E2E Account Edited');
    await settle();

    // Tap save
    await tester.ensureVisible(find.text('Save'));
    await tester.tap(find.text('Save'));
    await settle();

    await tester.ensureVisible(find.text('My E2E Account Edited'));
    expect(find.text('My E2E Account Edited'), findsOneWidget);

    // 4. Delete Account
    // Find the updated card
    final updatedAccountCard = find
        .ancestor(
          of: find.text('My E2E Account Edited'),
          matching: find.byType(AccountMiniCard),
        )
        .first;

    final updatedDotsMenu = find
        .descendant(
          of: updatedAccountCard,
          matching: find.byIcon(FPhosphorIcons.dotsThreeVertical),
        )
        .first;

    await tester.ensureVisible(updatedDotsMenu);
    await tester.tap(updatedDotsMenu);
    await settle();

    // Tap the trash icon (FPhosphorIcons.trash)
    await tester.tap(find.byIcon(FPhosphorIcons.trash).last);
    await settle();

    // Confirm deletion dialog
    await tester.tap(find.text('Delete'));
    await settle();

    // Verify it is removed
    expect(find.text('My E2E Account Edited'), findsNothing);

    print('ACCOUNT TEST FINISHED');
    await db.close();
  });
}
