import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/goals/domain/goal_model.dart';
import 'package:poka_ce/features/goals/domain/i_goal_repository.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_notifier.dart';

class MockGoalRepository extends Mock implements IGoalRepository {}

class FakeGoalModel extends Fake implements GoalModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockGoalRepository mockRepo;

  setUpAll(() {
    registerFallbackValue(FakeGoalModel());
  });

  setUp(() => mockRepo = MockGoalRepository());

  ProviderContainer createContainer() {
    final c = ProviderContainer(overrides: [goalRepositoryProvider.overrideWithValue(mockRepo)]);
    c.listen(goalProvider, (_, __) {});
    addTearDown(c.dispose);
    return c;
  }

  Future<void> wait() async => Future.delayed(const Duration(milliseconds: 50));

  group('GoalNotifier', () {
    test('initial loading', () async {
      when(() => mockRepo.watchGoals()).thenAnswer((_) => const Stream.empty());
      final container = createContainer();
      expect(container.read(goalProvider).isLoading, true);
      await wait();
    });

    test('load success', () async {
      final goals = [
        GoalModel(
          id: '1',
          accountId: 'a1',
          name: 'Vacation',
          targetAmount: 5000,
          createdAt: DateTime.utc(2024, 1, 1),
          updatedAt: DateTime.utc(2024, 1, 1),
        ),
      ];
      when(() => mockRepo.watchGoals()).thenAnswer((_) => Stream.value(goals));
      final container = createContainer();
      await wait();
      final state = container.read(goalProvider).value;
      expect(state, isNotNull);
      expect(state!.first.name, 'Vacation');
    });

    test('load error surfaces error state', () async {
      when(() => mockRepo.watchGoals()).thenAnswer((_) => Stream.error(Exception('fail')));
      final container = createContainer();
      await wait();
      expect(container.read(goalProvider).hasError, true);
    });

    test('delete success', () async {
      when(() => mockRepo.watchGoals()).thenAnswer((_) => Stream.value(const <GoalModel>[]));
      when(() => mockRepo.deleteGoal(any())).thenAnswer((_) async => const Success(null));
      final container = createContainer();
      await wait();
      await container.read(goalProvider.notifier).deleteGoal('1');
      await wait();
      verify(() => mockRepo.deleteGoal('1')).called(1);
    });

    test('delete failure does not throw', () async {
      when(() => mockRepo.watchGoals()).thenAnswer((_) => Stream.value(const <GoalModel>[]));
      when(() => mockRepo.deleteGoal(any())).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      final container = createContainer();
      await wait();
      clearInteractions(mockRepo);
      await container.read(goalProvider.notifier).deleteGoal('1');
      await wait();
      verify(() => mockRepo.deleteGoal('1')).called(1);
    });

    test('updateGoal delegates to repository', () async {
      when(() => mockRepo.watchGoals()).thenAnswer((_) => Stream.value(const <GoalModel>[]));
      when(() => mockRepo.updateGoal(any())).thenAnswer((_) async => const Success(null));
      final container = createContainer();
      await wait();
      clearInteractions(mockRepo);

      final goal = GoalModel(
        id: 'g1',
        accountId: 'a1',
        name: 'Updated Goal',
        targetAmount: 100,
        createdAt: DateTime.utc(2024, 1, 1),
        updatedAt: DateTime.utc(2024, 1, 1),
      );
      await container.read(goalProvider.notifier).updateGoal(goal);
      await wait();
      verify(() => mockRepo.updateGoal(goal)).called(1);
    });

    test('updateGoal failure does not throw', () async {
      when(() => mockRepo.watchGoals()).thenAnswer((_) => Stream.value(const <GoalModel>[]));
      when(() => mockRepo.updateGoal(any())).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      final container = createContainer();
      await wait();

      final goal = GoalModel(
        id: 'g1',
        accountId: 'a1',
        name: 'Goal',
        targetAmount: 100,
        createdAt: DateTime.utc(2024, 1, 1),
        updatedAt: DateTime.utc(2024, 1, 1),
      );
      await expectLater(
        container.read(goalProvider.notifier).updateGoal(goal),
        completes,
      );
    });
  });

  group('GoalItemState', () {
    GoalModel goal({int targetAmount = 1000, GoalStatus status = GoalStatus.active}) => GoalModel(
      id: 'g1',
      accountId: 'a1',
      name: 'Goal',
      targetAmount: targetAmount,
      status: status,
      createdAt: DateTime.utc(2024, 1, 1),
      updatedAt: DateTime.utc(2024, 1, 1),
    );

    test('completed goal counts target as saved', () {
      final item = GoalItemState(goal: goal(status: GoalStatus.completed), currentBalance: 200);
      expect(item.isCompleted, isTrue);
      expect(item.saved, 1000);
      expect(item.progress, 1.0);
      expect(item.isTargetReached, isTrue);
      expect(item.remaining, 0);
    });

    test('active goal uses current balance', () {
      final item = GoalItemState(goal: goal(), currentBalance: 400);
      expect(item.isCompleted, isFalse);
      expect(item.saved, 400);
      expect(item.progress, closeTo(0.4, 0.001));
      expect(item.isTargetReached, isFalse);
      expect(item.remaining, 600);
    });

    test('progress clamps and handles zero target', () {
      final over = GoalItemState(goal: goal(), currentBalance: 5000);
      expect(over.progress, 1.0);
      expect(over.isTargetReached, isTrue);

      final zeroTarget = GoalItemState(goal: goal(targetAmount: 0), currentBalance: 0);
      expect(zeroTarget.progress, 0.0);
    });
  });
}
