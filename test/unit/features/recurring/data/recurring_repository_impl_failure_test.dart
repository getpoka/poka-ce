// Tests exception-to-Failure translation of RecurringRepositoryImpl by mocking
// its DAO to throw, covering every defensive catch branch.
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/database/daos/recurring_dao.dart';
import 'package:poka_ce/database/database.dart' as db;
import 'package:poka_ce/features/recurring/data/recurring_repository_impl.dart';
import 'package:poka_ce/features/recurring/domain/recurring_model.dart';

class MockRecurringDao extends Mock implements RecurringDao {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockRecurringDao dao;
  late RecurringRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(const db.RecurringTransactionsCompanion());
  });

  setUp(() {
    dao = MockRecurringDao();
    repository = RecurringRepositoryImpl(dao);
  });

  test('getRecurringTransactions returns DatabaseFailure when DAO throws', () async {
    when(() => dao.getAllRecurring()).thenThrow(Exception('boom'));

    final result = await repository.getRecurringTransactions();

    expect(result, isA<ErrorResult<List<RecurringTransactionModel>, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('getActiveRecurringTransactions returns DatabaseFailure when DAO throws', () async {
    when(() => dao.getActiveRecurring()).thenThrow(Exception('boom'));

    final result = await repository.getActiveRecurringTransactions();

    expect(result, isA<ErrorResult<List<RecurringTransactionModel>, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('getRecurringById returns DatabaseFailure when DAO throws', () async {
    when(() => dao.getRecurring(any())).thenThrow(Exception('boom'));

    final result = await repository.getRecurringById('rec-1');

    expect(result, isA<ErrorResult<RecurringTransactionModel, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('createRecurring returns DatabaseFailure when DAO throws', () async {
    when(() => dao.insertRecurring(any())).thenThrow(Exception('boom'));

    final result = await repository.createRecurring(_buildRecurring());

    expect(result, isA<ErrorResult<void, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('updateRecurring returns DatabaseFailure when DAO throws', () async {
    when(() => dao.updateRecurring(any())).thenThrow(Exception('boom'));

    final result = await repository.updateRecurring(_buildRecurring());

    expect(result, isA<ErrorResult<void, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('deleteRecurring returns DatabaseFailure when DAO throws', () async {
    when(() => dao.deleteRecurring(any())).thenThrow(Exception('boom'));

    final result = await repository.deleteRecurring('rec-1');

    expect(result, isA<ErrorResult<void, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });
}

RecurringTransactionModel _buildRecurring() {
  return RecurringTransactionModel(
    id: 'rec-1',
    accountId: 'acc-1',
    type: TransactionType.expense,
    amount: 150000,
    period: RecurringPeriod.monthly,
    nextDate: DateTimeUtils.nowUtc(),
    createdAt: DateTimeUtils.nowUtc(),
    updatedAt: DateTimeUtils.nowUtc(),
  );
}
