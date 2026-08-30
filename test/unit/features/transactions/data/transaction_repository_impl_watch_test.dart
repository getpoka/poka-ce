import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/daos/transactions_dao.dart';
import 'package:poka_ce/database/database.dart' as db;
import 'package:poka_ce/features/transactions/data/transaction_repository_impl.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/database/database.dart';

class MockTransactionsDao extends Mock implements TransactionsDao {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockTransactionsDao dao;
  late TransactionRepositoryImpl repo;

  setUpAll(() {
    registerFallbackValue(const db.TransactionsCompanion());
    registerFallbackValue(<db.TransactionItemsCompanion>[]);
  });

  setUp(() {
    dao = MockTransactionsDao();
    repo = TransactionRepositoryImpl(dao);
  });

  group('TransactionRepositoryImpl.watchTransactions', () {
    test('emits Success with mapped models', () async {
      final now = DateTimeUtils.nowUtc();
      final header = db.Transaction(
        id: 'txn1',
        accountId: 'acc1',
        destinationAccountId: null,
        type: TransactionType.expense,
        amount: 5000,
        transactionDate: now,
        note: null,
        recurringTransactionId: null,
        debtId: null,
        createdAt: now,
        updatedAt: now,
      );
      final item = db.TransactionItem(
        id: 'i1',
        transactionId: 'txn1',
        categoryId: 'cat1',
        allocation: TransactionAllocation.need,
        amount: 5000,
        note: null,
        createdAt: now,
        updatedAt: now,
      );
      final twi = TransactionWithItems(header, [item]);
      when(
        () => dao.watchTransactionsFiltered(
          startDate: any(named: 'startDate'),
          endDate: any(named: 'endDate'),
          accountIds: any(named: 'accountIds'),
          categoryIds: any(named: 'categoryIds'),
          types: any(named: 'types'),
        ),
      ).thenAnswer((_) => Stream.value([twi]));

      final emitted = await repo.watchTransactions().first;
      expect(emitted, isA<Success<List<TransactionModel>, Failure>>());
      emitted.fold((list) {
        expect(list.length, 1);
        expect(list.first.id, 'txn1');
        expect(list.first.items.first.categoryId, 'cat1');
      }, (f) => fail('should succeed'));
    });

    test('emits Success with empty list', () async {
      when(
        () => dao.watchTransactionsFiltered(
          startDate: any(named: 'startDate'),
          endDate: any(named: 'endDate'),
          accountIds: any(named: 'accountIds'),
          categoryIds: any(named: 'categoryIds'),
          types: any(named: 'types'),
        ),
      ).thenAnswer((_) => Stream.value([]));
      final emitted = await repo.watchTransactions().first;
      expect(emitted, isA<Success<List<TransactionModel>, Failure>>());
      emitted.fold((v) => expect(v, isEmpty), (e) => fail('should succeed'));
    });

    test('emits DatabaseFailure when DAO throws via stream error', () async {
      when(
        () => dao.watchTransactionsFiltered(
          startDate: any(named: 'startDate'),
          endDate: any(named: 'endDate'),
          accountIds: any(named: 'accountIds'),
          categoryIds: any(named: 'categoryIds'),
          types: any(named: 'types'),
        ),
      ).thenAnswer((_) => Stream.error(Exception('boom')));
      final emitted = await repo.watchTransactions().first;
      expect(emitted, isA<ErrorResult<List<TransactionModel>, Failure>>());
      emitted.fold((v) => fail('should fail'), (e) => expect(e, isA<DatabaseFailure>()));
    });

    test('emits DatabaseFailure when DAO throws synchronously', () async {
      when(
        () => dao.watchTransactionsFiltered(
          startDate: any(named: 'startDate'),
          endDate: any(named: 'endDate'),
          accountIds: any(named: 'accountIds'),
          categoryIds: any(named: 'categoryIds'),
          types: any(named: 'types'),
        ),
      ).thenThrow(Exception('boom'));
      final emitted = await repo.watchTransactions().first;
      expect(emitted, isA<ErrorResult<List<TransactionModel>, Failure>>());
    });

    test('getTransactions success maps via WithItems', () async {
      final now = DateTimeUtils.nowUtc();
      final header = db.Transaction(
        id: 'txn1',
        accountId: 'acc1',
        destinationAccountId: null,
        type: TransactionType.income,
        amount: 10000,
        transactionDate: now,
        note: null,
        recurringTransactionId: null,
        debtId: null,
        createdAt: now,
        updatedAt: now,
      );
      final item = db.TransactionItem(
        id: 'i1',
        transactionId: 'txn1',
        categoryId: null,
        allocation: null,
        amount: 10000,
        note: null,
        createdAt: now,
        updatedAt: now,
      );
      when(() => dao.getAllTransactionsWithItems()).thenAnswer(
        (_) async => [
          TransactionWithItems(header, [item]),
        ],
      );
      final res = await repo.getTransactions();
      expect(res, isA<Success<List<TransactionModel>, Failure>>());
      res.fold((v) => expect(v.first.amount, 10000), (e) => fail('fail'));
    });

    test('getTransactions failure propagates', () async {
      when(() => dao.getAllTransactionsWithItems()).thenThrow(Exception('boom'));
      final res = await repo.getTransactions();
      expect(res, isA<ErrorResult<List<TransactionModel>, Failure>>());
    });
  });

  group('watchTransactions integration with real DB', () {
    late AppDatabase realDb;
    late TransactionRepositoryImpl realRepo;
    setUp(() {
      realDb = AppDatabase(connection: NativeDatabase.memory());
      realRepo = TransactionRepositoryImpl(realDb.transactionsDao);
    });
    tearDown(() async => realDb.close());

    test('watch emits updates on insert', () async {
      await realDb
          .into(realDb.accounts)
          .insert(
            AccountsCompanion.insert(
              id: const Value('acc1'),
              name: 'Wallet',
              type: AccountType.assets,
              balance: const Value(0),
            ),
          );
      final now = DateTimeUtils.nowUtc();
      final model = TransactionModel(
        id: 'txn1',
        accountId: 'acc1',
        type: TransactionType.income,
        amount: 10000,
        transactionDate: now,
        createdAt: now,
        updatedAt: now,
        items: [TransactionItemModel(id: 'i1', transactionId: 'txn1', amount: 10000, createdAt: now, updatedAt: now)],
      );
      final stream = realRepo.watchTransactions();
      Future.delayed(const Duration(milliseconds: 20), () => realRepo.createTransaction(model));
      final emitted = await stream.firstWhere((r) => r.fold((v) => v.isNotEmpty, (e) => false));
      emitted.fold((v) => expect(v.first.id, 'txn1'), (e) => fail('fail'));
    });
  });
}
