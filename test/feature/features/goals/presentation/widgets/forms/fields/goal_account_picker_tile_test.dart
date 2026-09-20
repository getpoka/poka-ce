import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/goals/presentation/widgets/forms/fields/goal_account_picker_tile.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final now = DateTime.now();
  final testAccounts = [
    AccountModel(
      id: 'acc-1',
      name: 'Main Bank',
      type: AccountType.assets,
      balance: 100000,
      initialBalance: 100000,
      createdAt: now,
      updatedAt: now,
    ),
    AccountModel(
      id: 'acc-2',
      name: 'Cash Wallet',
      type: AccountType.assets,
      balance: 50000,
      initialBalance: 50000,
      createdAt: now,
      updatedAt: now,
    ),
  ];

  Widget buildWidget({
    required List<AccountModel> accounts,
    required String? selectedAccountId,
    required bool isEditing,
    required ValueChanged<String> onAccountSelected,
  }) {
    return MaterialApp(
      builder: (context, child) => FTheme(data: lightTheme, child: child!),
      home: Scaffold(
        body: GoalAccountPickerTile(
          accounts: accounts,
          selectedAccountId: selectedAccountId,
          isEditing: isEditing,
          onAccountSelected: onAccountSelected,
        ),
      ),
    );
  }

  testWidgets('renders account selector and opens selection sheet on tap in create mode', (tester) async {
    var selected = '';

    await tester.pumpWidget(
      buildWidget(
        accounts: testAccounts,
        selectedAccountId: 'acc-1',
        isEditing: false,
        onAccountSelected: (id) => selected = id,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Main Bank'), findsOneWidget);
    expect(find.byIcon(FPhosphorIcons.caretDown), findsOneWidget);

    await tester.tap(find.text('Main Bank'));
    await tester.pumpAndSettle();

    expect(find.text('Select Account'), findsOneWidget);
    expect(find.text('Cash Wallet'), findsOneWidget);

    await tester.tap(find.text('Cash Wallet'));
    await tester.pumpAndSettle();

    expect(selected, 'acc-2');
  });

  testWidgets('renders locked account tile in edit mode', (tester) async {
    await tester.pumpWidget(
      buildWidget(accounts: testAccounts, selectedAccountId: 'acc-1', isEditing: true, onAccountSelected: (_) {}),
    );
    await tester.pumpAndSettle();

    expect(find.text('Main Bank'), findsOneWidget);
    expect(find.byIcon(FPhosphorIcons.lock), findsOneWidget);
    expect(find.byIcon(FPhosphorIcons.caretDown), findsNothing);
  });
}
