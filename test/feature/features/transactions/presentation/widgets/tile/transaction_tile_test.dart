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
}
