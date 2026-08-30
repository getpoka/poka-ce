// Tests exception-to-Failure translation of DebtRepositoryImpl by mocking
// its DAO to throw, covering every defensive catch branch.
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/database/daos/debts_dao.dart';
import 'package:poka_ce/database/database.dart' as db;
import 'package:poka_ce/features/debts/data/debt_repository_impl.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';

class MockDebtsDao extends Mock implements DebtsDao {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockDebtsDao dao;
  late DebtRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(const db.DebtsCompanion());
    registerFallbackValue(const db.TransactionsCompanion());
    registerFallbackValue(const db.TransactionItemsCompanion());
  });

  setUp(() {
    dao = MockDebtsDao();
    repository = DebtRepositoryImpl(dao);
  });

  test('getDebts returns DatabaseFailure when DAO throws', () async {
    when(() => dao.getAllDebts()).thenThrow(Exception('boom'));

    final result = await repository.getDebts();

    expect(result, isA<ErrorResult<List<DebtModel>, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('getActiveDebts returns DatabaseFailure when DAO throws', () async {
    when(() => dao.getActiveDebts()).thenThrow(Exception('boom'));

    final result = await repository.getActiveDebts();

    expect(result, isA<ErrorResult<List<DebtModel>, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('getDebtById returns DatabaseFailure when DAO throws', () async {
    when(() => dao.getDebt(any())).thenThrow(Exception('boom'));

    final result = await repository.getDebtById('debt-1');

    expect(result, isA<ErrorResult<DebtModel, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('createDebt returns DatabaseFailure when DAO throws', () async {
    when(() => dao.insertDebtWithTransaction(any(), any(), any())).thenThrow(Exception('boom'));

    final result = await repository.createDebt(_buildDebt(), 'acc1', 'cat1');

    expect(result, isA<ErrorResult<void, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('updateDebt returns DatabaseFailure when DAO throws', () async {
    when(() => dao.updateDebt(any())).thenThrow(Exception('boom'));

    final result = await repository.updateDebt(_buildDebt());

    expect(result, isA<ErrorResult<void, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('deleteDebt returns DatabaseFailure when DAO throws', () async {
    when(() => dao.deleteDebtWithTransactionReversal(any())).thenThrow(Exception('boom'));

    final result = await repository.deleteDebt('debt-1');

    expect(result, isA<ErrorResult<void, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });
}

DebtModel _buildDebt() {
  return DebtModel(
    id: 'debt-1',
    personName: 'Budi',
    type: DebtType.debt,
    amount: 500000,
    remainingAmount: 500000,
    status: DebtStatus.active,
    createdAt: DateTimeUtils.nowUtc(),
    updatedAt: DateTimeUtils.nowUtc(),
  );
}
