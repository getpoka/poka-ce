import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/use_case_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/domain/use_cases/create_transaction_use_case.dart';
import 'package:poka_ce/features/transactions/domain/use_cases/transfer_funds_use_case.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_form_notifier.dart';
import 'package:poka_ce/features/budgets/domain/budget_alert_service.dart';
import 'package:poka_ce/features/budgets/domain/budget_alert_service_provider.dart';

class MockCreateTransactionUseCase extends Mock implements CreateTransactionUseCase {}

class MockTransferFundsUseCase extends Mock implements TransferFundsUseCase {}

class MockBudgetAlertService extends Mock implements BudgetAlertService {}

class FakeTransactionModel extends Fake implements TransactionModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockCreateTransactionUseCase mockCreate;
  late MockTransferFundsUseCase mockTransfer;
  late MockBudgetAlertService mockBudgetAlertService;

  setUpAll(() {
    registerFallbackValue(FakeTransactionModel());
    registerFallbackValue(TransactionType.expense);
  });

  setUp(() {
    mockCreate = MockCreateTransactionUseCase();
    mockTransfer = MockTransferFundsUseCase();
    mockBudgetAlertService = MockBudgetAlertService();
    when(() => mockBudgetAlertService.checkAlerts()).thenAnswer((_) async => null);
  });

  ProviderContainer createContainer() {
    final c = ProviderContainer(
      overrides: [
        createTransactionUseCaseProvider.overrideWithValue(mockCreate),
        transferFundsUseCaseProvider.overrideWithValue(mockTransfer),
        budgetAlertServiceProvider.overrideWithValue(mockBudgetAlertService),
      ],
    );
    addTearDown(c.dispose);
    return c;
  }

  TransactionModel sampleTx() => TransactionModel(
    id: 't1',
    accountId: 'a1',
    type: TransactionType.expense,
    amount: 500,
    transactionDate: DateTime.utc(2024, 1, 1),
    createdAt: DateTime.utc(2024, 1, 1),
    updatedAt: DateTime.utc(2024, 1, 1),
  );

  group('TransactionFormNotifier', () {
    const args = TransactionFormArgs();

    test('initial state', () {
      final container = createContainer();
      final s = container.read(transactionFormProvider(args));
      expect(s.isLoading, false);
      expect(s.isSuccess, false);
      expect(s.error, isNull);
    });

    test('save expense success via create use case', () async {
      when(
        () => mockCreate.execute(
          type: any(named: 'type'),
          accountId: any(named: 'accountId'),
          amount: any(named: 'amount'),
          categoryId: any(named: 'categoryId'),
          note: any(named: 'note'),
          transactionDate: any(named: 'transactionDate'),
          allocation: any(named: 'allocation'),
          splitItems: any(named: 'splitItems'),
        ),
      ).thenAnswer((_) async => Success(sampleTx()));
      final container = createContainer();
      final n = container.read(transactionFormProvider(args).notifier);
      n.setType(TransactionType.expense);
      n.setAccount('a1');
      n.onKeyPressed('5');
      n.onKeyPressed('0');
      n.onKeyPressed('0');
      n.setCategory('c1');
      await n.save();
      expect(container.read(transactionFormProvider(args)).isSuccess, true);
      expect(container.read(transactionFormProvider(args)).isLoading, false);
    });

    test('save expense failure', () async {
      when(
        () => mockCreate.execute(
          type: any(named: 'type'),
          accountId: any(named: 'accountId'),
          amount: any(named: 'amount'),
          categoryId: any(named: 'categoryId'),
          note: any(named: 'note'),
          transactionDate: any(named: 'transactionDate'),
          allocation: any(named: 'allocation'),
          splitItems: any(named: 'splitItems'),
        ),
      ).thenAnswer((_) async => const ErrorResult<TransactionModel, Failure>(DatabaseFailure('fail')));
      final container = createContainer();
      final n = container.read(transactionFormProvider(args).notifier);
      n.setType(TransactionType.expense);
      n.setAccount('a1');
      n.onKeyPressed('5');
      n.onKeyPressed('0');
      n.onKeyPressed('0');
      n.setCategory('c1');
      await n.save();
      expect(container.read(transactionFormProvider(args)).error, 'fail');
      expect(container.read(transactionFormProvider(args)).isSuccess, false);
    });

    test('save transfer success', () async {
      when(
        () => mockTransfer.execute(
          amount: any(named: 'amount'),
          sourceAccountId: any(named: 'sourceAccountId'),
          destinationAccountId: any(named: 'destinationAccountId'),
          note: any(named: 'note'),
        ),
      ).thenAnswer((_) async => Success(sampleTx().copyWith(type: TransactionType.transfer)));
      final container = createContainer();
      final n = container.read(transactionFormProvider(args).notifier);
      n.setType(TransactionType.transfer);
      n.setAccount('a1');
      n.onKeyPressed('1');
      n.onKeyPressed('0');
      n.onKeyPressed('0');
      n.onKeyPressed('0');
      n.setDestinationAccount('a2');
      await n.save();
      expect(container.read(transactionFormProvider(args)).isSuccess, true);
    });

    test('save transfer failure', () async {
      when(
        () => mockTransfer.execute(
          amount: any(named: 'amount'),
          sourceAccountId: any(named: 'sourceAccountId'),
          destinationAccountId: any(named: 'destinationAccountId'),
          note: any(named: 'note'),
        ),
      ).thenAnswer((_) async => const ErrorResult<TransactionModel, Failure>(DatabaseFailure('db')));
      final container = createContainer();
      final n = container.read(transactionFormProvider(args).notifier);
      n.setType(TransactionType.transfer);
      n.setAccount('a1');
      n.onKeyPressed('1');
      n.onKeyPressed('0');
      n.onKeyPressed('0');
      n.onKeyPressed('0');
      n.setDestinationAccount('a2');
      await n.save();
      expect(container.read(transactionFormProvider(args)).error, 'db');
    });

    test('save catches exception', () async {
      when(
        () => mockCreate.execute(
          type: any(named: 'type'),
          accountId: any(named: 'accountId'),
          amount: any(named: 'amount'),
          categoryId: any(named: 'categoryId'),
          note: any(named: 'note'),
          transactionDate: any(named: 'transactionDate'),
          allocation: any(named: 'allocation'),
          splitItems: any(named: 'splitItems'),
        ),
      ).thenThrow(Exception('boom'));
      final container = createContainer();
      final n = container.read(transactionFormProvider(args).notifier);
      n.setType(TransactionType.expense);
      n.setAccount('a1');
      n.onKeyPressed('5');
      n.onKeyPressed('0');
      n.onKeyPressed('0');
      n.setCategory('c1');
      await n.save();
      expect(container.read(transactionFormProvider(args)).error, contains('boom'));
    });
  });
}
