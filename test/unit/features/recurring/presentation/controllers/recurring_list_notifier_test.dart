import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/recurring/domain/i_recurring_repository.dart';
import 'package:poka_ce/features/recurring/domain/recurring_model.dart';
import 'package:poka_ce/features/recurring/presentation/controllers/recurring_list_notifier.dart';

class MockRecurringRepository extends Mock implements IRecurringRepository {}

class FakeRecurringTransactionModel extends Fake implements RecurringTransactionModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockRecurringRepository mockRepo;

  setUpAll(() {
    registerFallbackValue(FakeRecurringTransactionModel());
  });

  setUp(() => mockRepo = MockRecurringRepository());

  ProviderContainer createContainer() {
    final c = ProviderContainer(overrides: [recurringRepositoryProvider.overrideWithValue(mockRepo)]);
    c.listen(recurringListProvider, (_, __) {});
    addTearDown(c.dispose);
    return c;
  }

  Future<void> wait() async => Future.delayed(const Duration(milliseconds: 50));

  group('RecurringListNotifier', () {
    test('initial loading', () async {
      when(() => mockRepo.getRecurringTransactions()).thenAnswer((_) async => const Success([]));
      final container = createContainer();
      expect(container.read(recurringListProvider).isLoading, true);
      await wait();
    });

    test('load success', () async {
      final list = [
        RecurringTransactionModel(
          id: '1',
          accountId: 'a1',
          type: TransactionType.expense,
          amount: 1000,
          period: RecurringPeriod.monthly,
          nextDate: DateTime.utc(2024, 1, 1),
          createdAt: DateTime.utc(2024, 1, 1),
          updatedAt: DateTime.utc(2024, 1, 1),
        ),
      ];
      when(() => mockRepo.getRecurringTransactions()).thenAnswer((_) async => Success(list));
      final container = createContainer();
      await wait();
      expect(container.read(recurringListProvider).recurrings.first.amount, 1000);
    });

    test('load error', () async {
      when(
        () => mockRepo.getRecurringTransactions(),
      ).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      final container = createContainer();
      await wait();
      expect(container.read(recurringListProvider).error, 'fail');
    });

    test('refresh', () async {
      when(() => mockRepo.getRecurringTransactions()).thenAnswer((_) async => const Success([]));
      final container = createContainer();
      await wait();
      final list = [
        RecurringTransactionModel(
          id: '2',
          accountId: 'a2',
          type: TransactionType.income,
          amount: 2000,
          period: RecurringPeriod.weekly,
          nextDate: DateTime.utc(2024, 1, 1),
          createdAt: DateTime.utc(2024, 1, 1),
          updatedAt: DateTime.utc(2024, 1, 1),
        ),
      ];
      when(() => mockRepo.getRecurringTransactions()).thenAnswer((_) async => Success(list));
      await container.read(recurringListProvider.notifier).refresh();
      await wait();
      expect(container.read(recurringListProvider).recurrings.first.amount, 2000);
    });

    test('delete success', () async {
      when(() => mockRepo.getRecurringTransactions()).thenAnswer((_) async => const Success([]));
      when(() => mockRepo.deleteRecurring(any())).thenAnswer((_) async => const Success(null));
      final container = createContainer();
      await wait();
      await container.read(recurringListProvider.notifier).deleteRecurring('1');
      await wait();
      verify(() => mockRepo.deleteRecurring('1')).called(1);
    });

    test('delete failure', () async {
      when(() => mockRepo.getRecurringTransactions()).thenAnswer((_) async => const Success([]));
      when(() => mockRepo.deleteRecurring(any())).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      final container = createContainer();
      await wait();
      clearInteractions(mockRepo);
      await container.read(recurringListProvider.notifier).deleteRecurring('1');
      await wait();
      verify(() => mockRepo.deleteRecurring(any())).called(1);
      verifyNever(() => mockRepo.getRecurringTransactions());
    });

    test('copyWith', () {
      const s = RecurringListState(recurrings: [], isLoading: false);
      expect(s.copyWith(isLoading: true).isLoading, true);
    });

    test('toggleActive flips optimistically and persists', () async {
      final recurring = RecurringTransactionModel(
        id: '1',
        accountId: 'a1',
        type: TransactionType.expense,
        amount: 1000,
        period: RecurringPeriod.monthly,
        nextDate: DateTime.utc(2024, 1, 1),
        createdAt: DateTime.utc(2024, 1, 1),
        updatedAt: DateTime.utc(2024, 1, 1),
      );
      when(() => mockRepo.getRecurringTransactions()).thenAnswer((_) async => Success([recurring]));
      when(() => mockRepo.updateRecurring(any())).thenAnswer((_) async => const Success(null));
      final container = createContainer();
      await wait();
      clearInteractions(mockRepo);

      await container.read(recurringListProvider.notifier).toggleActive('1');
      await wait();

      expect(container.read(recurringListProvider).recurrings.first.isActive, false);
      final updated = verify(() => mockRepo.updateRecurring(captureAny())).captured.single as RecurringTransactionModel;
      expect(updated.id, '1');
      expect(updated.isActive, false);
    });

    test('toggleActive refreshes to repository state on failure', () async {
      final recurring = RecurringTransactionModel(
        id: '1',
        accountId: 'a1',
        type: TransactionType.expense,
        amount: 1000,
        period: RecurringPeriod.monthly,
        nextDate: DateTime.utc(2024, 1, 1),
        createdAt: DateTime.utc(2024, 1, 1),
        updatedAt: DateTime.utc(2024, 1, 1),
      );
      when(() => mockRepo.getRecurringTransactions()).thenAnswer((_) async => Success([recurring]));
      when(() => mockRepo.updateRecurring(any())).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      final container = createContainer();
      await wait();
      clearInteractions(mockRepo);

      await container.read(recurringListProvider.notifier).toggleActive('1');
      await wait();

      // After rollback the fresh repository state is shown (active again).
      expect(container.read(recurringListProvider).recurrings.first.isActive, true);
    });

    test('toggleActive with unknown id does nothing', () async {
      when(() => mockRepo.getRecurringTransactions()).thenAnswer((_) async => const Success([]));
      final container = createContainer();
      await wait();
      clearInteractions(mockRepo);

      await container.read(recurringListProvider.notifier).toggleActive('unknown');
      await wait();
      verifyNever(() => mockRepo.updateRecurring(any()));
    });
  });
}
