import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/domain/i_account_repository.dart';
import 'package:poka_ce/features/accounts/domain/use_cases/reconcile_account_balance_use_case.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/domain/use_cases/create_transaction_use_case.dart';

class MockAccountRepository extends Mock implements IAccountRepository {}

class MockTransactionRepository extends Mock implements ITransactionRepository {}

class FakeTransactionModel extends Fake implements TransactionModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ReconcileAccountBalanceUseCase useCase;
  late MockAccountRepository mockAccountRepo;
  late MockTransactionRepository mockTxRepo;
  late CreateTransactionUseCase createTxUseCase;

  setUpAll(() {
    registerFallbackValue(FakeTransactionModel());
  });

  setUp(() {
    mockAccountRepo = MockAccountRepository();
    mockTxRepo = MockTransactionRepository();
    createTxUseCase = CreateTransactionUseCase(mockTxRepo);
    useCase = ReconcileAccountBalanceUseCase(mockAccountRepo, createTxUseCase);
  });

  final now = DateTime.utc(2026, 9, 20);
  final testPocket = AccountModel(
    id: 'pocket-1',
    name: 'BCA Utama',
    type: AccountType.assets,
    balance: 300000,
    initialBalance: 300000,
    parentId: 'root-1',
    isDefault: true,
    createdAt: now,
    updatedAt: now,
  );

  final testRoot = AccountModel(
    id: 'root-1',
    name: 'BCA',
    type: AccountType.assets,
    balance: 0,
    initialBalance: 0,
    parentId: null,
    createdAt: now,
    updatedAt: now,
  );

  test('returns Success without creating transaction when delta is 0', () async {
    final result = await useCase.execute(account: testPocket, currentBalance: 300000, targetBalance: 300000);

    expect(result, isA<Success<AccountModel, Failure>>());
    verifyNever(() => mockTxRepo.createTransaction(any()));
  });

  test('creates expense transaction when targetBalance is lower than currentBalance', () async {
    when(() => mockTxRepo.createTransaction(any())).thenAnswer((_) async => const Success(null));

    final result = await useCase.execute(
      account: testPocket,
      currentBalance: 300000,
      targetBalance: 250000,
      note: 'Penyesuaian uang hilang',
    );

    expect(result, isA<Success<AccountModel, Failure>>());
    final captured = verify(() => mockTxRepo.createTransaction(captureAny())).captured.single as TransactionModel;
    expect(captured.type, TransactionType.expense);
    expect(captured.amount, 50000);
    expect(captured.accountId, 'pocket-1');
    expect(captured.note, 'Penyesuaian uang hilang');
  });

  test('creates income transaction when targetBalance is higher than currentBalance', () async {
    when(() => mockTxRepo.createTransaction(any())).thenAnswer((_) async => const Success(null));

    final result = await useCase.execute(account: testPocket, currentBalance: 300000, targetBalance: 350000);

    expect(result, isA<Success<AccountModel, Failure>>());
    final captured = verify(() => mockTxRepo.createTransaction(captureAny())).captured.single as TransactionModel;
    expect(captured.type, TransactionType.income);
    expect(captured.amount, 50000);
    expect(captured.accountId, 'pocket-1');
  });

  test('resolves target account to Main Pocket when reconciling a Root Account', () async {
    when(() => mockAccountRepo.getAccounts()).thenAnswer((_) async => Success([testRoot, testPocket]));
    when(() => mockTxRepo.createTransaction(any())).thenAnswer((_) async => const Success(null));

    final result = await useCase.execute(account: testRoot, currentBalance: 300000, targetBalance: 250000);

    expect(result, isA<Success<AccountModel, Failure>>());
    final captured = verify(() => mockTxRepo.createTransaction(captureAny())).captured.single as TransactionModel;
    expect(captured.accountId, 'pocket-1');
    expect(captured.type, TransactionType.expense);
    expect(captured.amount, 50000);
  });

  test('returns ErrorResult when transaction creation fails', () async {
    when(() => mockTxRepo.createTransaction(any()))
        .thenAnswer((_) async => const ErrorResult(DatabaseFailure('Disk full')));

    final result = await useCase.execute(account: testPocket, currentBalance: 300000, targetBalance: 250000);

    expect(result, isA<ErrorResult<AccountModel, Failure>>());
    expect((result as ErrorResult).error, isA<DatabaseFailure>());
  });
}
