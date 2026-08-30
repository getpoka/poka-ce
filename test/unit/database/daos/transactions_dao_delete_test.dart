import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  setUp(() => db = AppDatabase(connection: NativeDatabase.memory()));
  tearDown(() async => db.close());

  group('TransactionsDao deleteTransaction reverts balance', () {
    Future<void> addAccount(String id, int balance) async {
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(id: Value(id), name: 'A', type: AccountType.assets, balance: Value(balance)),
          );
    }

    test('delete income reverts balance', () async {
      await addAccount('acc1', 0);
      await db.transactionsDao.insertTransactionWithItems(
        TransactionsCompanion.insert(
          id: const Value('txn1'),
          accountId: 'acc1',
          type: TransactionType.income,
          amount: 50000,
          transactionDate: DateTime.now().toUtc(),
        ),
        [],
      );
      var acc = await (db.select(db.accounts)..where((a) => a.id.equals('acc1'))).getSingle();
      expect(acc.balance, 50000);
      await db.transactionsDao.deleteTransaction('txn1');
      acc = await (db.select(db.accounts)..where((a) => a.id.equals('acc1'))).getSingle();
      expect(acc.balance, 0);
      expect(await db.transactionsDao.getTransaction('txn1'), isNull);
    });

    test('delete expense reverts balance', () async {
      await addAccount('acc1', 100000);
      await db.transactionsDao.insertTransactionWithItems(
        TransactionsCompanion.insert(
          id: const Value('txn1'),
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 20000,
          transactionDate: DateTime.now().toUtc(),
        ),
        [],
      );
      var acc = await (db.select(db.accounts)..where((a) => a.id.equals('acc1'))).getSingle();
      expect(acc.balance, 80000);
      await db.transactionsDao.deleteTransaction('txn1');
      acc = await (db.select(db.accounts)..where((a) => a.id.equals('acc1'))).getSingle();
      expect(acc.balance, 100000);
    });

    test('delete transfer reverts both accounts', () async {
      await addAccount('src', 100000);
      await addAccount('dst', 50000);
      await db.transactionsDao.insertTransactionWithItems(
        TransactionsCompanion.insert(
          id: const Value('txn1'),
          accountId: 'src',
          destinationAccountId: const Value('dst'),
          type: TransactionType.transfer,
          amount: 30000,
          transactionDate: DateTime.now().toUtc(),
        ),
        [],
      );
      var src = await (db.select(db.accounts)..where((a) => a.id.equals('src'))).getSingle();
      var dst = await (db.select(db.accounts)..where((a) => a.id.equals('dst'))).getSingle();
      expect(src.balance, 70000);
      expect(dst.balance, 80000);
      await db.transactionsDao.deleteTransaction('txn1');
      src = await (db.select(db.accounts)..where((a) => a.id.equals('src'))).getSingle();
      dst = await (db.select(db.accounts)..where((a) => a.id.equals('dst'))).getSingle();
      expect(src.balance, 100000);
      expect(dst.balance, 50000);
    });

    test('delete transfer without destination only reverts source', () async {
      await addAccount('src', 100000);
      await db.transactionsDao.insertTransactionWithItems(
        TransactionsCompanion.insert(
          id: const Value('txn1'),
          accountId: 'src',
          type: TransactionType.transfer,
          amount: 10000,
          transactionDate: DateTime.now().toUtc(),
        ),
        [],
      );
      await db.transactionsDao.deleteTransaction('txn1');
      final src = await (db.select(db.accounts)..where((a) => a.id.equals('src'))).getSingle();
      expect(src.balance, 100000);
    });

    test('delete non-existing does nothing', () async {
      await addAccount('acc1', 5000);
      await db.transactionsDao.deleteTransaction('nonexistent');
      final acc = await (db.select(db.accounts)..where((a) => a.id.equals('acc1'))).getSingle();
      expect(acc.balance, 5000);
    });

    test('watchAllTransactions streams ordered', () async {
      await addAccount('acc1', 0);
      final stream = db.transactionsDao.watchAllTransactions();
      final first = await stream.first;
      expect(first, isEmpty);
      await db.transactionsDao.insertTransactionWithItems(
        TransactionsCompanion.insert(
          id: const Value('txn1'),
          accountId: 'acc1',
          type: TransactionType.income,
          amount: 100,
          transactionDate: DateTime.utc(2026, 1, 1),
        ),
        [],
      );
      final after = await db.transactionsDao.watchAllTransactions().first;
      expect(after.length, 1);
      expect(after.first.id, 'txn1');
    });

    test('watchAllTransactionsWithItems groups correctly', () async {
      await addAccount('acc1', 0);
      await db.transactionsDao.insertTransactionWithItems(
        TransactionsCompanion.insert(
          id: const Value('txn1'),
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 100,
          transactionDate: DateTime.now().toUtc(),
        ),
        [const TransactionItemsCompanion(id: Value('i1'), amount: Value(100))],
      );
      final grouped = await db.transactionsDao.watchAllTransactionsWithItems().first;
      expect(grouped.length, 1);
      expect(grouped.first.items.length, 1);
    });

    test('getAllTransactionsWithItems groups', () async {
      await addAccount('acc1', 0);
      await db.transactionsDao.insertTransactionWithItems(
        TransactionsCompanion.insert(
          id: const Value('txn1'),
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 200,
          transactionDate: DateTime.now().toUtc(),
        ),
        [
          const TransactionItemsCompanion(id: Value('i1'), amount: Value(100)),
          const TransactionItemsCompanion(id: Value('i2'), amount: Value(100)),
        ],
      );
      final list = await db.transactionsDao.getAllTransactionsWithItems();
      expect(list.length, 1);
      expect(list.first.items.length, 2);
    });
  });
}
