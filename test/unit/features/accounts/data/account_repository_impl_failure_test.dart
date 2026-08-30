// Tests exception-to-Failure translation of AccountRepositoryImpl by mocking
// its DAO to throw, covering every defensive catch branch.
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/database/daos/accounts_dao.dart';
import 'package:poka_ce/database/database.dart' as db;
import 'package:poka_ce/features/accounts/data/account_repository_impl.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';

class MockAccountsDao extends Mock implements AccountsDao {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockAccountsDao dao;
  late AccountRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(
      const db.AccountsCompanion(),
    );
  });

  setUp(() {
    dao = MockAccountsDao();
    repository = AccountRepositoryImpl(dao);
  });

  test('getAccounts returns DatabaseFailure when DAO throws', () async {
    when(() => dao.getAllAccounts()).thenThrow(Exception('boom'));

    final result = await repository.getAccounts();

    expect(result, isA<ErrorResult<List<AccountModel>, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('getAccountById returns DatabaseFailure when DAO throws', () async {
    when(() => dao.getAccount(any())).thenThrow(Exception('boom'));

    final result = await repository.getAccountById('acc-1');

    expect(result, isA<ErrorResult<AccountModel, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('createAccount returns DatabaseFailure when DAO throws', () async {
    when(() => dao.insertAccount(any())).thenThrow(Exception('boom'));

    final result = await repository.createAccount(_buildAccount());

    expect(result, isA<ErrorResult<void, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
    verifyNever(
      () => dao.setAccountCategories(any(), any<List<String>>()),
    );
  });

  test('updateAccount returns DatabaseFailure when DAO throws', () async {
    when(() => dao.updateAccount(any())).thenThrow(Exception('boom'));

    final result = await repository.updateAccount(_buildAccount());

    expect(result, isA<ErrorResult<void, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('deactivateAccount returns DatabaseFailure when DAO throws', () async {
    when(() => dao.deactivateAccount(any())).thenThrow(Exception('boom'));

    final result = await repository.deactivateAccount('acc-1');

    expect(result, isA<ErrorResult<void, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });
}

AccountModel _buildAccount() {
  return AccountModel(
    id: 'acc-1',
    name: 'Wallet',
    type: AccountType.assets,
    balance: 1000,
    createdAt: DateTimeUtils.nowUtc(),
    updatedAt: DateTimeUtils.nowUtc(),
  );
}
