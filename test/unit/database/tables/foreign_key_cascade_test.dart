import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(connection: NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('Accounts: Deleting parent account cascades to child pockets', () async {
    const parentId = 'parent_acc';
    const childId = 'child_pocket';

    await db
        .into(db.accounts)
        .insert(
          AccountsCompanion.insert(
            id: const Value(parentId),
            name: 'Main Wallet',
            type: AccountType.assets,
            balance: const Value(0),
          ),
        );

    await db
        .into(db.accounts)
        .insert(
          AccountsCompanion.insert(
            id: const Value(childId),
            name: 'Savings Pocket',
            type: AccountType.assets,
            balance: const Value(0),
            parentId: const Value(parentId),
          ),
        );

    var accountsCount = await (db.select(db.accounts)..where((a) => a.id.isIn([parentId, childId]))).get();
    expect(accountsCount.length, 2);

    // Delete parent
    await (db.delete(db.accounts)..where((a) => a.id.equals(parentId))).go();

    // Verify child is also deleted
    accountsCount = await (db.select(db.accounts)..where((a) => a.id.isIn([parentId, childId]))).get();
    expect(accountsCount.length, 0);
  });

  test('Categories: Deleting parent category cascades to sub-categories', () async {
    const parentId = 'parent_cat';
    const childId = 'child_subcat';

    await db
        .into(db.categories)
        .insert(
          CategoriesCompanion.insert(
            id: const Value(parentId),
            name: 'Food',
            type: CategoryType.expense,
          ),
        );

    await db
        .into(db.categories)
        .insert(
          CategoriesCompanion.insert(
            id: const Value(childId),
            name: 'Snacks',
            type: CategoryType.expense,
            parentId: const Value(parentId),
          ),
        );

    var categoriesCount = await (db.select(db.categories)..where((c) => c.id.isIn([parentId, childId]))).get();
    expect(categoriesCount.length, 2);

    // Delete parent
    await (db.delete(db.categories)..where((c) => c.id.equals(parentId))).go();

    // Verify child is also deleted
    categoriesCount = await (db.select(db.categories)..where((c) => c.id.isIn([parentId, childId]))).get();
    expect(categoriesCount.length, 0);
  });

  test('Transactions: Deleting transaction cascades to transaction items', () async {
    const accountId = 'acc1';
    const transactionId = 'txn1';
    const itemId = 'item1';

    await db
        .into(db.accounts)
        .insert(
          AccountsCompanion.insert(
            id: const Value(accountId),
            name: 'Wallet',
            type: AccountType.assets,
            balance: const Value(0),
          ),
        );

    await db
        .into(db.transactions)
        .insert(
          TransactionsCompanion.insert(
            id: const Value(transactionId),
            accountId: accountId,
            type: TransactionType.expense,
            amount: 10000,
            transactionDate: DateTime.now(),
          ),
        );

    await db
        .into(db.transactionItems)
        .insert(
          TransactionItemsCompanion.insert(
            id: const Value(itemId),
            transactionId: transactionId,
            amount: 10000,
          ),
        );

    var itemsCount = await db.select(db.transactionItems).get();
    expect(itemsCount.length, 1);

    // Delete transaction
    await (db.delete(db.transactions)..where((t) => t.id.equals(transactionId))).go();

    // Verify item is also deleted
    itemsCount = await db.select(db.transactionItems).get();
    expect(itemsCount.length, 0);
  });

  test('AccountCategories: Deleting account or category cascades', () async {
    const accountId = 'acc1';
    const categoryId = 'cat1';

    await db
        .into(db.accounts)
        .insert(
          AccountsCompanion.insert(
            id: const Value(accountId),
            name: 'Wallet',
            type: AccountType.assets,
            balance: const Value(0),
          ),
        );

    await db
        .into(db.categories)
        .insert(
          CategoriesCompanion.insert(
            id: const Value(categoryId),
            name: 'Food',
            type: CategoryType.expense,
          ),
        );

    await db
        .into(db.accountCategories)
        .insert(
          AccountCategoriesCompanion.insert(
            accountId: accountId,
            categoryId: categoryId,
          ),
        );

    var acCount = await db.select(db.accountCategories).get();
    expect(acCount.length, 1);

    // Delete account
    await (db.delete(db.accounts)..where((a) => a.id.equals(accountId))).go();

    // Verify AccountCategory is deleted
    acCount = await db.select(db.accountCategories).get();
    expect(acCount.length, 0);
  });

  test('Budgets: Deleting budget cascades to budget records', () async {
    const accountId = 'acc1';
    const budgetId = 'budget1';

    await db
        .into(db.accounts)
        .insert(
          AccountsCompanion.insert(
            id: const Value(accountId),
            name: 'Wallet',
            type: AccountType.assets,
            balance: const Value(0),
          ),
        );

    await db
        .into(db.budgets)
        .insert(
          BudgetsCompanion.insert(
            id: const Value(budgetId),
            name: 'Monthly Budget',
            amount: 500000,
            period: BudgetPeriod.monthly,
            resetDay: const Value(1),
            startDate: DateTime.now(),
            accountId: const Value(accountId),
          ),
        );

    await db
        .into(db.budgetRecords)
        .insert(
          BudgetRecordsCompanion.insert(
            budgetId: budgetId,
            spentAmount: const Value(10000),
            periodStart: DateTime.now(),
            periodEnd: DateTime.now().add(const Duration(days: 30)),
          ),
        );

    var recordCount = await db.select(db.budgetRecords).get();
    expect(recordCount.length, 1);

    // Delete budget
    await (db.delete(db.budgets)..where((b) => b.id.equals(budgetId))).go();

    // Verify budget record is also deleted
    recordCount = await db.select(db.budgetRecords).get();
    expect(recordCount.length, 0);
  });
}
