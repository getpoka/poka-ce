import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:poka_ce/features/budgets/domain/i_budget_repository.dart';
import 'package:poka_ce/features/budgets/presentation/controllers/budget_list_notifier.dart';

class MockBudgetRepository extends Mock implements IBudgetRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockBudgetRepository mockRepo;

  setUp(() {
    mockRepo = MockBudgetRepository();
  });

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [budgetRepositoryProvider.overrideWithValue(mockRepo)],
    );
    container.listen(budgetListProvider, (_, __) {});
    addTearDown(container.dispose);
    return container;
  }

  Future<void> wait() async => Future.delayed(const Duration(milliseconds: 50));

  group('BudgetListNotifier', () {
    test('initial state is loading', () async {
      when(() => mockRepo.getBudgets()).thenAnswer((_) async => const Success([]));
      final container = createContainer();
      expect(container.read(budgetListProvider).isLoading, true);
      await wait();
    });

    test('load success', () async {
      final budgets = [
        BudgetModel(
          id: '1',
          name: 'Food',
          amount: 1000,
          period: BudgetPeriod.monthly,
          startDate: DateTime.utc(2024, 1, 1),
          createdAt: DateTime.utc(2024, 1, 1),
          updatedAt: DateTime.utc(2024, 1, 1),
        ),
      ];
      when(() => mockRepo.getBudgets()).thenAnswer((_) async => Success(budgets));
      final container = createContainer();
      await wait();
      final s = container.read(budgetListProvider).value;
      expect(s, isNotNull);
      expect(s!.length, 1);
      expect(s.first.name, 'Food');
    });

    test('load error', () async {
      when(() => mockRepo.getBudgets()).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      final container = createContainer();
      await wait();
      expect(container.read(budgetListProvider).hasError, true);
    });

    test('refresh reloads', () async {
      when(() => mockRepo.getBudgets()).thenAnswer((_) async => const Success([]));
      final container = createContainer();
      await wait();
      final budgets = [
        BudgetModel(
          id: '2',
          name: 'Rent',
          amount: 2000,
          period: BudgetPeriod.monthly,
          startDate: DateTime.utc(2024, 1, 1),
          createdAt: DateTime.utc(2024, 1, 1),
          updatedAt: DateTime.utc(2024, 1, 1),
        ),
      ];
      when(() => mockRepo.getBudgets()).thenAnswer((_) async => Success(budgets));
      await container.read(budgetListProvider.notifier).refresh();
      await wait();
      expect(container.read(budgetListProvider).value!.first.name, 'Rent');
    });

    test('deleteBudget success triggers refresh', () async {
      when(() => mockRepo.getBudgets()).thenAnswer((_) async => const Success([]));
      when(() => mockRepo.deleteBudget(any())).thenAnswer((_) async => const Success(null));
      final container = createContainer();
      await wait();
      await container.read(budgetListProvider.notifier).deleteBudget('1');
      await wait();
      verify(() => mockRepo.deleteBudget('1')).called(1);
      verify(() => mockRepo.getBudgets()).called(greaterThanOrEqualTo(2));
    });

    test('deleteBudget failure does not refresh', () async {
      when(() => mockRepo.getBudgets()).thenAnswer((_) async => const Success([]));
      when(() => mockRepo.deleteBudget(any())).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      final container = createContainer();
      await wait();
      clearInteractions(mockRepo);
      when(() => mockRepo.deleteBudget(any())).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      await container.read(budgetListProvider.notifier).deleteBudget('1');
      await wait();
      verify(() => mockRepo.deleteBudget('1')).called(1);
      verifyNever(() => mockRepo.getBudgets());
    });
  });
}
