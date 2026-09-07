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

  group('DebtsDao', () {
    test('getAllDebts empty initially', () async {
      expect(await db.debtsDao.getAllDebts(), isEmpty);
    });

    test('insert and getDebt', () async {
      await db.debtsDao.insertDebt(
        DebtsCompanion.insert(
          id: const Value('d1'),
          personName: 'Alice',
          type: DebtType.debt,
          amount: 100000,
          remainingAmount: 100000,
          status: DebtStatus.active,
        ),
      );
      final d = await db.debtsDao.getDebt('d1');
      expect(d, isNotNull);
      expect(d!.personName, 'Alice');
      expect(d.type, DebtType.debt);
      expect(d.status, DebtStatus.active);
    });

    test('getDebt returns null for unknown', () async {
      expect(await db.debtsDao.getDebt('none'), isNull);
    });

    test('getActiveDebts filters paid', () async {
      await db.debtsDao.insertDebt(
        DebtsCompanion.insert(
          id: const Value('d1'),
          personName: 'A',
          type: DebtType.debt,
          amount: 100,
          remainingAmount: 100,
          status: DebtStatus.active,
        ),
      );
      await db.debtsDao.insertDebt(
        DebtsCompanion.insert(
          id: const Value('d2'),
          personName: 'B',
          type: DebtType.loan,
          amount: 200,
          remainingAmount: 0,
          status: DebtStatus.paid,
        ),
      );
      final active = await db.debtsDao.getActiveDebts();
      expect(active.length, 1);
      expect(active.first.id, 'd1');
    });

    test('updateDebt modifies fields', () async {
      await db.debtsDao.insertDebt(
        DebtsCompanion.insert(
          id: const Value('d1'),
          personName: 'Old',
          type: DebtType.debt,
          amount: 100,
          remainingAmount: 100,
          status: DebtStatus.active,
        ),
      );
      await (db.update(db.debts)..where((t) => t.id.equals('d1'))).write(
        const DebtsCompanion(personName: Value('New'), remainingAmount: Value(50)),
      );
      final d = await db.debtsDao.getDebt('d1');
      expect(d!.personName, 'New');
      expect(d.remainingAmount, 50);
    });

    test('deleteDebt removes', () async {
      await db.debtsDao.insertDebt(
        DebtsCompanion.insert(
          id: const Value('d1'),
          personName: 'X',
          type: DebtType.loan,
          amount: 500,
          remainingAmount: 500,
          status: DebtStatus.active,
        ),
      );
      await db.debtsDao.deleteDebt('d1');
      expect(await db.debtsDao.getDebt('d1'), isNull);
    });

    test('getAllDebts returns all statuses', () async {
      await db.debtsDao.insertDebt(
        DebtsCompanion.insert(
          id: const Value('d1'),
          personName: 'A',
          type: DebtType.debt,
          amount: 100,
          remainingAmount: 100,
          status: DebtStatus.active,
        ),
      );
      await db.debtsDao.insertDebt(
        DebtsCompanion.insert(
          id: const Value('d2'),
          personName: 'B',
          type: DebtType.debt,
          amount: 200,
          remainingAmount: 0,
          status: DebtStatus.paid,
        ),
      );
      expect((await db.debtsDao.getAllDebts()).length, 2);
    });

    test('loan vs debt type stored lowercase', () async {
      await db.debtsDao.insertDebt(
        DebtsCompanion.insert(
          id: const Value('d1'),
          personName: 'Lender',
          type: DebtType.loan,
          amount: 1000,
          remainingAmount: 1000,
          status: DebtStatus.active,
        ),
      );
      final raw = await db
          .customSelect('SELECT type FROM debts WHERE id = ?', variables: [Variable.withString('d1')])
          .getSingle();
      expect(raw.data['type'], 'loan');
      final rawStatus = await db
          .customSelect('SELECT status FROM debts WHERE id = ?', variables: [Variable.withString('d1')])
          .getSingle();
      expect(rawStatus.data['status'], 'active');
    });

    test('with dueDate and note', () async {
      final due = DateTime.utc(2026, 12, 31);
      await db.debtsDao.insertDebt(
        DebtsCompanion.insert(
          id: const Value('d1'),
          personName: 'Bob',
          type: DebtType.debt,
          amount: 500000,
          remainingAmount: 300000,
          status: DebtStatus.active,
          dueDate: Value(due),
          note: const Value('urgent'),
        ),
      );
      final d = await db.debtsDao.getDebt('d1');
      expect(d!.dueDate!.toUtc(), due.toUtc());
      expect(d.note, 'urgent');
    });

    test('insertDebtWithTransaction for debt creates income and increases balance', () async {
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(
              id: const Value('acc1'),
              name: 'Wallet',
              type: AccountType.assets,
              balance: const Value(50000),
            ),
          );

      final debt = DebtsCompanion.insert(
        id: const Value('d1'),
        personName: 'Charlie',
        type: DebtType.debt,
        amount: 20000,
        remainingAmount: 20000,
        status: DebtStatus.active,
      );

      final tx = TransactionsCompanion.insert(
        id: const Value('tx1'),
        accountId: 'acc1',
        type: TransactionType.income,
        amount: 20000,
        debtId: const Value('d1'),
        transactionDate: DateTime.now().toUtc(),
      );

      final item = TransactionItemsCompanion.insert(
        id: const Value('item1'),
        transactionId: 'tx1',
        amount: 20000,
      );

      await db.debtsDao.insertDebtWithTransaction(debt, tx, item);

      final savedDebt = await db.debtsDao.getDebt('d1');
      expect(savedDebt, isNotNull);
      expect(savedDebt!.amount, 20000);

      final savedTx = await db.transactionsDao.getTransaction('tx1');
      expect(savedTx, isNotNull);
      expect(savedTx!.amount, 20000);

      final acc = await (db.select(db.accounts)..where((a) => a.id.equals('acc1'))).getSingle();
      expect(acc.balance, 70000);
    });

    test('deleteDebtWithTransactionReversal reverts account balance and deletes transactions', () async {
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(
              id: const Value('acc1'),
              name: 'Wallet',
              type: AccountType.assets,
              balance: const Value(100000),
            ),
          );

      // Loan -> expense of 30,000 -> balance becomes 70,000
      final debt = DebtsCompanion.insert(
        id: const Value('d1'),
        personName: 'Dave',
        type: DebtType.loan,
        amount: 30000,
        remainingAmount: 30000,
        status: DebtStatus.active,
      );

      final tx = TransactionsCompanion.insert(
        id: const Value('tx1'),
        accountId: 'acc1',
        type: TransactionType.expense,
        amount: 30000,
        debtId: const Value('d1'),
        transactionDate: DateTime.now().toUtc(),
      );

      final item = TransactionItemsCompanion.insert(
        id: const Value('item1'),
        transactionId: 'tx1',
        amount: 30000,
      );

      await db.debtsDao.insertDebtWithTransaction(debt, tx, item);
      var acc = await (db.select(db.accounts)..where((a) => a.id.equals('acc1'))).getSingle();
      expect(acc.balance, 70000);

      // Delete debt with reversal
      await db.debtsDao.deleteDebtWithTransactionReversal('d1');

      expect(await db.debtsDao.getDebt('d1'), isNull);
      expect(await db.transactionsDao.getTransaction('tx1'), isNull);

      // Balance should be reverted back to 100,000
      acc = await (db.select(db.accounts)..where((a) => a.id.equals('acc1'))).getSingle();
      expect(acc.balance, 100000);
    });

    test('insertDebtWithTransaction and deleteDebtWithTransactionReversal update budget records', () async {
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(
              id: const Value('acc1'),
              name: 'Wallet',
              type: AccountType.assets,
              balance: const Value(100000),
            ),
          );

      // Create a monthly budget covering this period
      final now = DateTime.now().toUtc();
      final start = DateTime.utc(now.year, now.month, 1);
      final end = DateTime.utc(now.year, now.month + 1, 0, 23, 59, 59);
      await db
          .into(db.budgets)
          .insert(
            BudgetsCompanion.insert(
              id: const Value('b1'),
              name: 'General Spending',
              amount: 500000,
              period: BudgetPeriod.monthly,
              resetDay: const Value(1),
              alertThreshold: const Value(80),
              startDate: start,
              endDate: Value(end),
            ),
          );
      await db
          .into(db.budgetRecords)
          .insert(
            BudgetRecordsCompanion.insert(
              id: const Value('br1'),
              budgetId: 'b1',
              periodStart: start,
              periodEnd: end,
              spentAmount: const Value(0),
            ),
          );

      // Loan -> expense of 30,000 -> balance becomes 70,000, budget spent becomes 30,000
      final debt = DebtsCompanion.insert(
        id: const Value('d1'),
        personName: 'Dave',
        type: DebtType.loan,
        amount: 30000,
        remainingAmount: 30000,
        status: DebtStatus.active,
      );

      final tx = TransactionsCompanion.insert(
        id: const Value('tx1'),
        accountId: 'acc1',
        type: TransactionType.expense,
        amount: 30000,
        debtId: const Value('d1'),
        transactionDate: now,
      );

      final item = TransactionItemsCompanion.insert(
        id: const Value('item1'),
        transactionId: 'tx1',
        amount: 30000,
      );

      await db.debtsDao.insertDebtWithTransaction(debt, tx, item);

      var br = await (db.select(db.budgetRecords)..where((r) => r.id.equals('br1'))).getSingle();
      expect(br.spentAmount, 30000);

      // Reversal should subtract the 30,000 back to 0
      await db.debtsDao.deleteDebtWithTransactionReversal('d1');

      br = await (db.select(db.budgetRecords)..where((r) => r.id.equals('br1'))).getSingle();
      expect(br.spentAmount, 0);
    });
  });
}
