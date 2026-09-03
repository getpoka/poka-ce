import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/use_case_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/accounts/domain/account_aggregate.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/domain/use_cases/update_transaction_use_case.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/tile/transaction_tile.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class MockUpdateTransactionUseCase extends Mock implements UpdateTransactionUseCase {}

class FakeTransactionModel extends Fake implements TransactionModel {}

class _FakeCategoryListNotifier extends CategoryListNotifier {
  final List<CategoryModel> _categories;
  _FakeCategoryListNotifier(this._categories);
  @override
  Future<List<CategoryModel>> build() => Future.value(_categories);
}

class _FakeAccountListNotifier extends AccountListNotifier {
  final List<AccountModel> _accounts;
  _FakeAccountListNotifier(this._accounts);
  @override
  Stream<AccountListState> build() async* {
    yield AccountListState(
      accounts: _accounts,
      aggregates: _accounts
          .where((a) => !a.isPocket)
          .map((a) => AccountAggregate(account: a, pockets: _accounts.where((p) => p.parentId == a.id).toList()))
          .toList(),
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
    registerFallbackValue(FakeTransactionModel());
    registerFallbackValue(TransactionType.expense);
  });

  late MockUpdateTransactionUseCase mockUpdate;

  setUp(() {
    mockUpdate = MockUpdateTransactionUseCase();
    when(
      () => mockUpdate.execute(
        any(),
        type: any(named: 'type'),
        accountId: any(named: 'accountId'),
        destinationAccountId: any(named: 'destinationAccountId'),
        transactionDate: any(named: 'transactionDate'),
        note: any(named: 'note'),
        splitItems: any(named: 'splitItems'),
      ),
    ).thenAnswer((inv) async {
      final existing = inv.positionalArguments[0] as TransactionModel;
      return Success(existing);
    });
  });

  TransactionModel splitTx() {
    final now = DateTime(2024, 1, 15, 10, 30);
    return TransactionModel(
      id: 't1',
      accountId: 'a1',
      type: TransactionType.expense,
      amount: 700,
      transactionDate: now,
      createdAt: now,
      updatedAt: now,
      note: 'receipt',
      items: [
        TransactionItemModel(
          id: 'i1',
          transactionId: 't1',
          amount: 300,
          categoryId: 'c1',
          note: 'lunch',
          createdAt: now,
          updatedAt: now,
        ),
        TransactionItemModel(
          id: 'i2',
          transactionId: 't1',
          amount: 400,
          categoryId: 'c2',
          note: 'taxi',
          createdAt: now,
          updatedAt: now,
        ),
      ],
    );
  }

  List<CategoryModel> categories() => [
    CategoryModel(
      id: 'c1',
      name: 'Food',
      type: CategoryType.expense,
      color: '#EF4444',
      icon: 'utensils',
      createdAt: DateTime.utc(2024, 1, 1),
      updatedAt: DateTime.utc(2024, 1, 1),
    ),
    CategoryModel(
      id: 'c2',
      name: 'Transport',
      type: CategoryType.expense,
      color: '#3B82F6',
      icon: 'car',
      createdAt: DateTime.utc(2024, 1, 1),
      updatedAt: DateTime.utc(2024, 1, 1),
    ),
  ];

  List<AccountModel> accounts() => [
    AccountModel(
      id: 'a1',
      name: 'Wallet',
      type: AccountType.assets,
      balance: 1000,
      createdAt: DateTime.utc(2024, 1, 1),
      updatedAt: DateTime.utc(2024, 1, 1),
    ),
    AccountModel(
      id: 'a2',
      name: 'Savings',
      type: AccountType.assets,
      balance: 500,
      createdAt: DateTime.utc(2024, 1, 1),
      updatedAt: DateTime.utc(2024, 1, 1),
    ),
  ];

  Widget buildApp(List<Widget> children) {
    final container = ProviderContainer(
      overrides: [
        updateTransactionUseCaseProvider.overrideWithValue(mockUpdate),
        categoryListProvider.overrideWith(() => _FakeCategoryListNotifier(categories())),
        accountListProvider.overrideWith(() => _FakeAccountListNotifier(accounts())),
      ],
    );
    return UncontrolledProviderScope(
      container: container,
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: Scaffold(body: Column(children: children)),
        ),
      ),
    );
  }

  testWidgets('multi-item tile expands to show sub items and collapses', (tester) async {
    final tx = splitTx();
    await tester.pumpWidget(buildApp([RecentTransactionTile(transaction: tx, isBalanceVisible: true)]));
    await tester.pumpAndSettle();

    // Tap the tile body to expand (has multiple items).
    await tester.tap(find.text('receipt').first, warnIfMissed: false);
    await tester.pumpAndSettle();

    // Sub item notes become visible.
    expect(find.text('lunch'), findsOneWidget);
    expect(find.text('taxi'), findsOneWidget);

    // Tap again to collapse.
    await tester.tap(find.text('receipt').first, warnIfMissed: false);
    await tester.pumpAndSettle();
  });

  testWidgets('removing a sub item calls update with remaining items', (tester) async {
    final tx = splitTx();
    await tester.pumpWidget(buildApp([RecentTransactionTile(transaction: tx, isBalanceVisible: true)]));
    await tester.pumpAndSettle();

    await tester.tap(find.text('receipt').first, warnIfMissed: false);
    await tester.pumpAndSettle();

    // Swipe the first sub item to reveal delete action, then tap trash.
    final subTiles = find.byType(RecentTransactionTile);
    expect(subTiles, findsNWidgets(3)); // parent + 2 sub items

    // Trigger delete via the slidable action of the first sub item.
    final slideCtx = tester.element(find.text('lunch'));
    Slidable.of(slideCtx)!.openTo(0.22, duration: const Duration(milliseconds: 200));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(FPhosphorIcons.trash).first);
    await tester.pumpAndSettle();

    verify(
      () => mockUpdate.execute(
        any(),
        type: TransactionType.expense,
        accountId: 'a1',
        destinationAccountId: null,
        transactionDate: any(named: 'transactionDate'),
        note: any(named: 'note'),
        splitItems: any(named: 'splitItems'),
      ),
    ).called(1);
  });

  testWidgets('transfer tile resolves destination account label', (tester) async {
    final now = DateTime(2024, 1, 15, 10, 30);
    final tx = TransactionModel(
      id: 't2',
      accountId: 'a1',
      destinationAccountId: 'a2',
      type: TransactionType.transfer,
      amount: 250,
      transactionDate: now,
      createdAt: now,
      updatedAt: now,
      items: [
        TransactionItemModel(
          id: 'i1',
          transactionId: 't2',
          amount: 250,
          createdAt: now,
          updatedAt: now,
        ),
      ],
    );
    await tester.pumpWidget(
      buildApp([
        RecentTransactionTile(
          transaction: tx,
          isBalanceVisible: true,
          account: accounts().first,
        ),
      ]),
    );
    await tester.pumpAndSettle();

    // Destination account name and source account name both appear.
    expect(find.text('Savings'), findsOneWidget);
    expect(find.text('Wallet'), findsOneWidget);
  });

  testWidgets('sub category shows parent prefix label', (tester) async {
    final now = DateTime(2024, 1, 15, 10, 30);
    final tx = TransactionModel(
      id: 't3',
      accountId: 'a1',
      type: TransactionType.expense,
      amount: 100,
      transactionDate: now,
      createdAt: now,
      updatedAt: now,
      items: [
        TransactionItemModel(
          id: 'i1',
          transactionId: 't3',
          amount: 100,
          categoryId: 'child',
          createdAt: now,
          updatedAt: now,
        ),
      ],
    );
    final categoriesWithChild = [
      CategoryModel(
        id: 'parent',
        name: 'Food & Drink',
        type: CategoryType.expense,
        color: '#EF4444',
        icon: 'utensils',
        createdAt: DateTime.utc(2024, 1, 1),
        updatedAt: DateTime.utc(2024, 1, 1),
      ),
      CategoryModel(
        id: 'child',
        name: 'Coffee',
        type: CategoryType.expense,
        parentId: 'parent',
        color: '#8B5CF6',
        icon: 'coffee',
        createdAt: DateTime.utc(2024, 1, 1),
        updatedAt: DateTime.utc(2024, 1, 1),
      ),
    ];

    final container = ProviderContainer(
      overrides: [
        updateTransactionUseCaseProvider.overrideWithValue(mockUpdate),
        categoryListProvider.overrideWith(() => _FakeCategoryListNotifier(categoriesWithChild)),
        accountListProvider.overrideWith(() => _FakeAccountListNotifier(accounts())),
      ],
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: TranslationProvider(
          child: MaterialApp(
            builder: (context, child) => FTheme(data: lightTheme, child: child!),
            home: Scaffold(
              body: Column(
                children: [
                  RecentTransactionTile(
                    transaction: tx,
                    isBalanceVisible: true,
                    category: categoriesWithChild[1],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Food & Drink • Coffee'), findsOneWidget);
  });

  testWidgets('single item tile without handlers does not render slidable', (tester) async {
    final now = DateTime(2024, 1, 15, 10, 30);
    final tx = TransactionModel(
      id: 't4',
      accountId: 'a1',
      type: TransactionType.income,
      amount: 100,
      transactionDate: now,
      createdAt: now,
      updatedAt: now,
      items: [
        TransactionItemModel(
          id: 'i1',
          transactionId: 't4',
          amount: 100,
          createdAt: now,
          updatedAt: now,
        ),
      ],
    );
    await tester.pumpWidget(buildApp([RecentTransactionTile(transaction: tx, isBalanceVisible: true)]));
    await tester.pumpAndSettle();
    expect(find.byType(Slidable), findsNothing);
  });
}
