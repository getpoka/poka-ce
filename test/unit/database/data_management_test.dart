import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/database.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(connection: NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('Data Management', () {
    test('resetAllData clears tables', () async {
      // First, create a dummy account and transaction to ensure there is user data
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(
              id: const Value('acc1'),
              name: 'My Wallet',
              type: AccountType.assets,
              balance: const Value(1000),
            ),
          );

      await db
          .into(db.transactions)
          .insert(
            TransactionsCompanion.insert(
              id: const Value('tx1'),
              accountId: 'acc1',
              type: TransactionType.income,
              amount: 1000,
              transactionDate: DateTime.now(),
            ),
          );

      // Verify data is inserted
      var accounts = await db.select(db.accounts).get();
      expect(accounts.length, greaterThanOrEqualTo(2)); // Cash + acc1

      var transactions = await db.select(db.transactions).get();
      expect(transactions.length, 1);

      // Now reset data
      await db.resetAllData();

      // Verify user data is cleared
      accounts = await db.select(db.accounts).get();
      expect(accounts.length, 1); // Should only have the default Cash account
      expect(accounts.first.name, 'Cash');

      transactions = await db.select(db.transactions).get();
      expect(transactions.isEmpty, isTrue);
    });

    test('clearOldTransactions only deletes old transactions without touching balance', () async {
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(
              id: const Value('acc2'),
              name: 'My Bank',
              type: AccountType.assets,
              balance: const Value(5000), // Balance is 5000
            ),
          );

      final today = DateTime.now();
      final twoYearsAgo = today.subtract(const Duration(days: 730));

      // Insert recent tx
      await db
          .into(db.transactions)
          .insert(
            TransactionsCompanion.insert(
              id: const Value('tx_recent'),
              accountId: 'acc2',
              type: TransactionType.income,
              amount: 1000,
              transactionDate: today,
            ),
          );

      // Insert old tx
      await db
          .into(db.transactions)
          .insert(
            TransactionsCompanion.insert(
              id: const Value('tx_old'),
              accountId: 'acc2',
              type: TransactionType.income,
              amount: 4000,
              transactionDate: twoYearsAgo,
            ),
          );

      var transactions = await db.select(db.transactions).get();
      expect(transactions.length, 2);

      // Clear old transactions (older than 1 year)
      final oneYearAgo = today.subtract(const Duration(days: 365));
      await db.transactionsDao.clearOldTransactions(oneYearAgo);

      transactions = await db.select(db.transactions).get();
      expect(transactions.length, 1); // Only the recent one should remain
      expect(transactions.first.id, 'tx_recent');

      // Check balance is UNTOUCHED
      final account = await (db.select(db.accounts)..where((a) => a.id.equals('acc2'))).getSingle();
      expect(account.balance, 5000); // Balance remains 5000
    });
  });
}
