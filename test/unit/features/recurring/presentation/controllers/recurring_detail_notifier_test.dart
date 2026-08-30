import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/recurring/domain/recurring_model.dart';
import 'package:poka_ce/features/recurring/presentation/controllers/recurring_detail_notifier.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';

class MockTransactionRepo extends Mock implements ITransactionRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockTransactionRepo mockRepo;

  setUp(() {
    mockRepo = MockTransactionRepo();
  });

  RecurringTransactionModel recurring() => RecurringTransactionModel(
    id: 'r1',
    accountId: 'a1',
    type: TransactionType.expense,
    amount: 50000,
    period: RecurringPeriod.monthly,
    nextDate: DateTime(2026, 8, 1),
    createdAt: DateTime(2026, 1, 1),
    updatedAt: DateTime(2026, 1, 1),
  );

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [transactionRepositoryProvider.overrideWithValue(mockRepo)],
    );
    container.listen(recurringTransactionsProvider(recurring()), (_, __) {});
    addTearDown(container.dispose);
    return container;
  }

  Future<void> wait() async => Future.delayed(const Duration(milliseconds: 50));

  group('recurringTransactions provider', () {
    test('maps Success to transaction list', () async {
      final tx = TransactionModel(
        id: 'tx1',
        accountId: 'a1',
        type: TransactionType.expense,
        amount: 50000,
        transactionDate: DateTime(2026, 8, 1),
        createdAt: DateTime(2026, 8, 1),
        updatedAt: DateTime(2026, 8, 1),
      );
      when(() => mockRepo.watchTransactions(recurringIds: any(named: 'recurringIds'))).thenAnswer(
        (_) => Stream.value(Success<List<TransactionModel>, Failure>([tx])),
      );

      final container = createContainer();
      await wait();

      final value = container.read(recurringTransactionsProvider(recurring())).value;
      expect(value, isNotNull);
      expect(value, hasLength(1));
      expect(value!.first.id, 'tx1');
      verify(() => mockRepo.watchTransactions(recurringIds: {'r1'})).called(1);
    });

    test('captures error when repository returns an error', () async {
      when(() => mockRepo.watchTransactions(recurringIds: any(named: 'recurringIds'))).thenAnswer(
        (_) => Stream.value(
          const ErrorResult<List<TransactionModel>, Failure>(DatabaseFailure('boom')),
        ),
      );

      final container = createContainer();
      await wait();

      expect(container.read(recurringTransactionsProvider(recurring())).hasError, isTrue);
    });
  });
}
