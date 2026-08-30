import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/goals/domain/goal_model.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_detail_notifier.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_notifier.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class _FakeGoalNotifier extends GoalNotifier {
  bool deleteCalled = false;
  bool updateCalled = false;
  GoalModel? updatedGoal;

  @override
  Stream<List<GoalModel>> build() => const Stream.empty();

  @override
  Future<void> deleteGoal(String id) async {
    deleteCalled = true;
  }

  @override
  Future<void> updateGoal(GoalModel model) async {
    updateCalled = true;
    updatedGoal = model;
  }
}

void main() {
  Widget wrap(Widget child, ProviderContainer container) {
    return UncontrolledProviderScope(
      container: container,
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(
            data: lightTheme,
            child: child!,
          ),
          home: Scaffold(body: child),
        ),
      ),
    );
  }

  group('GoalDetailNotifier', () {
    late ProviderContainer container;
    late _FakeGoalNotifier fakeGoalNotifier;

    final dummyGoal = GoalModel(
      id: 'g1',
      accountId: 'a1',
      name: 'Test',
      targetAmount: 100,
      status: GoalStatus.active,
      createdAt: DateTime(2020),
      updatedAt: DateTime(2020),
    );

    setUp(() {
      fakeGoalNotifier = _FakeGoalNotifier();
      container = ProviderContainer(
        overrides: [
          goalProvider.overrideWith(() => fakeGoalNotifier),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('deleteGoal confirmation true', (tester) async {
      await tester.pumpWidget(
        wrap(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  container.read(goalDetailProvider.notifier).deleteGoal(context, dummyGoal, currentBalance: 0);
                },
                child: const Text('Delete'),
              );
            },
          ),
          container,
        ),
      );

      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      // Tap delete on confirm dialog
      await tester.tap(find.text('Delete').last);
      await tester.pumpAndSettle();

      expect(fakeGoalNotifier.deleteCalled, isTrue);
    });

    testWidgets('deleteGoal confirmation false', (tester) async {
      await tester.pumpWidget(
        wrap(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  container.read(goalDetailProvider.notifier).deleteGoal(context, dummyGoal, currentBalance: 0);
                },
                child: const Text('Delete'),
              );
            },
          ),
          container,
        ),
      );

      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      // Tap cancel on confirm dialog
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(fakeGoalNotifier.deleteCalled, isFalse);
    });

    test('goalTransactions provider success', () async {
      final fakeTxRepo = _FakeTransactionRepo();
      final c = ProviderContainer(
        overrides: [
          transactionRepositoryProvider.overrideWith((ref) => fakeTxRepo),
        ],
      );
      addTearDown(c.dispose);

      final sub = c.listen(goalTransactionsProvider(dummyGoal), (_, __) {});

      final res = await c.read(goalTransactionsProvider(dummyGoal).future);
      expect(res, isEmpty);
    });
  });
}

class _FakeTransactionRepo implements ITransactionRepository {
  @override
  Stream<Result<List<TransactionModel>, Failure>> watchTransactions({
    DateTime? startDate,
    DateTime? endDate,
    String? accountId,
    String? categoryId,
    String? goalId,
    Set<String>? categoryIds,
    Set<String>? accountIds,
    Set<TransactionType>? types,
    Set<String>? debtIds,
    Set<String>? recurringIds,
    int? limit,
  }) {
    return Stream.value(const Success(<TransactionModel>[]));
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
