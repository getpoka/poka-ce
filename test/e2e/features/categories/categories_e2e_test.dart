import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';

import '../../test_setup.dart';

void main() {
  testWidgets('Category CRUD operations', (tester) async {
    final db = await pumpAppForTesting(tester);

    // Helper for safe pump
    Future<void> settle() async {
      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 200));
      }
    }

    // 1. Navigate to Categories
    final categoriesIcon = find.text('Categories').first;
    await tester.tap(categoriesIcon);
    await settle();

    // Verify Category list page is shown
    expect(find.byKey(const Key('category-add-button')), findsOneWidget);

    // 2. Create Category
    await tester.tap(find.byKey(const Key('category-add-button')));
    await settle();

    // Find the text field and enter name
    final nameField = find.byType(FTextField).first;
    await tester.enterText(nameField, 'Test Food');
    await settle();

    // Tap save
    await tester.tap(find.text('Save Category'));
    await settle();

    // Verify it appears in the list
    await tester.ensureVisible(find.text('Test Food'));
    expect(find.text('Test Food'), findsOneWidget);

    // 3. Update Category
    await tester.ensureVisible(find.text('Test Food'));
    await tester.drag(find.text('Test Food'), const Offset(-300, 0));
    await settle();

    // Tap the edit icon (FPhosphorIcons.pencilSimple)
    await tester.tap(find.byIcon(FPhosphorIcons.pencilSimple));
    await settle();

    // Edit text
    final editNameField = find.byType(FTextField).first;
    await tester.enterText(editNameField, 'Test Food Edited');
    await settle();

    // Tap save
    await tester.tap(find.text('Save Category'));
    await settle();

    await tester.ensureVisible(find.text('Test Food Edited'));
    expect(find.text('Test Food Edited'), findsOneWidget);

    // 4. Delete Category
    // Swipe right to reveal delete button in the startActionPane
    await tester.ensureVisible(find.text('Test Food Edited'));
    await tester.drag(find.text('Test Food Edited'), const Offset(300, 0));
    await settle();

    // Tap the trash icon (FPhosphorIcons.trash)
    await tester.tap(find.byIcon(FPhosphorIcons.trash));
    await settle();

    // Confirm deletion dialog
    await tester.tap(find.text('Delete'));
    await settle();

    // Verify it is removed
    expect(find.text('Test Food Edited'), findsNothing);

    print('TEST FINISHED');
    await tearDownAppForTesting(tester, db);
  });
}
