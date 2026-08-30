import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/goals/domain/goal_model.dart';
import 'package:poka_ce/features/goals/domain/i_goal_repository.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_form_notifier.dart';

class MockGoalRepository extends Mock implements IGoalRepository {}

class FakeGoalModel extends Fake implements GoalModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockGoalRepository mockRepo;
  setUpAll(() => registerFallbackValue(FakeGoalModel()));
  setUp(() {
    mockRepo = MockGoalRepository();
    when(() => mockRepo.getGoals()).thenAnswer((_) async => const Success([]));
    when(() => mockRepo.createGoal(any())).thenAnswer((_) async => const Success(null));
    when(() => mockRepo.updateGoal(any())).thenAnswer((_) async => const Success(null));
  });

  ProviderContainer createContainer() {
    final c = ProviderContainer(overrides: [goalRepositoryProvider.overrideWithValue(mockRepo)]);
    c.listen(goalFormProvider, (_, __) {});
    addTearDown(c.dispose);
    return c;
  }

  GoalModel sample() => GoalModel(
    id: 'g1',
    accountId: 'a1',
    name: 'Vacation',
    targetAmount: 5000,
    createdAt: DateTime.utc(2024, 1, 1),
    updatedAt: DateTime.utc(2024, 1, 1),
    targetDate: DateTime.utc(2025, 1, 1),
  );

  group('GoalFormNotifier', () {
    test('init null', () {
      final container = createContainer();
      final n = container.read(goalFormProvider.notifier);
      n.setName('tmp');
      n.init(null);
      expect(container.read(goalFormProvider).name, '');
    });

    test('init with model', () {
      final container = createContainer();
      final n = container.read(goalFormProvider.notifier);
      n.init(sample());
      expect(container.read(goalFormProvider).name, 'Vacation');
      expect(container.read(goalFormProvider).targetAmount, 5000);
    });

    test('setters', () {
      final container = createContainer();
      final n = container.read(goalFormProvider.notifier);
      n.setName('Car');
      n.setTargetAmount(10000);
      n.setTargetDate(DateTime.utc(2025, 12, 31));
      final s = container.read(goalFormProvider);
      expect(s.name, 'Car');
      expect(s.targetAmount, 10000);
      expect(s.targetDate, DateTime.utc(2025, 12, 31));
    });

    test('validation empty name', () async {
      final container = createContainer();
      final n = container.read(goalFormProvider.notifier);
      n.setName('   ');
      n.setTargetAmount(1000);
      await n.save();
      expect(container.read(goalFormProvider).error, 'Name cannot be empty');
    });

    test('validation targetAmount <=0', () async {
      final container = createContainer();
      final n = container.read(goalFormProvider.notifier);
      n.setName('Test');
      n.setTargetAmount(0);
      await n.save();
      expect(container.read(goalFormProvider).error, 'Target amount must be greater than 0');
    });

    test('save create success', () async {
      when(() => mockRepo.createGoal(any())).thenAnswer((_) async => const Success(null));
      final container = createContainer();
      final n = container.read(goalFormProvider.notifier);
      n.setName('New');
      n.setTargetAmount(5000);
      await n.save();
      await Future.delayed(const Duration(milliseconds: 50));
      expect(container.read(goalFormProvider).isSuccess, true);
      verify(() => mockRepo.createGoal(any())).called(1);
    });

    test('save create failure', () async {
      when(() => mockRepo.createGoal(any())).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      final container = createContainer();
      final n = container.read(goalFormProvider.notifier);
      n.setName('New');
      n.setTargetAmount(5000);
      await n.save();
      expect(container.read(goalFormProvider).error, 'fail');
    });

    test('save update success', () async {
      when(() => mockRepo.updateGoal(any())).thenAnswer((_) async => const Success(null));
      final container = createContainer();
      final n = container.read(goalFormProvider.notifier);
      n.init(sample());
      n.setName('Updated');
      await n.save();
      await Future.delayed(const Duration(milliseconds: 50));
      expect(container.read(goalFormProvider).isSuccess, true);
      verify(() => mockRepo.updateGoal(any())).called(1);
    });

    test('save update failure', () async {
      when(() => mockRepo.updateGoal(any())).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      final container = createContainer();
      final n = container.read(goalFormProvider.notifier);
      n.init(sample());
      n.setName('Updated');
      await n.save();
      expect(container.read(goalFormProvider).error, 'fail');
    });

    test('copyWith', () {
      const s = GoalFormState(name: 'a', targetAmount: 1);
      final c = s.copyWith(name: 'b');
      expect(c.name, 'b');
    });
  });
}
