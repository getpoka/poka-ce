import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/domain/i_unit_of_work.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/domain/use_cases/transfer_funds_use_case.dart';

class MockUnitOfWork extends Mock implements IUnitOfWork {}

class MockTransactionRepository extends Mock implements ITransactionRepository {}

class FakeTransactionModel extends Fake implements TransactionModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late TransferFundsUseCase useCase;
  late MockUnitOfWork mockUoW;
  late MockTransactionRepository mockTransactionRepo;

  setUpAll(() {
    registerFallbackValue(FakeTransactionModel());
    registerFallbackValue(() async => Success<TransactionModel, Failure>(FakeTransactionModel()));
  });

  setUp(() {
    mockUoW = MockUnitOfWork();
    mockTransactionRepo = MockTransactionRepository();
    useCase = TransferFundsUseCase(mockUoW, mockTransactionRepo);

    when(() => mockUoW.execute<Result<TransactionModel, Failure>>(any())).thenAnswer((i) async {
      final callback = i.positionalArguments[0] as Future<Result<TransactionModel, Failure>> Function();
      return await callback();
    });
  });

  test('returns ValidationFailure if amount <= 0', () async {
    final result = await useCase.execute(
      amount: 0,
      sourceAccountId: 'a1',
      destinationAccountId: 'a2',
    );

    expect(result, isA<ErrorResult>());
    expect((result as ErrorResult).error, isA<ValidationFailure>());
  });

  test('returns ValidationFailure if amount is negative', () async {
    final result = await useCase.execute(
      amount: -5000,
      sourceAccountId: 'a1',
      destinationAccountId: 'a2',
    );

    expect(result, isA<ErrorResult>());
    expect((result as ErrorResult).error, isA<ValidationFailure>());
  });

  test('returns ValidationFailure if source == dest', () async {
    final result = await useCase.execute(
      amount: 1000,
      sourceAccountId: 'a1',
      destinationAccountId: 'a1',
    );

    expect(result, isA<ErrorResult>());
    expect((result as ErrorResult).error, isA<ValidationFailure>());
  });

  test('creates transfer transaction successfully', () async {
    when(() => mockTransactionRepo.createTransaction(any())).thenAnswer((_) async => const Success(null));

    final result = await useCase.execute(
      amount: 50000,
      sourceAccountId: 'a1',
      destinationAccountId: 'a2',
      note: 'transfer note',
    );

    expect(result, isA<Success>());

    final captured =
        verify(() => mockTransactionRepo.createTransaction(captureAny())).captured.first as TransactionModel;
    expect(captured.amount, 50000);
    expect(captured.type, TransactionType.transfer);
    expect(captured.accountId, 'a1');
    expect(captured.destinationAccountId, 'a2');
    expect(captured.note, 'transfer note');
    expect(captured.items.length, 1);
    expect(captured.items.first.amount, 50000);
  });

  test('returns DatabaseFailure when repository fails inside transaction', () async {
    when(
      () => mockTransactionRepo.createTransaction(any()),
    ).thenAnswer((_) async => const ErrorResult<void, Failure>(DatabaseFailure('transfer insert failed')));

    final result = await useCase.execute(
      amount: 50000,
      sourceAccountId: 'a1',
      destinationAccountId: 'a2',
    );

    // The use case must throw inside the unit of work so the DB transaction rolls back,
    // then translate that exception into a DatabaseFailure for the caller.
    expect(result, isA<ErrorResult<TransactionModel, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
    verify(() => mockTransactionRepo.createTransaction(any())).called(1);
  });
}
