import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/domain/use_cases/update_transaction_use_case.dart';

class MockTransactionRepository extends Mock implements ITransactionRepository {}

class FakeTransactionModel extends Fake implements TransactionModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late UpdateTransactionUseCase useCase;
  late MockTransactionRepository mockRepo;

  setUpAll(() {
    registerFallbackValue(FakeTransactionModel());
  });

  setUp(() {
    mockRepo = MockTransactionRepository();
    useCase = UpdateTransactionUseCase(mockRepo);
  });

  TransactionModel existing() => TransactionModel(
    id: 'tx1',
    accountId: 'a1',
    type: TransactionType.expense,
    amount: 5000,
    transactionDate: DateTime(2026, 8, 1),
    createdAt: DateTime(2026, 8, 1),
    updatedAt: DateTime(2026, 8, 1),
  );

  test('returns ValidationFailure when amount is null without split items', () async {
    final result = await useCase.execute(
      existing(),
      type: TransactionType.expense,
      accountId: 'a1',
    );

    expect(result, isA<ErrorResult>());
    expect((result as ErrorResult).error, isA<ValidationFailure>());
  });

  test('returns ValidationFailure when amount <= 0', () async {
    final result = await useCase.execute(
      existing(),
      type: TransactionType.expense,
      accountId: 'a1',
      amount: 0,
    );

    expect(result, isA<ErrorResult>());
    expect((result as ErrorResult).error, isA<ValidationFailure>());
  });

  test('returns ValidationFailure when all split items are invalid', () async {
    final result = await useCase.execute(
      existing(),
      type: TransactionType.expense,
      accountId: 'a1',
      splitItems: [
        (categoryId: 'c1', amount: 0, note: null, allocation: null),
        (categoryId: 'c2', amount: -1, note: null, allocation: null),
      ],
    );

    expect(result, isA<ErrorResult>());
    expect((result as ErrorResult).error, isA<ValidationFailure>());
  });

  test('updates transaction with a single amount and one item', () async {
    when(() => mockRepo.updateTransaction(any())).thenAnswer((_) async => const Success(null));

    final result = await useCase.execute(
      existing(),
      type: TransactionType.income,
      accountId: 'a2',
      amount: 10000,
      categoryId: 'c9',
      note: 'updated',
      transactionDate: DateTime(2026, 8, 15),
    );

    expect(result, isA<Success>());

    final captured = verify(() => mockRepo.updateTransaction(captureAny())).captured.first as TransactionModel;
    expect(captured.amount, 10000);
    expect(captured.type, TransactionType.income);
    expect(captured.accountId, 'a2');
    expect(captured.note, 'updated');
    expect(captured.transactionDate, DateTime(2026, 8, 15));
    expect(captured.id, 'tx1');
    expect(captured.items.length, 1);
    expect(captured.items.first.categoryId, 'c9');
  });

  test('updates transaction with split items and skips non-positive amounts', () async {
    when(() => mockRepo.updateTransaction(any())).thenAnswer((_) async => const Success(null));

    final result = await useCase.execute(
      existing(),
      type: TransactionType.expense,
      accountId: 'a1',
      splitItems: [
        (categoryId: 'c1', amount: 3000, note: 'a', allocation: null),
        (categoryId: 'c2', amount: 0, note: null, allocation: null),
        (categoryId: 'c3', amount: 2000, note: null, allocation: TransactionAllocation.saving),
      ],
    );

    expect(result, isA<Success>());

    final captured = verify(() => mockRepo.updateTransaction(captureAny())).captured.first as TransactionModel;
    expect(captured.amount, 5000);
    expect(captured.items.length, 2);
    expect(captured.items.first.categoryId, 'c1');
    expect(captured.items.last.categoryId, 'c3');
    expect(captured.items.last.allocation, TransactionAllocation.saving);
  });

  test('propagates repository error as ErrorResult', () async {
    const failure = DatabaseFailure('update failed');
    when(
      () => mockRepo.updateTransaction(any()),
    ).thenAnswer((_) async => const ErrorResult<void, Failure>(failure));

    final result = await useCase.execute(
      existing(),
      type: TransactionType.expense,
      accountId: 'a1',
      amount: 1000,
    );

    expect(result, isA<ErrorResult<TransactionModel, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, same(failure)),
    );
  });
}
