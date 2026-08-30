import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/filter/transaction_filter_account_group.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/filter/transaction_filter_category_group.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/filter/transaction_filter_sheet.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/filter/transaction_type_chip.dart';
import 'package:poka_ce/theme/theme.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget buildTestableWidget(Widget child, {List<dynamic> overrides = const []}) {
    return ProviderScope(
      overrides: [...overrides],
      child: MaterialApp(
        builder: (context, child) => FTheme(
          data: lightTheme,
          child: child!,
        ),
        home: Scaffold(body: child),
      ),
    );
  }

  group('TransactionFilterSheet', () {
    testWidgets('renders all groups and applies filter', (tester) async {
      final now = DateTimeUtils.nowUtc();
      final account = AccountModel(
        id: 'a1',
        name: 'Wallet',
        balance: 10,
        type: AccountType.assets,
        createdAt: now,
        updatedAt: now,
      );
      final category = CategoryModel(
        id: 'c1',
        name: 'Food',
        type: CategoryType.expense,
        createdAt: now,
        updatedAt: now,
      );

      TransactionFilter? result;

      await tester.pumpWidget(
        buildTestableWidget(
          Builder(
            builder: (context) => FButton(
              onPress: () async {
                result = await TransactionFilterSheet.show(
                  context,
                  current: const TransactionFilter(),
                );
              },
              child: const Text('Show'),
            ),
          ),
          overrides: [
            accountsStreamProvider.overrideWith((ref) => Stream.value([account])),
            categoriesStreamProvider.overrideWith((ref) => Stream.value([category])),
          ],
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      expect(find.text('Transaction Type'), findsOneWidget);
      expect(find.byType(TransactionTypeChip), findsNWidgets(3)); // 3 types
      expect(find.byType(TransactionFilterAccountGroup), findsOneWidget);
      expect(find.byType(TransactionFilterCategoryGroup), findsOneWidget);

      // Tap on expense type
      final expenseChip = find.text('Expense'); // Depending on casing inside the chip
      // Assuming it renders text for the enum name or something similar.
      // We can just tap the widget
      await tester.tap(find.byType(TransactionTypeChip).at(1)); // expense
      await tester.pumpAndSettle();

      // Tap on apply
      await tester.tap(find.text('Apply Filter'));
      await tester.pumpAndSettle();

      expect(result, isNotNull);
      expect(result!.types.isNotEmpty, true);
    });

    testWidgets('Reset clears selection', (tester) async {
      final now = DateTimeUtils.nowUtc();
      final account = AccountModel(
        id: 'a1',
        name: 'Wallet',
        balance: 10,
        type: AccountType.assets,
        createdAt: now,
        updatedAt: now,
      );
      final category = CategoryModel(
        id: 'c1',
        name: 'Food',
        type: CategoryType.expense,
        createdAt: now,
        updatedAt: now,
      );

      final filter = TransactionFilter(
        types: {TransactionType.expense},
        accountIds: {'a1'},
        categoryIds: {'c1'},
      );

      await tester.pumpWidget(
        buildTestableWidget(
          TransactionFilterSheet(current: filter),
          overrides: [
            accountsStreamProvider.overrideWith((ref) => Stream.value([account])),
            categoriesStreamProvider.overrideWith((ref) => Stream.value([category])),
          ],
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Reset'), findsOneWidget);
      await tester.tap(find.text('Reset'));
      await tester.pumpAndSettle();

      // Ensure reset works, Reset button should disappear
      expect(find.text('Reset'), findsNothing);
    });
  });

  group('TransactionFilterAccountGroup', () {
    testWidgets('handles selection', (tester) async {
      final now = DateTimeUtils.nowUtc();
      final account = AccountModel(
        id: 'a1',
        name: 'Wallet',
        balance: 10,
        type: AccountType.assets,
        createdAt: now,
        updatedAt: now,
      );

      Set<String>? selected;

      await tester.pumpWidget(
        buildTestableWidget(
          TransactionFilterAccountGroup(
            accounts: [account],
            selectedIds: const {},
            onChanged: (ids) => selected = ids,
          ),
        ),
      );

      await tester.tap(find.text('Wallet'));
      await tester.pumpAndSettle();

      expect(selected, isNotNull);
      expect(selected!.contains('a1'), true);
    });
  });

  group('TransactionFilterCategoryGroup', () {
    testWidgets('handles selection', (tester) async {
      final now = DateTimeUtils.nowUtc();
      final category = CategoryModel(
        id: 'c1',
        name: 'Food',
        type: CategoryType.expense,
        createdAt: now,
        updatedAt: now,
      );

      Set<String>? selected;

      await tester.pumpWidget(
        buildTestableWidget(
          TransactionFilterCategoryGroup(
            categories: [category],
            selectedIds: const {},
            onChanged: (ids) => selected = ids,
          ),
        ),
      );

      await tester.tap(find.text('Food'));
      await tester.pumpAndSettle();

      expect(selected, isNotNull);
      expect(selected!.contains('c1'), true);
    });
  });

  group('TransactionTypeChip', () {
    testWidgets('renders properly', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          TransactionTypeChip(
            type: TransactionType.expense,
            isSelected: true,
            onTap: () {},
          ),
        ),
      );

      expect(find.byType(TransactionTypeChip), findsOneWidget);
    });
  });
}
