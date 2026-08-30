import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/goals/domain/goal_model.dart';
import 'package:poka_ce/features/goals/domain/i_goal_repository.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_notifier.dart';

class MockGoalRepository extends Mock implements IGoalRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockGoalRepository mockRepo;
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
  });
}
