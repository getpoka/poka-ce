import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/domain/i_unit_of_work.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/domain/i_account_repository.dart';
import 'package:poka_ce/features/accounts/domain/use_cases/create_account_use_case.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';

class MockUnitOfWork extends Mock implements IUnitOfWork {}

class MockAccountRepository extends Mock implements IAccountRepository {}

class MockTransactionRepository extends Mock implements ITransactionRepository {}

class FakeAccountModel extends Fake implements AccountModel {}

class FakeTransactionModel extends Fake implements TransactionModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late CreateAccountUseCase useCase;
  late MockUnitOfWork mockUoW;
  late MockAccountRepository mockAccountRepo;
  late MockTransactionRepository mockTransactionRepo;

  setUpAll(() {
    registerFallbackValue(FakeAccountModel());
    registerFallbackValue(FakeTransactionModel());
    registerFallbackValue(() async => Success<AccountModel, Failure>(FakeAccountModel()));
  });

  setUp(() {
    mockUoW = MockUnitOfWork();
    mockAccountRepo = MockAccountRepository();
    mockTransactionRepo = MockTransactionRepository();
    useCase = CreateAccountUseCase(mockUoW, mockAccountRepo);

    when(() => mockUoW.execute<Result<AccountModel, Failure>>(any())).thenAnswer((i) async {
      final callback = i.positionalArguments[0] as Future<Result<AccountModel, Failure>> Function();
      return await callback();
    });
  });

  test('returns ValidationFailure if name is empty', () async {
    final result = await useCase.execute(
      name: '',
      type: AccountType.assets,
      balance: 0,
    );

    expect(result, isA<ErrorResult>());
    expect((result as ErrorResult).error, isA<ValidationFailure>());
  });

  test('returns ValidationFailure if balance is negative', () async {
    final result = await useCase.execute(
      name: 'Dompet',
      type: AccountType.assets,
      balance: -5000,
    );

    expect(result, isA<ErrorResult>());
    expect((result as ErrorResult).error, isA<ValidationFailure>());
  });

  test('creates account only if balance is 0', () async {
    when(() => mockAccountRepo.createAccount(any())).thenAnswer((_) async => const Success(null));

    final result = await useCase.execute(
      name: 'Dompet',
      type: AccountType.assets,
      balance: 0,
    );

    expect(result, isA<Success>());
    verify(() => mockAccountRepo.createAccount(any())).called(1);
    verifyNever(() => mockTransactionRepo.createTransaction(any()));
  });

  test('creates account and sets initial balance correctly', () async {
    when(() => mockAccountRepo.createAccount(any())).thenAnswer((_) async => const Success(null));

    final result = await useCase.execute(
      name: 'Dompet',
      type: AccountType.assets,
      balance: 100000,
    );

    expect(result, isA<Success>());

    final capturedAccount = verify(() => mockAccountRepo.createAccount(captureAny())).captured.first as AccountModel;
    expect(capturedAccount.name, 'Dompet');
    expect(capturedAccount.balance, 100000);
    expect(capturedAccount.initialBalance, 100000);
  });

  test('propagates account creation failure', () async {
    const failure = DatabaseFailure('account insert failed');
    when(() => mockAccountRepo.createAccount(any())).thenAnswer((_) async => const ErrorResult<void, Failure>(failure));

    final result = await useCase.execute(
      name: 'Dompet',
      type: AccountType.assets,
      balance: 100000,
    );

    expect(result, isA<ErrorResult<AccountModel, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, same(failure)),
    );
  });

  group('CreateAccountUseCase mutation hardening', () {
    test(
      'balance mutation: returns ValidationFailure if balance is exactly -1 (mutation >= 0 -> > 0 or similar)',
      () async {
        final result = await useCase.execute(
          name: 'Dompet',
          type: AccountType.assets,
          balance: -1,
        );

        expect(result, isA<ErrorResult>());
        expect((result as ErrorResult).error, isA<ValidationFailure>());
      },
    );

    test('balance mutation: succeeds if balance is exactly 1', () async {
      when(() => mockAccountRepo.createAccount(any())).thenAnswer((_) async => const Success(null));

      final result = await useCase.execute(
        name: 'Dompet',
        type: AccountType.assets,
        balance: 1,
      );

      expect(result, isA<Success>());
      verify(() => mockAccountRepo.createAccount(any())).called(1);
    });

    test(
      'name mutation: returns ValidationFailure if name is just whitespace (mutation .isEmpty -> .trim().isEmpty)',
      () async {
        final result = await useCase.execute(
          name: '   ',
          type: AccountType.assets,
          balance: 0,
        );

        expect(result, isA<ErrorResult>());
        expect((result as ErrorResult).error, isA<ValidationFailure>());
      },
    );
  });
}
