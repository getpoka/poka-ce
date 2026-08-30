import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:poka_ce/features/budgets/domain/i_budget_repository.dart';
import 'package:poka_ce/features/budgets/presentation/controllers/budget_form_notifier.dart';

class MockBudgetRepository extends Mock implements IBudgetRepository {}

class FakeBudgetModel extends Fake implements BudgetModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockBudgetRepository mockRepo;

  setUpAll(() {
    registerFallbackValue(FakeBudgetModel());
  });

  setUp(() {
    mockRepo = MockBudgetRepository();
    when(() => mockRepo.getBudgets()).thenAnswer((_) async => const Success([]));
    when(() => mockRepo.createBudget(any())).thenAnswer((_) async => const Success(null));
    when(() => mockRepo.updateBudget(any())).thenAnswer((_) async => const Success(null));
  });

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [budgetRepositoryProvider.overrideWithValue(mockRepo)],
    );
    container.listen(budgetFormProvider, (_, __) {});
    addTearDown(container.dispose);
    return container;
  }

  BudgetModel sample() => BudgetModel(
    id: 'b1',
    name: 'Food',
    amount: 1000,
    period: BudgetPeriod.monthly,
    startDate: DateTime.utc(2024, 1, 1),
    createdAt: DateTime.utc(2024, 1, 1),
    updatedAt: DateTime.utc(2024, 1, 1),
  );

  group('BudgetFormNotifier', () {
    test('init null resets', () {
      final container = createContainer();
      final n = container.read(budgetFormProvider.notifier);
      n.setName('tmp');
      n.init(null);
      expect(container.read(budgetFormProvider).name, '');
    });

    test('init with model', () {
      final container = createContainer();
      final n = container.read(budgetFormProvider.notifier);
      n.init(sample());
      expect(container.read(budgetFormProvider).name, 'Food');
      expect(container.read(budgetFormProvider).amount, 1000);
    });

    test('setters', () {
      final container = createContainer();
      final n = container.read(budgetFormProvider.notifier);
      n.setName('Rent');
      n.setAmount(2000);
      n.setPeriod(BudgetPeriod.yearly);
      n.setCategoryId('c1');
      n.setAccountId('a1');
      final s = container.read(budgetFormProvider);
      expect(s.name, 'Rent');
      expect(s.amount, 2000);
      expect(s.period, BudgetPeriod.yearly);
      expect(s.categoryId, 'c1');
      expect(s.accountId, 'a1');
    });

    test('validation empty name', () async {
      final container = createContainer();
      final n = container.read(budgetFormProvider.notifier);
      n.setName('   ');
      n.setAmount(100);
      await n.save();
      expect(container.read(budgetFormProvider).error, 'Name cannot be empty');
    });

    test('validation amount <=0', () async {
      final container = createContainer();
      final n = container.read(budgetFormProvider.notifier);
      n.setName('Test');
      n.setAmount(0);
      await n.save();
      expect(container.read(budgetFormProvider).error, 'Amount must be greater than 0');
    });

    test('save create success', () async {
      when(() => mockRepo.createBudget(any())).thenAnswer((_) async => const Success(null));
      final container = createContainer();
      final n = container.read(budgetFormProvider.notifier);
      n.setName('New');
      n.setAmount(500);
      await n.save();
      await Future.delayed(const Duration(milliseconds: 50));
      expect(container.read(budgetFormProvider).isSuccess, true);
      verify(() => mockRepo.createBudget(any())).called(1);
    });

    test('save create failure', () async {
      when(() => mockRepo.createBudget(any())).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      final container = createContainer();
      final n = container.read(budgetFormProvider.notifier);
      n.setName('New');
      n.setAmount(500);
      await n.save();
      await Future.delayed(const Duration(milliseconds: 20));
      expect(container.read(budgetFormProvider).error, 'fail');
      expect(container.read(budgetFormProvider).isSaving, false);
    });

    test('save update success', () async {
      when(() => mockRepo.updateBudget(any())).thenAnswer((_) async => const Success(null));
      final container = createContainer();
      final n = container.read(budgetFormProvider.notifier);
      n.init(sample());
      n.setName('Updated');
      await n.save();
      await Future.delayed(const Duration(milliseconds: 50));
      expect(container.read(budgetFormProvider).isSuccess, true);
      verify(() => mockRepo.updateBudget(any())).called(1);
    });

    test('save update failure', () async {
      when(() => mockRepo.updateBudget(any())).thenAnswer((_) async => const ErrorResult(DatabaseFailure('db')));
      final container = createContainer();
      final n = container.read(budgetFormProvider.notifier);
      n.init(sample());
      n.setName('Updated');
      await n.save();
      expect(container.read(budgetFormProvider).error, 'db');
    });

    test('copyWith', () {
      const s = BudgetFormState(name: 'a', amount: 1);
      final c = s.copyWith(name: 'b');
      expect(c.name, 'b');
      expect(c.amount, 1);
    });
  });
}
