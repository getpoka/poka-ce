import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';
import 'package:poka_ce/features/debts/domain/i_debt_repository.dart';
import 'package:poka_ce/features/debts/presentation/controllers/debt_list_notifier.dart';

class MockDebtRepository extends Mock implements IDebtRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockDebtRepository mockRepo;
  setUp(() => mockRepo = MockDebtRepository());

  ProviderContainer createContainer() {
    final container = ProviderContainer(overrides: [debtRepositoryProvider.overrideWithValue(mockRepo)]);
    container.listen(debtListProvider, (_, __) {});
    addTearDown(container.dispose);
    return container;
  }

  Future<void> wait() async => Future.delayed(const Duration(milliseconds: 50));

  group('DebtListNotifier', () {
    test('initial loading', () async {
      when(() => mockRepo.watchDebts()).thenAnswer((_) => const Stream.empty());
      final container = createContainer();
      expect(container.read(debtListProvider).isLoading, true);
      await wait();
    });

    test('load success', () async {
      final debts = [
        DebtModel(
          id: '1',
          personName: 'Alice',
          type: DebtType.debt,
          amount: 1000,
          remainingAmount: 1000,
          status: DebtStatus.active,
          createdAt: DateTime.utc(2024, 1, 1),
          updatedAt: DateTime.utc(2024, 1, 1),
        ),
      ];
      when(() => mockRepo.watchDebts()).thenAnswer((_) => Stream.value(debts));
      final container = createContainer();
      await wait();
      final state = container.read(debtListProvider).value;
      expect(state, isNotNull);
      expect(state!.first.personName, 'Alice');
      expect(container.read(debtListProvider).isLoading, false);
    });

    test('load error surfaces empty list', () async {
      when(() => mockRepo.watchDebts()).thenAnswer((_) => Stream.error(Exception('fail')));
      final container = createContainer();
      await wait();
      expect(container.read(debtListProvider).hasError, true);
    });

    test('delete success', () async {
      when(() => mockRepo.watchDebts()).thenAnswer((_) => Stream.value(const <DebtModel>[]));
      when(() => mockRepo.deleteDebt(any())).thenAnswer((_) async => const Success(null));
      final container = createContainer();
      await wait();
      await container.read(debtListProvider.notifier).deleteDebt('1');
      await wait();
      verify(() => mockRepo.deleteDebt('1')).called(1);
    });

    test('delete failure does not throw', () async {
      when(() => mockRepo.watchDebts()).thenAnswer((_) => Stream.value(const <DebtModel>[]));
      when(() => mockRepo.deleteDebt(any())).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      final container = createContainer();
      await wait();
      clearInteractions(mockRepo);
      await container.read(debtListProvider.notifier).deleteDebt('1');
      await wait();
      verify(() => mockRepo.deleteDebt('1')).called(1);
    });
  });
}
