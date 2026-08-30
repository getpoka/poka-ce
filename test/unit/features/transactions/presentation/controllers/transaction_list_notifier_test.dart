import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';

class MockTransactionRepository extends Mock implements ITransactionRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockTransactionRepository mockRepo;
  setUp(() => mockRepo = MockTransactionRepository());

  ProviderContainer createContainer() {
    final c = ProviderContainer(overrides: [transactionRepositoryProvider.overrideWithValue(mockRepo)]);
    c.listen(transactionListNotifierProvider, (_, __) {});
    addTearDown(c.dispose);
    return c;
  }

  void stubWatch(Result<List<TransactionModel>, Failure> result) {
    when(
      () => mockRepo.watchTransactions(
        startDate: any(named: 'startDate'),
        endDate: any(named: 'endDate'),
        accountIds: any(named: 'accountIds'),
        categoryIds: any(named: 'categoryIds'),
        types: any(named: 'types'),
      ),
    ).thenAnswer((_) => Stream.value(result).asBroadcastStream());
  }

  Future<void> wait() async => Future.delayed(const Duration(milliseconds: 50));

  group('TransactionListNotifier', () {
    test('initial loading true', () async {
      stubWatch(const Success([]));
      final container = createContainer();
      expect(container.read(transactionListNotifierProvider).isLoading, true);
      await wait();
    });

    test('load success via refresh', () async {
      final txs = [
        TransactionModel(
          id: '1',
          accountId: 'a1',
          type: TransactionType.expense,
          amount: 500,
          transactionDate: DateTime.utc(2024, 1, 1),
          createdAt: DateTime.utc(2024, 1, 1),
          updatedAt: DateTime.utc(2024, 1, 1),
        ),
      ];
      stubWatch(Success(txs));
      final container = createContainer();
      await container.read(transactionListNotifierProvider.notifier).refresh();
      await wait();
      expect(container.read(transactionListNotifierProvider).transactions.first.amount, 500);
      expect(container.read(transactionListNotifierProvider).isLoading, false);
    });

    test('load error via refresh returns empty', () async {
      stubWatch(const ErrorResult<List<TransactionModel>, Failure>(DatabaseFailure('fail')));
      final container = createContainer();
      await container.read(transactionListNotifierProvider.notifier).refresh();
      await wait();
      expect(container.read(transactionListNotifierProvider).transactions, isEmpty);
      expect(container.read(transactionListNotifierProvider).isLoading, false);
    });

    test('refresh reloads', () async {
      stubWatch(const Success([]));
      final container = createContainer();
      await container.read(transactionListNotifierProvider.notifier).refresh();
      await wait();
      final txs = [
        TransactionModel(
          id: '2',
          accountId: 'a1',
          type: TransactionType.income,
          amount: 1000,
          transactionDate: DateTime.utc(2024, 1, 1),
          createdAt: DateTime.utc(2024, 1, 1),
          updatedAt: DateTime.utc(2024, 1, 1),
        ),
      ];
      stubWatch(Success(txs));
      await container.read(transactionListNotifierProvider.notifier).refresh();
      await wait();
      expect(container.read(transactionListNotifierProvider).transactions.first.amount, 1000);
    });

    test('copyWith', () {
      final s = TransactionListState(
        transactions: const [],
        isLoading: false,
        focusedDate: DateTime.utc(2024, 1, 1),
      );
      expect(s.copyWith(isLoading: true).isLoading, true);
    });
  });
}
