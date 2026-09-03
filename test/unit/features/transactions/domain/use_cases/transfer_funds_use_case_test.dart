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

void main() {
  late MockUnitOfWork unitOfWork;
  late MockTransactionRepository repository;
  late TransferFundsUseCase useCase;

  setUpAll(() {
    registerFallbackValue(
      TransactionModel(
        id: 'fallback',
        accountId: 'fallback',
        type: TransactionType.transfer,
        amount: 0,
        transactionDate: DateTime.utc(2026),
        createdAt: DateTime.utc(2026),
        updatedAt: DateTime.utc(2026),
        items: const [],
      ),
    );
    registerFallbackValue(
      () async => TransactionModel(
        id: 'fallback',
        accountId: 'fallback',
        type: TransactionType.transfer,
        amount: 0,
        transactionDate: DateTime.utc(2026),
        createdAt: DateTime.utc(2026),
        updatedAt: DateTime.utc(2026),
        items: const [],
      ),
    );
  });

  setUp(() {
    unitOfWork = MockUnitOfWork();
    repository = MockTransactionRepository();
    useCase = TransferFundsUseCase(unitOfWork, repository);
    when(() => unitOfWork.execute<Result<TransactionModel, Failure>>(any())).thenAnswer((inv) async {
      final action = inv.positionalArguments.first as Future<Result<TransactionModel, Failure>> Function();
      return action();
    });
  });

  TransactionModel capturedTransaction() {
    final result = verify(() => repository.createTransaction(captureAny())).captured.single as TransactionModel;
    return result;
  }

  group('TransferFundsUseCase.execute', () {
    test('rejects non-positive amount', () async {
      final result = await useCase.execute(amount: 0, sourceAccountId: 'a', destinationAccountId: 'b');
      expect(result, isA<ErrorResult<TransactionModel, Failure>>());
      final error = (result as ErrorResult<TransactionModel, Failure>).error;
      expect(error, isA<ValidationFailure>());
      verifyNever(() => repository.createTransaction(any()));
    });

    test('rejects negative amount', () async {
      final result = await useCase.execute(amount: -5, sourceAccountId: 'a', destinationAccountId: 'b');
      expect(result, isA<ErrorResult<TransactionModel, Failure>>());
    });

    test('rejects same source and destination account', () async {
      final result = await useCase.execute(amount: 100, sourceAccountId: 'same', destinationAccountId: 'same');
      expect(result, isA<ErrorResult<TransactionModel, Failure>>());
      final error = (result as ErrorResult<TransactionModel, Failure>).error;
      expect(error, isA<ValidationFailure>());
      verifyNever(() => repository.createTransaction(any()));
    });

    test('creates transfer transaction with single matching item', () async {
      when(() => repository.createTransaction(any())).thenAnswer((_) async => const Success<void, Failure>(null));

      final date = DateTime.utc(2026, 1, 15, 10);
      final result = await useCase.execute(
        amount: 25000,
        sourceAccountId: 'wallet',
        destinationAccountId: 'pocket',
        note: 'weekly top up',
        transactionDate: date,
      );

      expect(result, isA<Success<TransactionModel, Failure>>());
      final tx = (result as Success<TransactionModel, Failure>).value;
      expect(tx.type, TransactionType.transfer);
      expect(tx.accountId, 'wallet');
      expect(tx.destinationAccountId, 'pocket');
      expect(tx.amount, 25000);
      expect(tx.note, 'weekly top up');
      expect(tx.transactionDate, date);
      expect(tx.items.length, 1);
      expect(tx.items.first.amount, 25000);
      expect(tx.items.first.transactionId, tx.id);
      expect(tx.id, isNotEmpty);
    });

    test('uses UTC current date when transactionDate omitted', () async {
      when(() => repository.createTransaction(any())).thenAnswer((_) async => const Success<void, Failure>(null));

      final before = DateTime.now().toUtc();
      final result = await useCase.execute(amount: 100, sourceAccountId: 'a', destinationAccountId: 'b');
      final after = DateTime.now().toUtc();

      final tx = (result as Success<TransactionModel, Failure>).value;
      expect(tx.transactionDate.isAfter(before.subtract(const Duration(seconds: 1))), isTrue);
      expect(tx.transactionDate.isBefore(after.add(const Duration(seconds: 1))), isTrue);
      expect(tx.transactionDate.isUtc, isTrue);
    });

    test('propagates repository failure', () async {
      when(() => repository.createTransaction(any())).thenAnswer(
        (_) async => const ErrorResult<void, Failure>(DatabaseFailure('insert failed')),
      );

      final result = await useCase.execute(amount: 100, sourceAccountId: 'a', destinationAccountId: 'b');
      expect(result, isA<ErrorResult<TransactionModel, Failure>>());
      final error = (result as ErrorResult<TransactionModel, Failure>).error;
      expect(error, isA<DatabaseFailure>());
    });

    test('wraps unexpected exception into DatabaseFailure', () async {
      when(() => unitOfWork.execute<Result<TransactionModel, Failure>>(any())).thenThrow(Exception('boom'));

      final result = await useCase.execute(amount: 100, sourceAccountId: 'a', destinationAccountId: 'b');
      expect(result, isA<ErrorResult<TransactionModel, Failure>>());
      final error = (result as ErrorResult<TransactionModel, Failure>).error;
      expect(error, isA<DatabaseFailure>());
    });
  });
}
