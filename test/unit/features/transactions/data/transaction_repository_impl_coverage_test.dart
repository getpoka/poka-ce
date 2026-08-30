import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/database/daos/transactions_dao.dart';
import 'package:poka_ce/features/transactions/data/transaction_repository_impl.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';

class MockTransactionsDao extends Mock implements TransactionsDao {}

class FakeTransactionsCompanion extends Fake implements TransactionsCompanion {}

class FakeTransactionItemsCompanion extends Fake implements TransactionItemsCompanion {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    registerFallbackValue(FakeTransactionsCompanion());
    registerFallbackValue(<TransactionItemsCompanion>[]);
    registerFallbackValue(FakeTransactionItemsCompanion());
  });

  late AppDatabase db;
  late TransactionRepositoryImpl realRepo;

  setUp(() {
    db = AppDatabase(connection: NativeDatabase.memory());
    realRepo = TransactionRepositoryImpl(db.transactionsDao);
  });

  tearDown(() async => db.close());

  Future<void> seedAccount(String id) async {
    await db
        .into(db.accounts)
        .insert(
          AccountsCompanion.insert(
            id: Value(id),
            name: 'Wallet $id',
            type: AccountType.assets,
            balance: const Value(0),
          ),
        );
  }

  TransactionModel makeModel({
    required String id,
    required String accountId,
    String? destId,
    TransactionType type = TransactionType.income,
    int amount = 1000,
  }) {
    final now = DateTimeUtils.nowUtc();
    return TransactionModel(
      id: id,
      accountId: accountId,
      destinationAccountId: destId,
      type: type,
      amount: amount,
      transactionDate: now,
      createdAt: now,
      updatedAt: now,
      items: [
        TransactionItemModel(id: 'item-$id', transactionId: id, amount: amount, createdAt: now, updatedAt: now),
      ],
    );
  }

  group('TransactionRepositoryImpl coverage', () {
    test('getTransactions success maps models', () async {
      await seedAccount('acc1');
      await realRepo.createTransaction(makeModel(id: 'txn1', accountId: 'acc1', amount: 5000));
      final result = await realRepo.getTransactions();
      expect(result, isA<Success<List<TransactionModel>, Failure>>());
      final list = (result as Success).value;
      expect(list.length, 1);
      expect(list.first.id, 'txn1');
    });

    test('getTransactions error returns Failure', () async {
      final mockDao = MockTransactionsDao();
      when(() => mockDao.getAllTransactionsWithItems()).thenThrow(Exception('db fail'));
      final repo = TransactionRepositoryImpl(mockDao);
      final result = await repo.getTransactions();
      expect(result, isA<ErrorResult<List<TransactionModel>, Failure>>());
    });

    test('watchTransactions emits success', () async {
      await seedAccount('acc1');
      await realRepo.createTransaction(makeModel(id: 'txn1', accountId: 'acc1'));
      final stream = realRepo.watchTransactions();
      final result = await stream.first;
      expect(result, isA<Success<List<TransactionModel>, Failure>>());
    });

    test('watchTransactions error yields Failure', () async {
      final mockDao = MockTransactionsDao();
      when(
        () => mockDao.watchTransactionsFiltered(
          startDate: any(named: 'startDate'),
          endDate: any(named: 'endDate'),
          accountIds: any(named: 'accountIds'),
          categoryIds: any(named: 'categoryIds'),
          types: any(named: 'types'),
        ),
      ).thenAnswer((_) => Stream.error(Exception('fail')));
      final repo = TransactionRepositoryImpl(mockDao);
      final result = await repo.watchTransactions().first;
      expect(result, isA<ErrorResult<List<TransactionModel>, Failure>>());
    });

    test('getTransactionById found, not found, and error', () async {
      await seedAccount('acc1');
      await realRepo.createTransaction(makeModel(id: 'txn1', accountId: 'acc1'));
      final found = await realRepo.getTransactionById('txn1');
      expect(found, isA<Success<TransactionModel, Failure>>());

      final notFound = await realRepo.getTransactionById('missing');
      expect(notFound, isA<ErrorResult<TransactionModel, Failure>>());
      expect((notFound as ErrorResult).error.message, contains('not found'));

      final mockDao = MockTransactionsDao();
      when(() => mockDao.getTransaction(any())).thenThrow(Exception('fail'));
      final repo2 = TransactionRepositoryImpl(mockDao);
      final err = await repo2.getTransactionById('any');
      expect(err, isA<ErrorResult<TransactionModel, Failure>>());
    });

    test('createTransaction error returns Failure', () async {
      final mockDao = MockTransactionsDao();
      when(() => mockDao.insertTransactionWithItems(any(), any())).thenThrow(Exception('insert fail'));
      final repo = TransactionRepositoryImpl(mockDao);
      await seedAccount('acc1'); // not needed for mock but ensure model valid
      final result = await repo.createTransaction(makeModel(id: 'txnX', accountId: 'acc1'));
      expect(result, isA<ErrorResult<void, Failure>>());
    });

    test('deleteTransaction success reverses balance', () async {
      await seedAccount('acc1');
      await realRepo.createTransaction(
        makeModel(id: 'txn1', accountId: 'acc1', amount: 10000, type: TransactionType.income),
      );
      var acc = await (db.select(db.accounts)..where((a) => a.id.equals('acc1'))).getSingle();
      expect(acc.balance, 10000);
      final del = await realRepo.deleteTransaction('txn1');
      expect(del, isA<Success<void, Failure>>());
      acc = await (db.select(db.accounts)..where((a) => a.id.equals('acc1'))).getSingle();
      expect(acc.balance, 0);
      final missing = await realRepo.getTransactionById('txn1');
      expect(missing, isA<ErrorResult<TransactionModel, Failure>>());
    });

    test('deleteTransaction error returns Failure', () async {
      final mockDao = MockTransactionsDao();
      when(() => mockDao.deleteTransaction(any())).thenThrow(Exception('delete fail'));
      final repo = TransactionRepositoryImpl(mockDao);
      final result = await repo.deleteTransaction('any');
      expect(result, isA<ErrorResult<void, Failure>>());
    });

    test('create and delete transfer with destination', () async {
      await seedAccount('src');
      await seedAccount('dst');
      await realRepo.createTransaction(
        makeModel(id: 'txnT', accountId: 'src', destId: 'dst', type: TransactionType.transfer, amount: 3000),
      );
      var src = await (db.select(db.accounts)..where((a) => a.id.equals('src'))).getSingle();
      var dst = await (db.select(db.accounts)..where((a) => a.id.equals('dst'))).getSingle();
      expect(src.balance, -3000);
      expect(dst.balance, 3000);
      await realRepo.deleteTransaction('txnT');
      src = await (db.select(db.accounts)..where((a) => a.id.equals('src'))).getSingle();
      dst = await (db.select(db.accounts)..where((a) => a.id.equals('dst'))).getSingle();
      expect(src.balance, 0);
      expect(dst.balance, 0);
    });
  });
}
