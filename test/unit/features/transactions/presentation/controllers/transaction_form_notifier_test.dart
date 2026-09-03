import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/use_case_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/split_item.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/domain/use_cases/create_transaction_use_case.dart';
import 'package:poka_ce/features/transactions/domain/use_cases/transfer_funds_use_case.dart';
import 'package:poka_ce/features/transactions/domain/use_cases/update_transaction_use_case.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_form_notifier.dart';
import 'package:poka_ce/features/budgets/domain/budget_alert_service.dart';
import 'package:poka_ce/features/budgets/domain/budget_alert_service_provider.dart';

class MockCreateTransactionUseCase extends Mock implements CreateTransactionUseCase {}

class MockUpdateTransactionUseCase extends Mock implements UpdateTransactionUseCase {}

class MockTransferFundsUseCase extends Mock implements TransferFundsUseCase {}

class MockBudgetAlertService extends Mock implements BudgetAlertService {}

class FakeTransactionModel extends Fake implements TransactionModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockCreateTransactionUseCase mockCreate;
  late MockUpdateTransactionUseCase mockUpdate;
  late MockTransferFundsUseCase mockTransfer;
  late MockBudgetAlertService mockBudgetAlertService;

  setUpAll(() {
    registerFallbackValue(FakeTransactionModel());
    registerFallbackValue(TransactionType.expense);
  });

  setUp(() {
    mockCreate = MockCreateTransactionUseCase();
    mockUpdate = MockUpdateTransactionUseCase();
    mockTransfer = MockTransferFundsUseCase();
    mockBudgetAlertService = MockBudgetAlertService();
    when(() => mockBudgetAlertService.checkAlerts()).thenAnswer((_) async => null);
  });

  ProviderContainer createContainer() {
    final c = ProviderContainer(
      overrides: [
        createTransactionUseCaseProvider.overrideWithValue(mockCreate),
        updateTransactionUseCaseProvider.overrideWithValue(mockUpdate),
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

  TransactionModel splitTx() => TransactionModel(
    id: 't2',
    accountId: 'a1',
    type: TransactionType.expense,
    amount: 700,
    transactionDate: DateTime.utc(2024, 2, 2),
    createdAt: DateTime.utc(2024, 2, 2),
    updatedAt: DateTime.utc(2024, 2, 2),
    note: 'receipt',
    items: [
      TransactionItemModel(
        id: 'i1',
        transactionId: 't2',
        amount: 300,
        categoryId: 'food',
        note: 'lunch',
        createdAt: DateTime.utc(2024, 2, 2),
        updatedAt: DateTime.utc(2024, 2, 2),
      ),
      TransactionItemModel(
        id: 'i2',
        transactionId: 't2',
        amount: 400,
        categoryId: 'transport',
        note: 'taxi',
        createdAt: DateTime.utc(2024, 2, 2),
        updatedAt: DateTime.utc(2024, 2, 2),
      ),
    ],
  );

  void stubCreateSuccess() {
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
  }

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
      stubCreateSuccess();
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

  group('TransactionFormNotifier validation guards', () {
    const args = TransactionFormArgs();

    test('save with zero amount does nothing', () async {
      stubCreateSuccess();
      final container = createContainer();
      final n = container.read(transactionFormProvider(args).notifier);
      n.setAccount('a1');
      n.setCategory('c1');
      await n.save();
      expect(container.read(transactionFormProvider(args)).isLoading, false);
      verifyNever(
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
      );
    });

    test('save without account does nothing', () async {
      stubCreateSuccess();
      final container = createContainer();
      final n = container.read(transactionFormProvider(args).notifier);
      n.onKeyPressed('5');
      n.setCategory('c1');
      await n.save();
      verifyNever(
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
      );
    });

    test('save transfer without destination does nothing', () async {
      stubCreateSuccess();
      final container = createContainer();
      final n = container.read(transactionFormProvider(args).notifier);
      n.setType(TransactionType.transfer);
      n.setAccount('a1');
      n.onKeyPressed('1');
      await n.save();
      verifyNever(
        () => mockTransfer.execute(
          amount: any(named: 'amount'),
          sourceAccountId: any(named: 'sourceAccountId'),
          destinationAccountId: any(named: 'destinationAccountId'),
          note: any(named: 'note'),
        ),
      );
    });

    test('OK key is ignored by numpad', () {
      final container = createContainer();
      final n = container.read(transactionFormProvider(args).notifier);
      n.onKeyPressed('5');
      n.onKeyPressed('OK');
      expect(container.read(transactionFormProvider(args)).amountExpression, '5');
    });

    test('= key evaluates expression inline', () {
      final container = createContainer();
      final n = container.read(transactionFormProvider(args).notifier);
      n.onKeyPressed('5');
      n.onKeyPressed('+');
      n.onKeyPressed('3');
      expect(container.read(transactionFormProvider(args)).amountExpression, '5+3');
      n.onKeyPressed('=');
      expect(container.read(transactionFormProvider(args)).amountExpression, '8');
    });

    test('= key shows history preview while typing unresolved expression', () {
      final container = createContainer();
      final n = container.read(transactionFormProvider(args).notifier);
      n.onKeyPressed('5');
      n.onKeyPressed('+');
      n.onKeyPressed('3');
      final s = container.read(transactionFormProvider(args));
      expect(s.amountExpression, '5+3');
      expect(s.historyExpression, '8');
    });

    test('= key keeps expression when result equals snapshot', () {
      final container = createContainer();
      final n = container.read(transactionFormProvider(args).notifier);
      n.onKeyPressed('5');
      n.onKeyPressed('=');
      expect(container.read(transactionFormProvider(args)).amountExpression, '5');
    });

    test('setNote, setDate, setAllocation update state', () {
      final container = createContainer();
      final n = container.read(transactionFormProvider(args).notifier);
      final date = DateTime.utc(2024, 6, 15);
      n.setNote('coffee');
      n.setDate(date);
      n.setAllocation(TransactionAllocation.want);
      final s = container.read(transactionFormProvider(args));
      expect(s.note, 'coffee');
      expect(s.date, date);
      expect(s.allocation, TransactionAllocation.want);
    });

    test('setCategory null clears category', () {
      final container = createContainer();
      final n = container.read(transactionFormProvider(args).notifier);
      n.setCategory('c1');
      expect(container.read(transactionFormProvider(args)).categoryId, 'c1');
      n.setCategory(null);
      expect(container.read(transactionFormProvider(args)).categoryId, isNull);
    });

    test('setType to income clears split items', () {
      final container = createContainer();
      final n = container.read(transactionFormProvider(args).notifier);
      n.setSplitItems([
        const SplitItem(amount: 100, categoryId: 'a'),
        const SplitItem(amount: 200, categoryId: 'b'),
      ]);
      expect(container.read(transactionFormProvider(args)).splitItems, isNotNull);
      n.setType(TransactionType.income);
      expect(container.read(transactionFormProvider(args)).splitItems, isNull);
    });

    test('setSplitItems updates amount total and clears history', () {
      final container = createContainer();
      final n = container.read(transactionFormProvider(args).notifier);
      n.onKeyPressed('5+5');
      n.setSplitItems([
        const SplitItem(amount: 100, categoryId: 'a'),
        const SplitItem(amount: 250, categoryId: 'b'),
      ]);
      final s = container.read(transactionFormProvider(args));
      expect(s.splitItems!.length, 2);
      expect(s.amountExpression, '350');
      expect(s.historyExpression, isNull);
    });

    test('setSplitItems null resets expression', () {
      final container = createContainer();
      final n = container.read(transactionFormProvider(args).notifier);
      n.setSplitItems([
        const SplitItem(amount: 100, categoryId: 'a'),
        const SplitItem(amount: 250, categoryId: 'b'),
      ]);
      n.setSplitItems(null);
      final s = container.read(transactionFormProvider(args));
      expect(s.splitItems, isNull);
      expect(s.amountExpression, '');
    });

    test('swapAccounts exchanges source and destination', () {
      final container = createContainer();
      final n = container.read(transactionFormProvider(args).notifier);
      n.setAccount('src');
      n.setDestinationAccount('dst');
      n.swapAccounts();
      final s = container.read(transactionFormProvider(args));
      expect(s.accountId, 'dst');
      expect(s.destinationAccountId, 'src');
    });

    test('TransactionFormArgs equality and hashCode', () {
      const a = TransactionFormArgs(initialAccountId: 'a1', initialAmount: '100');
      const b = TransactionFormArgs(initialAccountId: 'a1', initialAmount: '100');
      const c = TransactionFormArgs(initialAccountId: 'a2');
      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a == c, isFalse);
      expect(a == 'not-args', isFalse);
    });
  });

  group('TransactionFormNotifier edit mode', () {
    const args = TransactionFormArgs();

    test('build seeds state from initialTransaction', () {
      final container = createContainer();
      final tx = sampleTx().copyWith(note: 'edited');
      final editArgs = TransactionFormArgs(initialTransaction: tx);
      final s = container.read(transactionFormProvider(editArgs));
      expect(s.type, TransactionType.expense);
      expect(s.amountExpression, '500');
      expect(s.note, 'edited');
      expect(s.accountId, 'a1');
      expect(s.date, tx.transactionDate.toLocal());
    });

    test('build seeds split items from multi-item transaction', () {
      final container = createContainer();
      final editArgs = TransactionFormArgs(initialTransaction: splitTx());
      final s = container.read(transactionFormProvider(editArgs));
      expect(s.splitItems!.length, 2);
      expect(s.splitItems!.first.categoryId, 'food');
      expect(s.splitItems!.first.amount, 300);
      expect(s.amountExpression, '700');
      expect(s.categoryId, 'food');
    });

    test('build seeds from args without transaction', () {
      final container = createContainer();
      const args = TransactionFormArgs(
        initialType: TransactionType.income,
        initialAmount: '99',
        initialNote: 'bonus',
        initialAccountId: 'a9',
      );
      final s = container.read(transactionFormProvider(args));
      expect(s.type, TransactionType.income);
      expect(s.amountExpression, '99');
      expect(s.note, 'bonus');
      expect(s.accountId, 'a9');
    });

    test('save via update use case for expense', () async {
      when(
        () => mockUpdate.execute(
          any(),
          type: any(named: 'type'),
          accountId: any(named: 'accountId'),
          amount: any(named: 'amount'),
          categoryId: any(named: 'categoryId'),
          note: any(named: 'note'),
          transactionDate: any(named: 'transactionDate'),
          allocation: any(named: 'allocation'),
        ),
      ).thenAnswer((_) async => Success(sampleTx()));

      final tx = sampleTx();
      final container = createContainer();
      final args = TransactionFormArgs(initialTransaction: tx);
      final n = container.read(transactionFormProvider(args).notifier);
      n.onKeyPressed('9');
      n.setCategory('c2');
      await n.save();

      expect(container.read(transactionFormProvider(args)).isSuccess, true);
      final capturedTx =
          verify(
                () => mockUpdate.execute(
                  captureAny(),
                  type: any(named: 'type'),
                  accountId: any(named: 'accountId'),
                  amount: any(named: 'amount'),
                  categoryId: any(named: 'categoryId'),
                  note: any(named: 'note'),
                  transactionDate: any(named: 'transactionDate'),
                  allocation: any(named: 'allocation'),
                ),
              ).captured.single
              as TransactionModel;
      expect(capturedTx.id, 't1');
    });

    test('save via update use case for transfer', () async {
      when(
        () => mockUpdate.execute(
          any(),
          type: any(named: 'type'),
          accountId: any(named: 'accountId'),
          destinationAccountId: any(named: 'destinationAccountId'),
          amount: any(named: 'amount'),
          note: any(named: 'note'),
          transactionDate: any(named: 'transactionDate'),
        ),
      ).thenAnswer((_) async => Success(sampleTx().copyWith(type: TransactionType.transfer)));

      final tx = sampleTx().copyWith(type: TransactionType.transfer, destinationAccountId: 'a2');
      final container = createContainer();
      final args = TransactionFormArgs(initialTransaction: tx);
      final n = container.read(transactionFormProvider(args).notifier);
      n.onKeyPressed('8');
      n.setDestinationAccount('a3');
      await n.save();

      expect(container.read(transactionFormProvider(args)).isSuccess, true);
    });

    test('update failure sets error', () async {
      when(
        () => mockUpdate.execute(
          any(),
          type: any(named: 'type'),
          accountId: any(named: 'accountId'),
          amount: any(named: 'amount'),
          categoryId: any(named: 'categoryId'),
          note: any(named: 'note'),
          transactionDate: any(named: 'transactionDate'),
          allocation: any(named: 'allocation'),
        ),
      ).thenAnswer((_) async => const ErrorResult<TransactionModel, Failure>(DatabaseFailure('update fail')));

      final container = createContainer();
      final args = TransactionFormArgs(initialTransaction: sampleTx());
      final n = container.read(transactionFormProvider(args).notifier);
      n.setCategory('c1');
      n.onKeyPressed('1');
      await n.save();
      expect(container.read(transactionFormProvider(args)).error, 'update fail');
    });

    test('split save via create use case', () async {
      when(
        () => mockCreate.execute(
          type: any(named: 'type'),
          accountId: any(named: 'accountId'),
          amount: any(named: 'amount'),
          note: any(named: 'note'),
          transactionDate: any(named: 'transactionDate'),
          splitItems: any(named: 'splitItems'),
        ),
      ).thenAnswer((_) async => Success(splitTx()));

      final container = createContainer();
      final n = container.read(transactionFormProvider(args).notifier);
      n.setAccount('a1');
      n.setSplitItems([
        const SplitItem(amount: 300, categoryId: 'food', note: 'lunch'),
        const SplitItem(amount: 400, categoryId: 'transport', note: 'taxi'),
      ]);
      await n.save();
      expect(container.read(transactionFormProvider(args)).isSuccess, true);
      verify(
        () => mockBudgetAlertService.checkAlerts(),
      ).called(1);
    });

    test('split save via update use case', () async {
      when(
        () => mockUpdate.execute(
          any(),
          type: any(named: 'type'),
          accountId: any(named: 'accountId'),
          transactionDate: any(named: 'transactionDate'),
          splitItems: any(named: 'splitItems'),
        ),
      ).thenAnswer((_) async => Success(splitTx()));

      final container = createContainer();
      final args = TransactionFormArgs(initialTransaction: splitTx());
      final n = container.read(transactionFormProvider(args).notifier);
      n.setAccount('a1');
      n.setSplitItems([
        const SplitItem(amount: 300, categoryId: 'food'),
        const SplitItem(amount: 400, categoryId: 'transport'),
      ]);
      await n.save();
      expect(container.read(transactionFormProvider(args)).isSuccess, true);
    });

    test('split save with fewer than 2 items does nothing', () async {
      stubCreateSuccess();
      final container = createContainer();
      final n = container.read(transactionFormProvider(args).notifier);
      n.setAccount('a1');
      n.setSplitItems([const SplitItem(amount: 300, categoryId: 'food')]);
      await n.save();
      expect(container.read(transactionFormProvider(args)).isLoading, false);
    });

    test('split save with zero-amount item does nothing', () async {
      stubCreateSuccess();
      final container = createContainer();
      final n = container.read(transactionFormProvider(args).notifier);
      n.setAccount('a1');
      n.setSplitItems([
        const SplitItem(amount: 300, categoryId: 'food'),
        const SplitItem(amount: 0, categoryId: 'transport'),
      ]);
      await n.save();
      expect(container.read(transactionFormProvider(args)).isLoading, false);
    });

    test('split save without account does nothing', () async {
      stubCreateSuccess();
      final container = createContainer();
      final n = container.read(transactionFormProvider(args).notifier);
      n.setSplitItems([
        const SplitItem(amount: 300, categoryId: 'food'),
        const SplitItem(amount: 400, categoryId: 'transport'),
      ]);
      await n.save();
      expect(container.read(transactionFormProvider(args)).isLoading, false);
    });
  });
}
