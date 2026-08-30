import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/domain/use_cases/create_transaction_use_case.dart';

class MockTxRepo extends Mock implements ITransactionRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockTxRepo repo;
  late CreateTransactionUseCase useCase;

  setUpAll(() {
    registerFallbackValue(
      TransactionModel(
        id: 'id',
        accountId: 'a',
        type: TransactionType.expense,
        amount: 1,
        transactionDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  });

  setUp(() {
    repo = MockTxRepo();
    useCase = CreateTransactionUseCase(repo);
  });

  test('splitItems amount <=0 skipped -> ValidationFailure when all skipped (mutant <= -> <)', () async {
    final res = await useCase.execute(
      type: TransactionType.expense,
      accountId: 'a',
      splitItems: [(categoryId: 'c', amount: 0, note: null, allocation: null)],
    );
    expect(res, isA<ErrorResult<TransactionModel, Failure>>());
    verifyNever(() => repo.createTransaction(any()));
  });

  test('splitItems with one valid and one zero -> totalAmount == valid only', () async {
    when(() => repo.createTransaction(any())).thenAnswer((_) async => const Success(null));
    final res = await useCase.execute(
      type: TransactionType.expense,
      accountId: 'a',
      splitItems: [
        (categoryId: 'c1', amount: 0, note: null, allocation: null),
        (categoryId: 'c2', amount: 500, note: 'keep', allocation: null),
      ],
    );
    expect(res, isA<Success<TransactionModel, Failure>>());
    final captured = verify(() => repo.createTransaction(captureAny())).captured.first as TransactionModel;
    expect(captured.amount, 500);
    expect(captured.items.length, 1);
  });

  test('non-split amount ==0 -> ValidationFailure (mutant <= -> < would accept 0)', () async {
    final res = await useCase.execute(type: TransactionType.expense, accountId: 'a', amount: 0, categoryId: 'c');
    expect(res, isA<ErrorResult<TransactionModel, Failure>>());
    final err = (res as ErrorResult).error as ValidationFailure;
    expect(err.message, 'Transaction amount must be greater than 0');
    verifyNever(() => repo.createTransaction(any()));
  });

  test('non-split categoryId null still succeeds (uncategorized allowed)', () async {
    when(() => repo.createTransaction(any())).thenAnswer((_) async => const Success(null));
    final res = await useCase.execute(type: TransactionType.expense, accountId: 'a', amount: 100);
    expect(res, isA<Success<TransactionModel, Failure>>());
    final captured = verify(() => repo.createTransaction(captureAny())).captured.first as TransactionModel;
    expect(captured.items.single.categoryId, isNull);
  });

  test('txItems empty -> ValidationFailure (covers totalAmount <=0 final guard)', () async {
    // splitItems null and amount null triggers earlier guard, but split with negative also
    final res = await useCase.execute(type: TransactionType.expense, accountId: 'a', splitItems: []);
    // falls through to else branch with amount null -> validation
    expect(res, isA<ErrorResult<TransactionModel, Failure>>());
  });

  test('non-split amount negative -> ValidationFailure early (mutant == would miss)', () async {
    final res = await useCase.execute(type: TransactionType.expense, accountId: 'a', amount: -5, categoryId: 'c');
    expect(res, isA<ErrorResult<TransactionModel, Failure>>());
    final err = (res as ErrorResult).error as ValidationFailure;
    expect(err.message, 'Transaction amount must be greater than 0');
    verifyNever(() => repo.createTransaction(any()));
  });

  test('repository failure propagates as ErrorResult', () async {
    when(() => repo.createTransaction(any())).thenAnswer((_) async => ErrorResult(DatabaseFailure('db fail')));
    final res = await useCase.execute(type: TransactionType.expense, accountId: 'a', amount: 100, categoryId: 'c');
    expect(res, isA<ErrorResult<TransactionModel, Failure>>());
    expect((res as ErrorResult).error.message, contains('db fail'));
  });
}
