import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  setUp(() => db = AppDatabase(connection: NativeDatabase.memory()));
  tearDown(() async => db.close());

  group('BudgetsDao', () {
    test('getAllBudgets empty initially', () async {
      expect(await db.budgetsDao.getAllBudgets(), isEmpty);
    });

    test('insert and getBudget', () async {
      final now = DateTime.now().toUtc();
      await db.budgetsDao.insertBudget(
        BudgetsCompanion.insert(
          id: const Value('b1'),
          name: 'Monthly',
          amount: 500000,
          period: BudgetPeriod.monthly,
          startDate: now,
          resetDay: const Value(1),
        ),
      );
      final b = await db.budgetsDao.getBudget('b1');
      expect(b, isNotNull);
      expect(b!.name, 'Monthly');
      expect(b.amount, 500000);
      expect(b.period, BudgetPeriod.monthly);
    });

    test('getBudget returns null for unknown', () async {
      expect(await db.budgetsDao.getBudget('none'), isNull);
    });

    test('updateBudget modifies fields', () async {
      final now = DateTime.now().toUtc();
      await db.budgetsDao.insertBudget(
        BudgetsCompanion.insert(
          id: const Value('b1'),
          name: 'Old',
          amount: 100,
          period: BudgetPeriod.monthly,
          startDate: now,
        ),
      );
      // update via write on the table directly to simulate repository logic for partial update
      await (db.update(db.budgets)..where((b) => b.id.equals('b1'))).write(
        const BudgetsCompanion(name: Value('New'), amount: Value(999)),
      );
      final b = await db.budgetsDao.getBudget('b1');
      expect(b!.name, 'New');
      expect(b.amount, 999);
    });

    test('deleteBudget removes', () async {
      final now = DateTime.now().toUtc();
      await db.budgetsDao.insertBudget(
        BudgetsCompanion.insert(
          id: const Value('b1'),
          name: 'ToDelete',
          amount: 100,
          period: BudgetPeriod.weekly,
          startDate: now,
        ),
      );
      await db.budgetsDao.deleteBudget('b1');
      expect(await db.budgetsDao.getBudget('b1'), isNull);
    });

    test('BudgetRecords: insert and getRecordsForBudget', () async {
      final now = DateTime.now().toUtc();
      await db.budgetsDao.insertBudget(
        BudgetsCompanion.insert(
          id: const Value('b1'),
          name: 'B',
          amount: 1000,
          period: BudgetPeriod.monthly,
          startDate: now,
        ),
      );
      await db.budgetsDao.insertBudgetRecord(
        BudgetRecordsCompanion.insert(
          id: const Value('r1'),
          budgetId: 'b1',
          spentAmount: const Value(250),
          periodStart: now,
          periodEnd: now.add(const Duration(days: 30)),
        ),
      );
      await db.budgetsDao.insertBudgetRecord(
        BudgetRecordsCompanion.insert(
          budgetId: 'b1',
          spentAmount: const Value(100),
          periodStart: now,
          periodEnd: now.add(const Duration(days: 30)),
        ),
      );
      final records = await db.budgetsDao.getRecordsForBudget('b1');
      expect(records.length, 2);
      expect(records.map((e) => e.spentAmount).toSet(), {250, 100});
    });

    test('budget deletion cascades to records', () async {
      final now = DateTime.now().toUtc();
      await db.budgetsDao.insertBudget(
        BudgetsCompanion.insert(
          id: const Value('b1'),
          name: 'B',
          amount: 500,
          period: BudgetPeriod.custom,
          startDate: now,
        ),
      );
      await db.budgetsDao.insertBudgetRecord(
        BudgetRecordsCompanion.insert(budgetId: 'b1', periodStart: now, periodEnd: now.add(const Duration(days: 30))),
      );
      expect((await db.select(db.budgetRecords).get()).length, 1);
      await db.budgetsDao.deleteBudget('b1');
      expect((await db.select(db.budgetRecords).get()).length, 0);
    });

    test('budget with category and account references', () async {
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('acc1'), name: 'Wallet', type: AccountType.assets));
      await db
          .into(db.categories)
          .insert(CategoriesCompanion.insert(id: const Value('cat1'), name: 'Food', type: CategoryType.expense));
      final now = DateTime.now().toUtc();
      await db.budgetsDao.insertBudget(
        BudgetsCompanion.insert(
          id: const Value('b1'),
          name: 'Food Budget',
          amount: 200000,
          period: BudgetPeriod.monthly,
          startDate: now,
          categoryId: const Value('cat1'),
          accountId: const Value('acc1'),
        ),
      );
      final b = await db.budgetsDao.getBudget('b1');
      expect(b!.categoryId, 'cat1');
      expect(b.accountId, 'acc1');
    });

    test('getAllBudgets returns multiple', () async {
      final now = DateTime.now().toUtc();
      await db.budgetsDao.insertBudget(
        BudgetsCompanion.insert(
          id: const Value('b1'),
          name: 'A',
          amount: 100,
          period: BudgetPeriod.monthly,
          startDate: now,
        ),
      );
      await db.budgetsDao.insertBudget(
        BudgetsCompanion.insert(
          id: const Value('b2'),
          name: 'B',
          amount: 200,
          period: BudgetPeriod.yearly,
          startDate: now,
        ),
      );
      expect((await db.budgetsDao.getAllBudgets()).length, 2);
    });

    test('getRecordsForBudget empty if none', () async {
      final now = DateTime.now().toUtc();
      await db.budgetsDao.insertBudget(
        BudgetsCompanion.insert(
          id: const Value('b1'),
          name: 'A',
          amount: 100,
          period: BudgetPeriod.monthly,
          startDate: now,
        ),
      );
      expect(await db.budgetsDao.getRecordsForBudget('b1'), isEmpty);
    });

    test('getSpentAmountForBudget returns 0 with no transactions', () async {
      final now = DateTime.now().toUtc();
      final spent = await db.budgetsDao.getSpentAmountForBudget(
        startDate: now.subtract(const Duration(days: 30)),
        endDate: now,
      );
      expect(spent, 0);
    });

    test('getSpentAmountForBudget sums expense transactions in range', () async {
      final now = DateTime.now().toUtc();
      // Setup account and category
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(id: const Value('acc1'), name: 'Wallet', type: AccountType.assets),
          );
      await db
          .into(db.categories)
          .insert(
            CategoriesCompanion.insert(id: const Value('cat1'), name: 'Food', type: CategoryType.expense),
          );
      // Insert expense transaction
      await db
          .into(db.transactions)
          .insert(
            TransactionsCompanion.insert(
              id: const Value('tx1'),
              accountId: 'acc1',
              type: TransactionType.expense,
              amount: 300,
              transactionDate: now,
            ),
          );
      await db
          .into(db.transactionItems)
          .insert(
            TransactionItemsCompanion.insert(
              transactionId: 'tx1',
              categoryId: const Value('cat1'),
              amount: 300,
            ),
          );
      // Income transaction should not count
      await db
          .into(db.transactions)
          .insert(
            TransactionsCompanion.insert(
              id: const Value('tx2'),
              accountId: 'acc1',
              type: TransactionType.income,
              amount: 1000,
              transactionDate: now,
            ),
          );
      await db
          .into(db.transactionItems)
          .insert(
            TransactionItemsCompanion.insert(transactionId: 'tx2', amount: 1000),
          );

      final spent = await db.budgetsDao.getSpentAmountForBudget(
        startDate: now.subtract(const Duration(days: 1)),
        endDate: now.add(const Duration(days: 1)),
      );
      expect(spent, 300);
    });

    test('getSpentAmountForBudget filters by categoryId', () async {
      final now = DateTime.now().toUtc();
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(id: const Value('acc1'), name: 'Wallet', type: AccountType.assets),
          );
      await db
          .into(db.categories)
          .insert(
            CategoriesCompanion.insert(id: const Value('cat1'), name: 'Food', type: CategoryType.expense),
          );
      await db
          .into(db.categories)
          .insert(
            CategoriesCompanion.insert(id: const Value('cat2'), name: 'Transport', type: CategoryType.expense),
          );
      await db
          .into(db.transactions)
          .insert(
            TransactionsCompanion.insert(
              id: const Value('tx1'),
              accountId: 'acc1',
              type: TransactionType.expense,
              amount: 500,
              transactionDate: now,
            ),
          );
      await db
          .into(db.transactionItems)
          .insert(
            TransactionItemsCompanion.insert(transactionId: 'tx1', categoryId: const Value('cat1'), amount: 200),
          );
      await db
          .into(db.transactionItems)
          .insert(
            TransactionItemsCompanion.insert(transactionId: 'tx1', categoryId: const Value('cat2'), amount: 300),
          );

      final spent = await db.budgetsDao.getSpentAmountForBudget(
        startDate: now.subtract(const Duration(days: 1)),
        endDate: now.add(const Duration(days: 1)),
        categoryId: 'cat1',
      );
      expect(spent, 200);
    });

    test('getSpentAmountForBudget filters by accountId', () async {
      final now = DateTime.now().toUtc();
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(id: const Value('acc1'), name: 'Wallet', type: AccountType.assets),
          );
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(id: const Value('acc2'), name: 'Bank', type: AccountType.assets),
          );
      await db
          .into(db.transactions)
          .insert(
            TransactionsCompanion.insert(
              id: const Value('tx1'),
              accountId: 'acc1',
              type: TransactionType.expense,
              amount: 100,
              transactionDate: now,
            ),
          );
      await db
          .into(db.transactionItems)
          .insert(
            TransactionItemsCompanion.insert(transactionId: 'tx1', amount: 100),
          );
      await db
          .into(db.transactions)
          .insert(
            TransactionsCompanion.insert(
              id: const Value('tx2'),
              accountId: 'acc2',
              type: TransactionType.expense,
              amount: 400,
              transactionDate: now,
            ),
          );
      await db
          .into(db.transactionItems)
          .insert(
            TransactionItemsCompanion.insert(transactionId: 'tx2', amount: 400),
          );

      final spent = await db.budgetsDao.getSpentAmountForBudget(
        startDate: now.subtract(const Duration(days: 1)),
        endDate: now.add(const Duration(days: 1)),
        accountId: 'acc1',
      );
      expect(spent, 100);
    });
  });
}
