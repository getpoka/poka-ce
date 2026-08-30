import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/recurring/domain/i_recurring_repository.dart';
import 'package:poka_ce/features/recurring/domain/recurring_model.dart';
import 'package:poka_ce/features/recurring/presentation/controllers/recurring_list_notifier.dart';
import 'package:poka_ce/features/recurring/presentation/controllers/recurring_runner_notifier.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class MockRecurringRepo extends Mock implements IRecurringRepository {}

class MockTransactionRepo extends Mock implements ITransactionRepository {}

class FakeRecurringListNotifier extends RecurringListNotifier {
  int refreshCount = 0;
  @override
  RecurringListState build() => const RecurringListState(isLoading: false);
  @override
  Future<void> refresh() async => refreshCount++;
}

class FakeTransactionModel extends Fake implements TransactionModel {}

class FakeRecurringModel extends Fake implements RecurringTransactionModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockRecurringRepo recurringRepo;
  late MockTransactionRepo transactionRepo;

  setUpAll(() {
    registerFallbackValue(FakeTransactionModel());
    registerFallbackValue(FakeRecurringModel());
  });

  setUp(() {
    recurringRepo = MockRecurringRepo();
    transactionRepo = MockTransactionRepo();
  });

  ProviderContainer containerWith(FakeRecurringListNotifier list) {
    return ProviderContainer(
      overrides: [
        recurringRepositoryProvider.overrideWithValue(recurringRepo),
        transactionRepositoryProvider.overrideWithValue(transactionRepo),
        recurringListProvider.overrideWith(() => list),
      ],
    );
  }

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

  group('recurringRunnerProvider', () {
    test('reports error when due query fails', () async {
      when(() => recurringRepo.getDueRecurringTransactions(any())).thenAnswer(
        (_) async => const ErrorResult<List<RecurringTransactionModel>, Failure>(
          DatabaseFailure('query failed'),
        ),
      );

      final container = containerWith(FakeRecurringListNotifier());
      addTearDown(container.dispose);

      container.listen(recurringRunnerProvider, (_, _) {});

      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(container.read(recurringRunnerProvider), isA<RecurringRunnerError>());
    });

    test('reports done with zero when no due transactions', () async {
      when(() => recurringRepo.getDueRecurringTransactions(any())).thenAnswer(
        (_) async => const Success<List<RecurringTransactionModel>, Failure>([]),
      );

      final container = containerWith(FakeRecurringListNotifier());
      addTearDown(container.dispose);

      container.listen(recurringRunnerProvider, (_, _) {});

      await Future<void>.delayed(const Duration(milliseconds: 50));
      final state = container.read(recurringRunnerProvider);
      expect(state, isA<RecurringRunnerDone>());
      expect((state as RecurringRunnerDone).processed, 0);
    });

    test('processes due transactions and refreshes list', () async {
      when(() => recurringRepo.getDueRecurringTransactions(any())).thenAnswer(
        (_) async => Success<List<RecurringTransactionModel>, Failure>([recurring()]),
      );
      when(() => transactionRepo.createTransaction(any())).thenAnswer(
        (_) async => const Success<void, Failure>(null),
      );
      when(() => recurringRepo.updateRecurring(any())).thenAnswer(
        (_) async => const Success<void, Failure>(null),
      );

      final list = FakeRecurringListNotifier();
      final container = containerWith(list);
      addTearDown(container.dispose);

      container.listen(recurringRunnerProvider, (_, _) {});

      await Future<void>.delayed(const Duration(milliseconds: 50));
      final state = container.read(recurringRunnerProvider);
      expect(state, isA<RecurringRunnerDone>());
      expect((state as RecurringRunnerDone).processed, 1);
      expect(list.refreshCount, 1);
      verify(() => transactionRepo.createTransaction(any())).called(1);
    });
  });
}
