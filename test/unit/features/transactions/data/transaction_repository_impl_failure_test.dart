// Tests exception-to-Failure translation of TransactionRepositoryImpl by
// mocking its DAO to throw, covering every defensive catch branch.
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/database/daos/transactions_dao.dart';
import 'package:poka_ce/database/database.dart' as db;
import 'package:poka_ce/features/transactions/data/transaction_repository_impl.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';

class MockTransactionsDao extends Mock implements TransactionsDao {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockTransactionsDao dao;
  late TransactionRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(const db.TransactionsCompanion());
    registerFallbackValue(<db.TransactionItemsCompanion>[]);
  });

  setUp(() {
    dao = MockTransactionsDao();
    repository = TransactionRepositoryImpl(dao);
  });

  test('getTransactions returns DatabaseFailure when DAO throws', () async {
    when(() => dao.getAllTransactionsWithItems()).thenThrow(Exception('boom'));

    final result = await repository.getTransactions();

    expect(result, isA<ErrorResult<List<TransactionModel>, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('getTransactionById returns DatabaseFailure when DAO throws', () async {
    when(() => dao.getTransaction(any())).thenThrow(Exception('boom'));

    final result = await repository.getTransactionById('tx-1');

    expect(result, isA<ErrorResult<TransactionModel, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('createTransaction returns DatabaseFailure when DAO throws', () async {
    when(() => dao.insertTransactionWithItems(any(), any())).thenThrow(Exception('boom'));

    final result = await repository.createTransaction(_buildTransaction());

    expect(result, isA<ErrorResult<void, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });
}

TransactionModel _buildTransaction() {
  final now = DateTimeUtils.nowUtc();
  return TransactionModel(
    id: 'tx-1',
    accountId: 'acc-1',
    type: TransactionType.expense,
    amount: 25000,
    transactionDate: now,
    createdAt: now,
    updatedAt: now,
    items: [
      TransactionItemModel(
        id: 'item-1',
        transactionId: 'tx-1',
        categoryId: 'cat-1',
        amount: 25000,
        createdAt: now,
        updatedAt: now,
      ),
    ],
  );
}
