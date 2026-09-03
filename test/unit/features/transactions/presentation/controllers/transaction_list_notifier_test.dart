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

    test('searchQuery filters transactions', () async {
      final txs = [
        TransactionModel(
          id: '1',
          accountId: 'a1',
          type: TransactionType.expense,
          amount: 500,
          transactionDate: DateTime.utc(2024, 1, 1),
          createdAt: DateTime.utc(2024, 1, 1),
          updatedAt: DateTime.utc(2024, 1, 1),
          note: 'Groceries at market',
        ),
        TransactionModel(
          id: '2',
          accountId: 'a1',
          type: TransactionType.income,
          amount: 1000,
          transactionDate: DateTime.utc(2024, 1, 1),
          createdAt: DateTime.utc(2024, 1, 1),
          updatedAt: DateTime.utc(2024, 1, 1),
          note: 'Salary',
        ),
      ];
      stubWatch(Success(txs));
      final container = createContainer();

      // Initial load
      await container.read(transactionListNotifierProvider.notifier).refresh();
      await wait();
      expect(container.read(transactionListNotifierProvider).transactions.length, 2);

      // Apply search query
      container
          .read(transactionListNotifierProvider.notifier)
          .applyFilter(
            const TransactionFilter(searchQuery: 'groceries'),
          );
      await wait();

      // Verify filtered results
      final filtered = container.read(transactionListNotifierProvider).transactions;
      expect(filtered.length, 1);
      expect(filtered.first.id, '1');
    });

    test('copyWith', () {
      final s = TransactionListState(
        transactions: const [],
        isLoading: false,
        focusedDate: DateTime.utc(2024, 1, 1),
      );
      expect(s.copyWith(isLoading: true).isLoading, true);
      expect(s.copyWith(errorMessage: 'oops').errorMessage, 'oops');
      expect(s.copyWith(viewMode: TransactionViewMode.month).viewMode, TransactionViewMode.month);
      expect(s.copyWith(focusedDate: DateTime.utc(2025)).focusedDate, DateTime.utc(2025));
    });

    test('TransactionFilter isActive and copyWith', () {
      const empty = TransactionFilter();
      expect(empty.isActive, isFalse);
      const withType = TransactionFilter(types: {TransactionType.income});
      expect(withType.isActive, isTrue);
      const withAccount = TransactionFilter(accountIds: {'a1'});
      expect(withAccount.isActive, isTrue);
      const withCategory = TransactionFilter(categoryIds: {'c1'});
      expect(withCategory.isActive, isTrue);
      const withQuery = TransactionFilter(searchQuery: 'x');
      expect(withQuery.isActive, isTrue);

      final copied = withType.copyWith(types: {TransactionType.expense}, searchQuery: 'q');
      expect(copied.types, {TransactionType.expense});
      expect(copied.searchQuery, 'q');
      expect(copied.accountIds, isEmpty);
      expect(copied.copyWith().types, {TransactionType.expense});
    });

    test('period summary getters sum income and expense', () {
      TransactionModel tx(String id, TransactionType type, int amount, {String? note, int? itemAmount}) {
        return TransactionModel(
          id: id,
          accountId: 'a1',
          type: type,
          amount: amount,
          transactionDate: DateTime.utc(2024, 1, 1),
          createdAt: DateTime.utc(2024, 1, 1),
          updatedAt: DateTime.utc(2024, 1, 1),
          note: note,
          items: [
            TransactionItemModel(
              id: '$id-item',
              transactionId: id,
              amount: itemAmount ?? amount,
              createdAt: DateTime.utc(2024, 1, 1),
              updatedAt: DateTime.utc(2024, 1, 1),
            ),
          ],
        );
      }

      final s = TransactionListState(
        focusedDate: DateTime.utc(2024, 1, 1),
        isLoading: false,
        transactions: [
          tx('1', TransactionType.income, 1000),
          tx('2', TransactionType.expense, 400, itemAmount: 150),
          tx('3', TransactionType.transfer, 100),
        ],
      );
      expect(s.periodIncome, 1000);
      expect(s.periodExpense, 400);
      expect(s.periodNet, 600);
    });

    test('periodLabel for day/week/month modes', () {
      final monday = DateTime(2024, 1, 8); // a Monday
      final dayState = TransactionListState(focusedDate: monday, viewMode: TransactionViewMode.day);
      expect(dayState.periodLabel, isNotEmpty);

      final weekState = TransactionListState(focusedDate: monday, viewMode: TransactionViewMode.week);
      expect(weekState.periodLabel, startsWith('Week '));
      expect(weekState.periodLabel, contains('Jan 2024'));

      final monthState = TransactionListState(focusedDate: monday, viewMode: TransactionViewMode.month);
      expect(monthState.periodLabel, 'January 2024');
    });

    test('periodShortLabel per view mode', () {
      final s = TransactionListState(focusedDate: DateTime.utc(2024, 1, 1));
      expect(s.periodShortLabel, 'Daily');
      expect(s.copyWith(viewMode: TransactionViewMode.week).periodShortLabel, 'Weekly');
      expect(s.copyWith(viewMode: TransactionViewMode.month).periodShortLabel, 'Monthly');
    });

    test('isCurrentPeriod for today vs past', () {
      final now = DateTime.now();
      final todayState = TransactionListState(focusedDate: now, viewMode: TransactionViewMode.day);
      expect(todayState.isCurrentPeriod, isTrue);

      final pastState = TransactionListState(
        focusedDate: DateTime(now.year - 1, 1, 1),
        viewMode: TransactionViewMode.day,
      );
      expect(pastState.isCurrentPeriod, isFalse);

      final pastWeek = TransactionListState(
        focusedDate: DateTime(now.year - 1, 1, 1),
        viewMode: TransactionViewMode.week,
      );
      expect(pastWeek.isCurrentPeriod, isFalse);

      final pastMonth = TransactionListState(
        focusedDate: DateTime(now.year - 1, 1, 1),
        viewMode: TransactionViewMode.month,
      );
      expect(pastMonth.isCurrentPeriod, isFalse);
    });

    test('setViewMode switches window and reloads', () async {
      stubWatch(const Success([]));
      final container = createContainer();
      await wait();
      container.read(transactionListNotifierProvider.notifier).setViewMode(TransactionViewMode.week);
      await wait();
      expect(container.read(transactionListNotifierProvider).viewMode, TransactionViewMode.week);
      expect(container.read(transactionListNotifierProvider).periodShortLabel, 'Weekly');
    });

    test('navigatePrev and navigateNext move focused date', () async {
      stubWatch(const Success([]));
      final container = createContainer();
      await wait();

      final notifier = container.read(transactionListNotifierProvider.notifier);
      final before = container.read(transactionListNotifierProvider).focusedDate;

      notifier.navigatePrev();
      await wait();
      final afterPrev = container.read(transactionListNotifierProvider).focusedDate;
      expect(afterPrev.isBefore(before), isTrue);

      notifier.navigateNext();
      await wait();
      final afterNext = container.read(transactionListNotifierProvider).focusedDate;
      expect(afterNext.isAfter(afterPrev), isTrue);
    });

    test('navigateNext is blocked at current period', () async {
      stubWatch(const Success([]));
      final container = createContainer();
      await wait();

      final notifier = container.read(transactionListNotifierProvider.notifier);
      final before = container.read(transactionListNotifierProvider).focusedDate;
      notifier.navigateNext();
      await wait();
      expect(container.read(transactionListNotifierProvider).focusedDate, before);
    });

    test('goToToday and jumpToDate re-anchor', () async {
      stubWatch(const Success([]));
      final container = createContainer();
      await wait();

      final notifier = container.read(transactionListNotifierProvider.notifier);
      notifier.jumpToDate(DateTime(2020, 6, 15));
      await wait();
      expect(container.read(transactionListNotifierProvider).focusedDate, DateTime(2020, 6, 15));

      notifier.goToToday();
      await wait();
      final focused = container.read(transactionListNotifierProvider).focusedDate;
      final now = DateTime.now();
      expect(focused.year, now.year);
      expect(focused.month, now.month);
      expect(focused.day, now.day);
    });

    test('clearFilter resets filter', () async {
      stubWatch(const Success([]));
      final container = createContainer();
      await wait();

      final notifier = container.read(transactionListNotifierProvider.notifier);
      notifier.applyFilter(const TransactionFilter(accountIds: {'a1'}));
      await wait();
      expect(container.read(transactionListNotifierProvider).filter.isActive, isTrue);

      notifier.clearFilter();
      await wait();
      expect(container.read(transactionListNotifierProvider).filter.isActive, isFalse);
    });

    test('search matches item notes and amounts', () async {
      final txs = [
        TransactionModel(
          id: '1',
          accountId: 'a1',
          type: TransactionType.expense,
          amount: 999,
          transactionDate: DateTime.utc(2024, 1, 1),
          createdAt: DateTime.utc(2024, 1, 1),
          updatedAt: DateTime.utc(2024, 1, 1),
          items: [
            TransactionItemModel(
              id: 'i1',
              transactionId: '1',
              amount: 500,
              createdAt: DateTime.utc(2024, 1, 1),
              updatedAt: DateTime.utc(2024, 1, 1),
              note: 'chicken rice',
            ),
            TransactionItemModel(
              id: 'i2',
              transactionId: '1',
              amount: 499,
              createdAt: DateTime.utc(2024, 1, 1),
              updatedAt: DateTime.utc(2024, 1, 1),
            ),
          ],
        ),
      ];
      stubWatch(Success(txs));
      final container = createContainer();
      await container.read(transactionListNotifierProvider.notifier).refresh();
      await wait();

      final notifier = container.read(transactionListNotifierProvider.notifier);
      notifier.applyFilter(const TransactionFilter(searchQuery: 'chicken'));
      await wait();
      expect(container.read(transactionListNotifierProvider).transactions.length, 1);

      notifier.applyFilter(const TransactionFilter(searchQuery: '499'));
      await wait();
      expect(container.read(transactionListNotifierProvider).transactions.length, 1);

      notifier.applyFilter(const TransactionFilter(searchQuery: 'nomatch'));
      await wait();
      expect(container.read(transactionListNotifierProvider).transactions, isEmpty);
    });

    test('search matches header amount', () async {
      final txs = [
        TransactionModel(
          id: '1',
          accountId: 'a1',
          type: TransactionType.expense,
          amount: 777,
          transactionDate: DateTime.utc(2024, 1, 1),
          createdAt: DateTime.utc(2024, 1, 1),
          updatedAt: DateTime.utc(2024, 1, 1),
        ),
      ];
      stubWatch(Success(txs));
      final container = createContainer();
      await container.read(transactionListNotifierProvider.notifier).refresh();
      await wait();

      container.read(transactionListNotifierProvider.notifier).applyFilter(const TransactionFilter(searchQuery: '777'));
      await wait();
      expect(container.read(transactionListNotifierProvider).transactions.length, 1);
    });

    test('deleteTransaction delegates to repository', () async {
      stubWatch(const Success([]));
      when(() => mockRepo.deleteTransaction('t1')).thenAnswer((_) async => const Success<void, Failure>(null));
      final container = createContainer();
      await wait();
      await container.read(transactionListNotifierProvider.notifier).deleteTransaction('t1');
      verify(() => mockRepo.deleteTransaction('t1')).called(1);
    });
  });
}
