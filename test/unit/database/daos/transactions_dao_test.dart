import 'package:drift/drift.dart';
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

  test('insertTransactionWithItems updates balance correctly for income', () async {
    const accountId = 'acc1';
    await db
        .into(db.accounts)
        .insert(
          AccountsCompanion.insert(
            id: const Value('acc1'),
            name: 'Wallet',
            type: AccountType.assets,
            balance: const Value(0),
          ),
        );

    await db.transactionsDao.insertTransactionWithItems(
      TransactionsCompanion.insert(
        id: const Value('txn1'),
        accountId: accountId,
        type: TransactionType.income,
        amount: 50000,
        transactionDate: DateTime.now().toUtc(),
      ),
      [
        const TransactionItemsCompanion(
          id: Value('item1'),
          amount: Value(50000),
        ),
      ],
    );

    final account = await (db.select(db.accounts)..where((a) => a.id.equals(accountId))).getSingle();
    expect(account.balance, 50000);
  });

  test('insertTransactionWithItems updates balance correctly for expense', () async {
    const accountId = 'acc1';
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

    await db.transactionsDao.insertTransactionWithItems(
      TransactionsCompanion.insert(
        id: const Value('txn1'),
        accountId: accountId,
        type: TransactionType.expense,
        amount: 20000,
        transactionDate: DateTime.now().toUtc(),
      ),
      [],
    );

    final account = await (db.select(db.accounts)..where((a) => a.id.equals(accountId))).getSingle();
    expect(account.balance, 80000);
  });

  test('insertTransactionWithItems updates balance correctly for transfer', () async {
    const srcId = 'acc1';
    const destId = 'acc2';
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
    await db
        .into(db.accounts)
        .insert(
          AccountsCompanion.insert(
            id: const Value('acc2'),
            name: 'Bank',
            type: AccountType.assets,
            balance: const Value(50000),
          ),
        );

    await db.transactionsDao.insertTransactionWithItems(
      TransactionsCompanion.insert(
        id: const Value('txn1'),
        accountId: srcId,
        destinationAccountId: const Value('acc2'),
        type: TransactionType.transfer,
        amount: 30000,
        transactionDate: DateTime.now().toUtc(),
      ),
      [],
    );

    final srcAccount = await (db.select(db.accounts)..where((a) => a.id.equals(srcId))).getSingle();
    final destAccount = await (db.select(db.accounts)..where((a) => a.id.equals(destId))).getSingle();

    expect(srcAccount.balance, 70000);
    expect(destAccount.balance, 80000);
  });
}
