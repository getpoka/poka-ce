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

  group('TransactionsDao expanded - mutation hardening', () {
    test('getAllTransactions ordered by transactionDate desc', () async {
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('acc1'), name: 'W', type: AccountType.assets));
      final t1 = DateTime.utc(2026);
      final t2 = DateTime.utc(2026, 6);
      await db.transactionsDao.insertTransactionWithItems(
        TransactionsCompanion.insert(
          id: const Value('txn1'),
          accountId: 'acc1',
          type: TransactionType.income,
          amount: 100,
          transactionDate: t1,
        ),
        [],
      );
      await db.transactionsDao.insertTransactionWithItems(
        TransactionsCompanion.insert(
          id: const Value('txn2'),
          accountId: 'acc1',
          type: TransactionType.income,
          amount: 200,
          transactionDate: t2,
        ),
        [],
      );
      final all = await db.transactionsDao.getAllTransactions();
      expect(all.length, 2);
      expect(all.first.id, 'txn2'); // most recent first
    });

    test('getTransaction returns correct or null', () async {
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('acc1'), name: 'W', type: AccountType.assets));
      await db.transactionsDao.insertTransactionWithItems(
        TransactionsCompanion.insert(
          id: const Value('txn1'),
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 500,
          transactionDate: DateTime.now().toUtc(),
        ),
        [],
      );
      expect((await db.transactionsDao.getTransaction('txn1'))!.amount, 500);
      expect(await db.transactionsDao.getTransaction('none'), isNull);
    });

    test('getTransactionItems filters by transactionId', () async {
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('acc1'), name: 'W', type: AccountType.assets));
      await db
          .into(db.categories)
          .insert(CategoriesCompanion.insert(id: const Value('cat1'), name: 'Food', type: CategoryType.expense));
      await db.transactionsDao.insertTransactionWithItems(
        TransactionsCompanion.insert(
          id: const Value('txn1'),
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 15000,
          transactionDate: DateTime.now().toUtc(),
        ),
        [
          TransactionItemsCompanion.insert(
            id: const Value('i1'),
            transactionId: 'txn1',
            amount: 10000,
            categoryId: const Value('cat1'),
          ),
          TransactionItemsCompanion.insert(id: const Value('i2'), transactionId: 'txn1', amount: 5000),
        ],
      );
      final items = await db.transactionsDao.getTransactionItems('txn1');
      expect(items.length, 2);
      expect(items.map((e) => e.amount).toSet(), {10000, 5000});
      expect(await db.transactionsDao.getTransactionItems('none'), isEmpty);
    });

    test('balance mutation: income adds exact amount (mutation + to -)', () async {
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(
              id: const Value('acc1'),
              name: 'W',
              type: AccountType.assets,
              balance: const Value(10000),
            ),
          );
      await db.transactionsDao.insertTransactionWithItems(
        TransactionsCompanion.insert(
          id: const Value('txn1'),
          accountId: 'acc1',
          type: TransactionType.income,
          amount: 1,
          transactionDate: DateTime.now().toUtc(),
        ),
        [],
      );
      final acc = await (db.select(db.accounts)..where((a) => a.id.equals('acc1'))).getSingle();
      expect(acc.balance, 10001);
    });

    test('balance mutation: expense subtracts exact amount (mutation - to +)', () async {
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(
              id: const Value('acc1'),
              name: 'W',
              type: AccountType.assets,
              balance: const Value(10000),
            ),
          );
      await db.transactionsDao.insertTransactionWithItems(
        TransactionsCompanion.insert(
          id: const Value('txn1'),
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 1,
          transactionDate: DateTime.now().toUtc(),
        ),
        [],
      );
      final acc = await (db.select(db.accounts)..where((a) => a.id.equals('acc1'))).getSingle();
      expect(acc.balance, 9999);
    });

    test('balance mutation: transfer subtracts source and adds dest exact', () async {
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(
              id: const Value('src'),
              name: 'Src',
              type: AccountType.assets,
              balance: const Value(10000),
            ),
          );
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(
              id: const Value('dst'),
              name: 'Dst',
              type: AccountType.assets,
              balance: const Value(20000),
            ),
          );
      await db.transactionsDao.insertTransactionWithItems(
        TransactionsCompanion.insert(
          id: const Value('txn1'),
          accountId: 'src',
          destinationAccountId: const Value('dst'),
          type: TransactionType.transfer,
          amount: 4000,
          transactionDate: DateTime.now().toUtc(),
        ),
        [],
      );
      final src = await (db.select(db.accounts)..where((a) => a.id.equals('src'))).getSingle();
      final dst = await (db.select(db.accounts)..where((a) => a.id.equals('dst'))).getSingle();
      expect(src.balance, 6000);
      expect(dst.balance, 24000);
    });

    test('transfer without destination only subtracts source (no dest add)', () async {
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(
              id: const Value('src'),
              name: 'Src',
              type: AccountType.assets,
              balance: const Value(10000),
            ),
          );
      await db.transactionsDao.insertTransactionWithItems(
        TransactionsCompanion.insert(
          id: const Value('txn1'),
          accountId: 'src',
          type: TransactionType.transfer,
          amount: 3000,
          transactionDate: DateTime.now().toUtc(),
        ),
        [],
      );
      final src = await (db.select(db.accounts)..where((a) => a.id.equals('src'))).getSingle();
      expect(src.balance, 7000);
    });

    test('insert with multiple items persists all with correct transactionId', () async {
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(
              id: const Value('acc1'),
              name: 'W',
              type: AccountType.assets,
              balance: const Value(0),
            ),
          );
      await db
          .into(db.categories)
          .insert(CategoriesCompanion.insert(id: const Value('cat1'), name: 'Food', type: CategoryType.expense));
      await db
          .into(db.categories)
          .insert(CategoriesCompanion.insert(id: const Value('cat2'), name: 'Transport', type: CategoryType.expense));
      await db.transactionsDao.insertTransactionWithItems(
        TransactionsCompanion.insert(
          id: const Value('txn1'),
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 30000,
          transactionDate: DateTime.now().toUtc(),
        ),
        [
          TransactionItemsCompanion.insert(
            id: const Value('i1'),
            transactionId: 'placeholder',
            amount: 20000,
            categoryId: const Value('cat1'),
          ),
          TransactionItemsCompanion.insert(
            id: const Value('i2'),
            transactionId: 'placeholder',
            amount: 10000,
            categoryId: const Value('cat2'),
          ),
        ],
      );
      final items = await db.transactionsDao.getTransactionItems('txn1');
      expect(items.length, 2);
      for (final i in items) {
        expect(i.transactionId, 'txn1');
      }
    });

    test('sequential transactions cumulative balance correct (mutation catch on order)', () async {
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(
              id: const Value('acc1'),
              name: 'W',
              type: AccountType.assets,
              balance: const Value(0),
            ),
          );
      await db.transactionsDao.insertTransactionWithItems(
        TransactionsCompanion.insert(
          id: const Value('t1'),
          accountId: 'acc1',
          type: TransactionType.income,
          amount: 100000,
          transactionDate: DateTime.utc(2026),
        ),
        [],
      );
      await db.transactionsDao.insertTransactionWithItems(
        TransactionsCompanion.insert(
          id: const Value('t2'),
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 30000,
          transactionDate: DateTime.utc(2026, 1, 2),
        ),
        [],
      );
      await db.transactionsDao.insertTransactionWithItems(
        TransactionsCompanion.insert(
          id: const Value('t3'),
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 20000,
          transactionDate: DateTime.utc(2026, 1, 3),
        ),
        [],
      );
      final acc = await (db.select(db.accounts)..where((a) => a.id.equals('acc1'))).getSingle();
      expect(acc.balance, 50000); // 100k -30k -20k
    });

    test('transaction with linked debtId persists FK', () async {
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('acc1'), name: 'W', type: AccountType.assets));
      await db
          .into(db.debts)
          .insert(
            DebtsCompanion.insert(
              id: const Value('d1'),
              personName: 'Alice',
              type: DebtType.debt,
              amount: 10000,
              remainingAmount: 10000,
              status: DebtStatus.active,
            ),
          );
      await db.transactionsDao.insertTransactionWithItems(
        TransactionsCompanion.insert(
          id: const Value('txn1'),
          accountId: 'acc1',
          type: TransactionType.income,
          amount: 10000,
          transactionDate: DateTime.now().toUtc(),
          debtId: const Value('d1'),
        ),
        [],
      );
      final txn = await db.transactionsDao.getTransaction('txn1');
      expect(txn!.debtId, 'd1');
    });

    test('transaction with recurring link persists', () async {
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('acc1'), name: 'W', type: AccountType.assets));
      await db
          .into(db.recurringTransactions)
          .insert(
            RecurringTransactionsCompanion.insert(
              id: const Value('rec1'),
              accountId: 'acc1',
              type: TransactionType.expense,
              amount: 5000,
              period: RecurringPeriod.monthly,
              nextDate: DateTime.now().toUtc(),
            ),
          );
      await db.transactionsDao.insertTransactionWithItems(
        TransactionsCompanion.insert(
          id: const Value('txn1'),
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 5000,
          transactionDate: DateTime.now().toUtc(),
          recurringTransactionId: const Value('rec1'),
        ),
        [],
      );
      final txn = await db.transactionsDao.getTransaction('txn1');
      expect(txn!.recurringTransactionId, 'rec1');
    });

    test('zero amount does not change balance', () async {
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(
              id: const Value('acc1'),
              name: 'W',
              type: AccountType.assets,
              balance: const Value(5000),
            ),
          );
      await db.transactionsDao.insertTransactionWithItems(
        TransactionsCompanion.insert(
          id: const Value('txn1'),
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 0,
          transactionDate: DateTime.now().toUtc(),
        ),
        [],
      );
      final acc = await (db.select(db.accounts)..where((a) => a.id.equals('acc1'))).getSingle();
      expect(acc.balance, 5000);
    });
  });
}
