import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/domain/use_cases/create_transaction_use_case.dart';

class MockTransactionRepository extends Mock implements ITransactionRepository {}

class FakeTransactionModel extends Fake implements TransactionModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late CreateTransactionUseCase useCase;
  late MockTransactionRepository mockTransactionRepo;

  setUpAll(() {
    registerFallbackValue(FakeTransactionModel());
  });

  setUp(() {
    mockTransactionRepo = MockTransactionRepository();
    useCase = CreateTransactionUseCase(mockTransactionRepo);
  });

  test('returns ValidationFailure if amount <= 0', () async {
    final result = await useCase.execute(
      amount: 0,
      type: TransactionType.expense,
      accountId: 'a1',
      categoryId: 'c1',
    );

    expect(result, isA<ErrorResult>());
    expect((result as ErrorResult).error, isA<ValidationFailure>());
  });

  test('returns ValidationFailure if amount is negative', () async {
    final result = await useCase.execute(
      amount: -100,
      type: TransactionType.expense,
      accountId: 'a1',
      categoryId: 'c1',
    );

    expect(result, isA<ErrorResult>());
    expect((result as ErrorResult).error, isA<ValidationFailure>());
  });

  test('creates transaction successfully if valid', () async {
    when(() => mockTransactionRepo.createTransaction(any())).thenAnswer((_) async => const Success(null));

    final result = await useCase.execute(
      amount: 50000,
      type: TransactionType.expense,
      accountId: 'a1',
      categoryId: 'c1',
      note: 'test note',
    );

    expect(result, isA<Success>());

    final captured =
        verify(() => mockTransactionRepo.createTransaction(captureAny())).captured.first as TransactionModel;
    expect(captured.amount, 50000);
    expect(captured.type, TransactionType.expense);
    expect(captured.accountId, 'a1');
    expect(captured.note, 'test note');
    expect(captured.items.length, 1);
    expect(captured.items.first.categoryId, 'c1');
    expect(captured.items.first.amount, 50000);
  });

  test('propagates repository error as ErrorResult', () async {
    const failure = DatabaseFailure('insert failed');
    when(
      () => mockTransactionRepo.createTransaction(any()),
    ).thenAnswer((_) async => const ErrorResult<void, Failure>(failure));

    final result = await useCase.execute(
      amount: 10000,
      type: TransactionType.income,
      accountId: 'a1',
      categoryId: 'c1',
    );

    expect(result, isA<ErrorResult<TransactionModel, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, same(failure)),
    );
  });

  group('CreateTransactionUseCase mutation hardening', () {
    test(
      'amount mutation: returns ValidationFailure if amount is exactly 0 (mutation > 0 -> >= 0 on totalAmount)',
      () async {
        final result = await useCase.execute(
          amount: 0,
          type: TransactionType.expense,
          accountId: 'a1',
          categoryId: 'c1',
        );

        expect(result, isA<ErrorResult>());
        expect((result as ErrorResult).error, isA<ValidationFailure>());
      },
    );

    test('amount mutation: succeeds if amount is exactly 1 (mutation <= 0 -> < 0 on totalAmount)', () async {
      when(() => mockTransactionRepo.createTransaction(any())).thenAnswer((_) async => const Success(null));

      final result = await useCase.execute(
        amount: 1,
        type: TransactionType.expense,
        accountId: 'a1',
        categoryId: 'c1',
      );

      expect(result, isA<Success>());
      verify(() => mockTransactionRepo.createTransaction(any())).called(1);
    });

    test('splitItems mutation: items with amount <= 0 are skipped (mutation item.amount <= 0 -> < 0)', () async {
      when(() => mockTransactionRepo.createTransaction(any())).thenAnswer((_) async => const Success(null));

      final result = await useCase.execute(
        type: TransactionType.expense,
        accountId: 'a1',
        splitItems: [
          (categoryId: 'c1', amount: 50000, note: null, allocation: null),
          (categoryId: 'c2', amount: 0, note: null, allocation: null), // Should be skipped
          (categoryId: 'c3', amount: -100, note: null, allocation: null), // Should be skipped
        ],
      );

      expect(result, isA<Success>());

      final captured =
          verify(() => mockTransactionRepo.createTransaction(captureAny())).captured.first as TransactionModel;
      expect(captured.amount, 50000); // Only the valid item is summed
      expect(captured.items.length, 1);
      expect(captured.items.first.categoryId, 'c1');
    });

    test('splitItems mutation: returns ValidationFailure if all items are skipped (mutation empty list -> totalAmount <= 0)', () async {
      final result = await useCase.execute(
        type: TransactionType.expense,
        accountId: 'a1',
        splitItems: [
          (categoryId: 'c1', amount: 0, note: null, allocation: null),
          (categoryId: 'c2', amount: -100, note: null, allocation: null),
        ],
      );

      expect(result, isA<ErrorResult>());
      expect((result as ErrorResult).error, isA<ValidationFailure>());
    });
  });
}
