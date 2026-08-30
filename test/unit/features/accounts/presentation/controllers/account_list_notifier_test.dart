import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/domain/i_account_repository.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';

class MockAccountRepository extends Mock implements IAccountRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockAccountRepository mockRepo;

  setUp(() {
    mockRepo = MockAccountRepository();
  });

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [accountRepositoryProvider.overrideWithValue(mockRepo)],
    );
    container.listen(accountListProvider, (_, __) {});
    addTearDown(container.dispose);
    return container;
  }

  Stream<Result<List<AccountModel>, Failure>> resultStream(
    Result<List<AccountModel>, Failure> result,
  ) async* {
    yield result;
  }

  Future<void> wait() async => Future.delayed(const Duration(milliseconds: 50));

  group('AccountListNotifier', () {
    test('initial state is loading', () async {
      when(() => mockRepo.watchAccounts()).thenAnswer((_) => const Stream.empty());
      final container = createContainer();
      final state = container.read(accountListProvider);
      expect(state.isLoading, true);
      expect(state.value, isNull);
      await wait();
    });

    test('loads accounts success', () async {
      final accounts = [
        AccountModel(
          id: '1',
          name: 'Cash',
          type: AccountType.assets,
          balance: 1000,
          isActive: true,
          createdAt: DateTime.utc(2024, 1, 1),
          updatedAt: DateTime.utc(2024, 1, 1),
        ),
      ];
      when(() => mockRepo.watchAccounts()).thenAnswer((_) => resultStream(Success(accounts)));
      final container = createContainer();
      await wait();
      final state = container.read(accountListProvider).value;
      expect(state, isNotNull);
      expect(state!.accounts.length, 1);
      expect(state.accounts.first.name, 'Cash');
      expect(state.aggregates.length, 1);
      expect(state.aggregates.first.account.id, '1');
    });

    test('loads accounts error returns empty list', () async {
      when(() => mockRepo.watchAccounts()).thenAnswer(
        (_) => resultStream(
          const ErrorResult<List<AccountModel>, Failure>(DatabaseFailure('db fail')),
        ),
      );
      final container = createContainer();
      await wait();
      final state = container.read(accountListProvider).value;
      expect(state, isNotNull);
      expect(state!.accounts, isEmpty);
      expect(state.aggregates, isEmpty);
    });

    test('groups pockets into parent aggregates', () async {
      final parent = AccountModel(
        id: '1',
        name: 'Cash',
        type: AccountType.assets,
        balance: 1000,
        isActive: true,
        createdAt: DateTime.utc(2024, 1, 1),
        updatedAt: DateTime.utc(2024, 1, 1),
      );
      final pocket = AccountModel(
        id: 'p1',
        name: 'Pocket',
        type: AccountType.assets,
        balance: 100,
        parentId: '1',
        isActive: true,
        createdAt: DateTime.utc(2024, 1, 1),
        updatedAt: DateTime.utc(2024, 1, 1),
      );
      when(() => mockRepo.watchAccounts()).thenAnswer((_) => resultStream(Success([parent, pocket])));
      final container = createContainer();
      await wait();
      final state = container.read(accountListProvider).value;
      expect(state, isNotNull);
      expect(state!.aggregates.length, 1);
      expect(state.aggregates.first.pockets.length, 1);
      expect(state.aggregates.first.pockets.first.id, 'p1');
    });

    test('deactivateAccount calls repository', () async {
      when(() => mockRepo.watchAccounts()).thenAnswer((_) => resultStream(const Success([])));
      when(() => mockRepo.deactivateAccount(any())).thenAnswer((_) async => const Success(null));
      final container = createContainer();
      await wait();
      await container.read(accountListProvider.notifier).deactivateAccount('1');
      verify(() => mockRepo.deactivateAccount('1')).called(1);
    });

    test('deactivateAccount failure does not throw', () async {
      when(() => mockRepo.watchAccounts()).thenAnswer((_) => resultStream(const Success([])));
      when(() => mockRepo.deactivateAccount(any())).thenAnswer(
        (_) async => const ErrorResult<void, Failure>(DatabaseFailure('fail')),
      );
      final container = createContainer();
      await wait();
      await container.read(accountListProvider.notifier).deactivateAccount('1');
      verify(() => mockRepo.deactivateAccount('1')).called(1);
    });

    test('copyWith preserves', () {
      const s = AccountListState(accounts: [], aggregates: []);
      final c = s.copyWith(accounts: []);
      expect(c.accounts, isEmpty);
      expect(c.aggregates, isEmpty);
    });
  });
}
