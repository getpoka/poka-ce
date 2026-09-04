import 'package:flutter/material.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';
import 'package:poka_ce/features/transactions/presentation/screens/transaction_list_page.dart';
import 'package:poka_ce/theme/theme.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';

class MockTransactionListNotifier extends TransactionListNotifier {
  final List<TransactionModel> _initialTransactions;
  final bool _loading;

  MockTransactionListNotifier(this._initialTransactions, [this._loading = false]);

  @override
  TransactionListState build() {
    return TransactionListState(
      transactions: _initialTransactions,
      isLoading: _loading,
      errorMessage: null,
      focusedDate: DateTime.now(),
    );
  }
}

class MockCategoryListNotifier extends CategoryListNotifier {
  @override
  Future<List<CategoryModel>> build() => Future.value(const []);
}

void main() {
  Widget buildTestApp(ProviderContainer container) {
    return UncontrolledProviderScope(
      container: container,
      child: FTheme(
        data: lightTheme,
        child: const MaterialApp(
          home: Scaffold(body: TransactionListPage()),
        ),
      ),
    );
  }

  testWidgets('TransactionListPage shows loading indicator when loading', (tester) async {
    final container = ProviderContainer(
      overrides: [
        transactionListNotifierProvider.overrideWith(() => MockTransactionListNotifier([], true)),
        categoryListProvider.overrideWith(() => MockCategoryListNotifier()),
        categoriesStreamProvider.overrideWith((ref) => const Stream.empty()),
        accountsStreamProvider.overrideWith((ref) => const Stream.empty()),
      ],
    );
    await tester.pumpWidget(buildTestApp(container));
    await tester.pump();
    expect(find.byType(FCircularProgress), findsOneWidget);
  });

  testWidgets('TransactionListPage shows empty state', (tester) async {
    final container = ProviderContainer(
      overrides: [
        transactionListNotifierProvider.overrideWith(() => MockTransactionListNotifier([], false)),
        categoryListProvider.overrideWith(() => MockCategoryListNotifier()),
        categoriesStreamProvider.overrideWith((ref) => const Stream.empty()),
        accountsStreamProvider.overrideWith((ref) => const Stream.empty()),
      ],
    );
    await tester.pumpWidget(buildTestApp(container));
    await tester.pumpAndSettle();

    expect(find.text('No transactions'), findsOneWidget);
  });

  testWidgets('TransactionListPage shows populated transactions', (tester) async {
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
        transactionListNotifierProvider.overrideWith(() => MockTransactionListNotifier([transaction], false)),
        categoryListProvider.overrideWith(() => MockCategoryListNotifier()),
        categoriesStreamProvider.overrideWith((ref) => const Stream.empty()),
        accountsStreamProvider.overrideWith((ref) => const Stream.empty()),
      ],
    );
    await tester.pumpWidget(buildTestApp(container));
    await tester.pumpAndSettle();

    // Test that something is rendered, e.g. the transaction amount
    expect(find.byType(CustomScrollView), findsWidgets);
  });

  testWidgets('TransactionListPage collapses and expands date group on tap', (tester) async {
    final now = DateTime.now();
    final transaction = TransactionModel(
      id: 't1',
      accountId: 'a1',
      type: TransactionType.expense,
      amount: 500,
      transactionDate: now,
      createdAt: now,
      updatedAt: now,
      items: [
        TransactionItemModel(
          id: 'i1',
          transactionId: 't1',
          categoryId: 'c1',
          amount: 500,
          allocation: TransactionAllocation.need,
          createdAt: now,
          updatedAt: now,
        ),
      ],
    );

    final container = ProviderContainer(
      overrides: [
        transactionListNotifierProvider.overrideWith(() => MockTransactionListNotifier([transaction], false)),
        categoryListProvider.overrideWith(() => MockCategoryListNotifier()),
        categoriesStreamProvider.overrideWith((ref) => const Stream.empty()),
        accountsStreamProvider.overrideWith((ref) => const Stream.empty()),
      ],
    );
    await tester.pumpWidget(buildTestApp(container));
    await tester.pumpAndSettle();

    // Default: expanded, FCollapsible has value: 1.0, tile is visible
    expect(find.byType(FCollapsible), findsOneWidget);
    final collapsible = tester.widget<FCollapsible>(find.byType(FCollapsible));
    expect(collapsible.value, 1.0);

    // Tap header to collapse
    final headerFinder = find.ancestor(
      of: find.byIcon(FPhosphorIcons.caretDown),
      matching: find.byType(GestureDetector),
    );
    await tester.tap(headerFinder);
    await tester.pumpAndSettle();

    // Now collapsed, item count badge appears
    expect(find.textContaining('1 item'), findsOneWidget);

    // Tap header again to re-expand
    await tester.tap(headerFinder);
    await tester.pumpAndSettle();

    final reExpanded = tester.widget<FCollapsible>(find.byType(FCollapsible));
    expect(reExpanded.value, 1.0);
  });
}
