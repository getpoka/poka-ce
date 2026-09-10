import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/tile/transaction_tile.dart';
import 'package:poka_ce/theme/theme.dart';

class MockCategoryListNotifier extends CategoryListNotifier {
  @override
  Future<List<CategoryModel>> build() => Future.value(const []);
}

void main() {
  Widget buildTestApp(Widget child, ProviderContainer container) {
    return UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        builder: (context, child) => FTheme(
          data: lightTheme,
          child: child!,
        ),
        home: Scaffold(body: child),
      ),
    );
  }

  testWidgets('RecentTransactionTile renders transaction correctly', (tester) async {
    final transaction = TransactionModel(
      id: 't1',
      accountId: 'a1',
      type: TransactionType.expense,
      amount: 500,
      transactionDate: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      items: [
        TransactionItemModel(
          id: 'i1',
          transactionId: 't1',
          categoryId: 'c1',
          amount: 500,
          allocation: TransactionAllocation.need,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ],
    );

    final container = ProviderContainer(
      overrides: [
        categoryListProvider.overrideWith(() => MockCategoryListNotifier()),
      ],
    );

    await tester.pumpWidget(
      buildTestApp(
        RecentTransactionTile(
          transaction: transaction,
          isBalanceVisible: true,
        ),
        container,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(RecentTransactionTile), findsOneWidget);
  });

  testWidgets('RecentTransactionTile resolves and displays child categories when expanded', (tester) async {
    final foodCat = CategoryModel(
      id: 'cat_food',
      name: 'Food & Dining',
      icon: 'forkKnife',
      color: '#FF5722',
      type: CategoryType.expense,
      sort: 1,
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    final transportCat = CategoryModel(
      id: 'cat_transport',
      name: 'Transport',
      icon: 'car',
      color: '#2196F3',
      type: CategoryType.expense,
      sort: 2,
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final categoriesMap = {
      foodCat.id: foodCat,
      transportCat.id: transportCat,
    };

    final splitTransaction = TransactionModel(
      id: 'tx_split',
      accountId: 'acc_1',
      type: TransactionType.expense,
      amount: 150000,
      transactionDate: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      items: [
        TransactionItemModel(
          id: 'item_1',
          transactionId: 'tx_split',
          categoryId: 'cat_food',
          amount: 100000,
          allocation: TransactionAllocation.need,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        TransactionItemModel(
          id: 'item_2',
          transactionId: 'tx_split',
          categoryId: 'cat_transport',
          amount: 50000,
          allocation: TransactionAllocation.want,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ],
    );

    final container = ProviderContainer(
      overrides: [
        categoryListProvider.overrideWith(() => MockCategoryListNotifier()),
      ],
    );

    await tester.pumpWidget(
      buildTestApp(
        RecentTransactionTile(
          transaction: splitTransaction,
          isBalanceVisible: true,
          categoriesById: categoriesMap,
        ),
        container,
      ),
    );
    await tester.pumpAndSettle();

    // Tap to expand
    await tester.tap(find.byType(RecentTransactionTile).first);
    await tester.pumpAndSettle();

    // After expanding:
    // - Parent tile header auto-resolves to first item category ("Food & Dining")
    // - Sub-item 1 resolves to its category ("Food & Dining")
    // - Sub-item 2 resolves to its category ("Transport")
    // - No item shows "Uncategorized"
    expect(find.text('Food & Dining'), findsNWidgets(2));
    expect(find.text('Transport'), findsOneWidget);
    expect(find.text('Uncategorized'), findsNothing);
  });
}
