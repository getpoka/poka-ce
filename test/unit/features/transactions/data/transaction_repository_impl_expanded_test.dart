import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/features/transactions/data/transaction_repository_impl.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  late TransactionRepositoryImpl repo;
  setUp(() {
    db = AppDatabase(connection: NativeDatabase.memory());
    repo = TransactionRepositoryImpl(db.transactionsDao);
  });
  tearDown(() async => db.close());
  final now = DateTimeUtils.nowUtc();

  Future<void> seedAccount(String id, {int balance = 0}) async => db
      .into(db.accounts)
      .insert(
        AccountsCompanion.insert(id: Value(id), name: 'Acc $id', type: AccountType.assets, balance: Value(balance)),
      );

  test('getTransactions empty initially', () async {
    final res = await repo.getTransactions();
    res.fold((v) => expect(v, isEmpty), (e) => fail('fail'));
  });

  test('getTransactionById not found returns error', () async {
    final res = await repo.getTransactionById('none');
    expect(res, isA<ErrorResult<TransactionModel, Failure>>());
  });

  test('createTransaction with single item and verify via get', () async {
    await seedAccount('acc1');
    await db
        .into(db.categories)
        .insert(CategoriesCompanion.insert(id: const Value('cat1'), name: 'Food', type: CategoryType.expense));
    final model = TransactionModel(
      id: 'txn1',
      accountId: 'acc1',
      type: TransactionType.expense,
      amount: 25000,
      transactionDate: now,
      createdAt: now,
      updatedAt: now,
      items: [
        TransactionItemModel(
          id: 'i1',
          transactionId: 'txn1',
          amount: 25000,
          categoryId: 'cat1',
          createdAt: now,
          updatedAt: now,
        ),
      ],
    );
    final createRes = await repo.createTransaction(model);
    expect(createRes, isA<Success<void, Failure>>());
    final getRes = await repo.getTransactionById('txn1');
    getRes.fold((v) {
      expect(v.amount, 25000);
      expect(v.items.length, 1);
      expect(v.items.first.categoryId, 'cat1');
    }, (e) => fail('fail'));
  });

  test('getTransactions returns multiple with items', () async {
    await seedAccount('acc1', balance: 100000);
    final m1 = TransactionModel(
      id: 'txn1',
      accountId: 'acc1',
      type: TransactionType.income,
      amount: 10000,
      transactionDate: now,
      createdAt: now,
      updatedAt: now,
      items: [TransactionItemModel(id: 'i1', transactionId: 'txn1', amount: 10000, createdAt: now, updatedAt: now)],
    );
    final m2 = TransactionModel(
      id: 'txn2',
      accountId: 'acc1',
      type: TransactionType.expense,
      amount: 5000,
      transactionDate: now,
      createdAt: now,
      updatedAt: now,
      items: [TransactionItemModel(id: 'i2', transactionId: 'txn2', amount: 5000, createdAt: now, updatedAt: now)],
    );
    await repo.createTransaction(m1);
    await repo.createTransaction(m2);
    final res = await repo.getTransactions();
    res.fold((v) => expect(v.length, 2), (e) => fail('fail'));
  });

  test('createTransaction split items persists all', () async {
    await seedAccount('acc1');
    final model = TransactionModel(
      id: 'txn1',
      accountId: 'acc1',
      type: TransactionType.expense,
      amount: 30000,
      transactionDate: now,
      createdAt: now,
      updatedAt: now,
      items: [
        TransactionItemModel(id: 'i1', transactionId: 'txn1', amount: 20000, createdAt: now, updatedAt: now),
        TransactionItemModel(id: 'i2', transactionId: 'txn1', amount: 10000, createdAt: now, updatedAt: now),
      ],
    );
    await repo.createTransaction(model);
    final fetched = await repo.getTransactionById('txn1');
    fetched.fold((v) => expect(v.items.length, 2), (e) => fail('fail'));
  });

  test('createTransaction transfer mutates both accounts', () async {
    await seedAccount('src', balance: 100000);
    await seedAccount('dst', balance: 50000);
    final model = TransactionModel(
      id: 'txn1',
      accountId: 'src',
      destinationAccountId: 'dst',
      type: TransactionType.transfer,
      amount: 30000,
      transactionDate: now,
      createdAt: now,
      updatedAt: now,
      items: [TransactionItemModel(id: 'i1', transactionId: 'txn1', amount: 30000, createdAt: now, updatedAt: now)],
    );
    await repo.createTransaction(model);
    final src = await db.accountsDao.getAccount('src');
    final dst = await db.accountsDao.getAccount('dst');
    expect(src!.balance, 70000);
    expect(dst!.balance, 80000);
  });

  test('createTransaction income adds to balance', () async {
    await seedAccount('acc1');
    final model = TransactionModel(
      id: 'txn1',
      accountId: 'acc1',
      type: TransactionType.income,
      amount: 50000,
      transactionDate: now,
      createdAt: now,
      updatedAt: now,
      items: [TransactionItemModel(id: 'i1', transactionId: 'txn1', amount: 50000, createdAt: now, updatedAt: now)],
    );
    await repo.createTransaction(model);
    final acc = await db.accountsDao.getAccount('acc1');
    expect(acc!.balance, 50000);
  });
}
