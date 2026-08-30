import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/database.dart';

/// Exercises direct row-object inserts so the generated `toColumns`,
/// `toCompanion` and upsert code paths are covered for every table.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  final now = DateTime(2026, 8, 23);

  setUp(() async {
    db = AppDatabase(connection: NativeDatabase.memory());
    await db.delete(db.debts).go();
    await db.delete(db.recurringTransactions).go();
    await db.delete(db.goals).go();
    await db.delete(db.transactionItems).go();
    await db.delete(db.transactions).go();
    await db.delete(db.budgetRecords).go();
    await db.delete(db.budgets).go();
    await db.delete(db.accountCategories).go();
    await db.delete(db.accounts).go();
    await db.delete(db.categories).go();
    await db.delete(db.settings).go();
    await db.delete(db.currencies).go();
  });
  tearDown(() async => db.close());

  Future<void> seedParents() async {
    await db
        .into(db.accounts)
        .insert(AccountsCompanion.insert(id: const Value('acc'), name: 'Main', type: AccountType.assets));
    await db
        .into(db.categories)
        .insert(CategoriesCompanion.insert(id: const Value('cat'), name: 'Food', type: CategoryType.expense));
    await db
        .into(db.currencies)
        .insert(
          CurrenciesCompanion.insert(id: const Value('cur'), name: 'Rupiah', code: 'IDR', symbol: 'Rp'),
        );
    await db.into(db.settings).insert(SettingsCompanion.insert(key: 'base_currency', value: 'IDR'));
  }

  test('every table accepts raw row inserts and upserts', () async {
    await seedParents();

    final account = Account(
      initialBalance: 0,
      id: 'acc2',
      name: 'Bank',
      type: AccountType.liability,
      icon: 'wallet',
      balance: 1000,
      parentId: 'acc',
      sort: 0,
      isActive: true,
      createdAt: now,
      updatedAt: now,
    );
    final category = Category(
      id: 'cat2',
      name: 'Transport',
      type: CategoryType.expense,
      icon: 'car',
      color: '#123456',
      parentId: 'cat',
      sort: 0,
      isActive: true,
      createdAt: now,
      updatedAt: now,
    );
    final budget = Budget(
      id: 'b1',
      name: 'Food',
      amount: 1000000,
      categoryId: 'cat2',
      accountId: 'acc2',
      period: BudgetPeriod.monthly,
      resetDay: 25,
      startDate: now,
      endDate: DateTime(2026, 12, 31),
      createdAt: now,
      updatedAt: now,
    );
    final budgetRecord = BudgetRecord(
      id: 'br1',
      budgetId: 'b1',
      spentAmount: 50000,
      periodStart: now,
      periodEnd: DateTime(2026, 8, 31),
      createdAt: now,
      updatedAt: now,
    );
    final debt = Debt(
      id: 'd1',
      personName: 'Budi',
      type: DebtType.debt,
      amount: 500000,
      remainingAmount: 250000,
      status: DebtStatus.active,
      dueDate: DateTime(2026, 10, 1),
      note: 'pinjaman',
      createdAt: now,
      updatedAt: now,
    );
    final recurring = RecurringTransaction(
      id: 'r1',
      accountId: 'acc',
      destinationAccountId: 'acc2',
      categoryId: 'cat2',
      type: TransactionType.transfer,
      amount: 200000,
      note: 'bulanan',
      period: RecurringPeriod.monthly,
      nextDate: now,
      isActive: true,
      createdAt: now,
      updatedAt: now,
    );
    final transaction = Transaction(
      id: 't1',
      accountId: 'acc',
      destinationAccountId: 'acc2',
      type: TransactionType.transfer,
      amount: 150000,
      transactionDate: now,
      note: 'transfer rutin',
      recurringTransactionId: 'r1',
      debtId: 'd1',
      createdAt: now,
      updatedAt: now,
    );
    final item = TransactionItem(
      id: 'i1',
      transactionId: 't1',
      categoryId: 'cat2',
      allocation: TransactionAllocation.want,
      amount: 150000,
      note: 'alokasi',
      createdAt: now,
      updatedAt: now,
    );
    final goal = Goal(
      id: 'g1',
      accountId: 'acc2',
      name: 'Trip',
      targetAmount: 5000000,
      targetDate: DateTime(2027, 1, 1),
      status: GoalStatus.active,
      icon: 'plane',
      color: '#ABCDEF',
      createdAt: now,
      updatedAt: now,
    );

    // Row objects implement Insertable: exercises toColumns(nullToAbsent: false).
    await db.into(db.accounts).insert(account);
    await db.into(db.categories).insert(category);
    await db.into(db.budgets).insert(budget);
    await db.into(db.budgetRecords).insert(budgetRecord);
    await db.into(db.debts).insert(debt);
    await db.into(db.recurringTransactions).insert(recurring);
    await db.into(db.transactions).insert(transaction);
    await db.into(db.transactionItems).insert(item);
    await db.into(db.goals).insert(goal);

    // Upsert path exercises toCompanion.
    await (db.into(db.accounts)).insertOnConflictUpdate(account.copyWith(balance: 2000));
    await (db.into(db.categories)).insertOnConflictUpdate(category);
    await (db.into(db.budgets)).insertOnConflictUpdate(budget);
    await (db.into(db.budgetRecords)).insertOnConflictUpdate(budgetRecord);
    await (db.into(db.debts)).insertOnConflictUpdate(debt);
    await (db.into(db.recurringTransactions)).insertOnConflictUpdate(recurring);
    await (db.into(db.transactions)).insertOnConflictUpdate(transaction);
    await (db.into(db.transactionItems)).insertOnConflictUpdate(item);
    await (db.into(db.goals)).insertOnConflictUpdate(goal);

    // Batch insert exercises toColumns(nullToAbsent: true).
    final currency = Currency(
      id: 'cur2',
      name: 'Dollar',
      code: 'USD',
      symbol: '\$',
      precision: 2,
      createdAt: now,
      updatedAt: now,
    );
    final setting = Setting(key: 'theme', value: 'dark', updatedAt: now);
    await db.batch((b) {
      b.insert(db.currencies, currency);
      b.insert(db.settings, setting);
      b.replaceAll(db.currencies, <Currency>[currency.copyWith(name: 'US Dollar')]);
    });

    expect((await db.select(db.accounts).get()).length, 2);
    expect(
      await (db.select(db.accounts)..where((a) => a.id.equals('acc2'))).getSingle().then((r) => r.balance),
      2000,
    );
    expect((await db.select(db.budgetRecords).get()).single.spentAmount, 50000);
    expect((await db.select(db.goals).get()).single.targetAmount, 5000000);
    expect(
      await (db.select(db.currencies)..where((c) => c.code.equals('USD'))).getSingle().then((r) => r.name),
      'US Dollar',
    );
    expect(
      await (db.select(db.settings)..where((s) => s.key.equals('theme'))).getSingle().then((r) => r.value),
      'dark',
    );
  });
}
