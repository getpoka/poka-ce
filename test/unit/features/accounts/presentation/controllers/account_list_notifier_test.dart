import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/accounts/domain/account_aggregate.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/domain/i_account_repository.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';

class MockAccountRepository extends Mock implements IAccountRepository {}

class MockTransactionRepository extends Mock implements ITransactionRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockAccountRepository mockRepo;
  late MockTransactionRepository mockTxRepo;

  setUp(() {
    mockRepo = MockAccountRepository();
    mockTxRepo = MockTransactionRepository();
  });

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [
        accountRepositoryProvider.overrideWithValue(mockRepo),
        transactionRepositoryProvider.overrideWithValue(mockTxRepo),
      ],
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

  AccountModel acc(
    String id, {
    String? parentId,
    AccountType type = AccountType.assets,
    int balance = 0,
    int sort = 0,
    bool isActive = true,
    String name = 'Account',
  }) {
    return AccountModel(
      id: id,
      name: name,
      type: type,
      balance: balance,
      sort: sort,
      parentId: parentId,
      isActive: isActive,
      createdAt: DateTime.utc(2024, 1, 1),
      updatedAt: DateTime.utc(2024, 1, 1),
    );
  }

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

    test('state equality and activeAggregates', () {
      final active = acc('a1', name: 'Active');
      final inactive = acc('a2', name: 'Inactive', isActive: false);
      final s1 = AccountListState(
        accounts: [active],
        aggregates: [
          AccountAggregate(account: active),
          AccountAggregate(account: inactive),
        ],
      );
      expect(s1.activeAggregates.length, 1);
      expect(s1.activeAggregates.first.account.id, 'a1');

      final s2 = AccountListState(
        accounts: [active],
        aggregates: [
          AccountAggregate(account: active),
          AccountAggregate(account: inactive),
        ],
      );
      expect(s1, s2);
      expect(s1.hashCode, isNotNull);

      final s3 = AccountListState(
        accounts: [active],
        aggregates: [AccountAggregate(account: active)],
      );
      expect(s1 == s3, isFalse);
      expect(identical(s1, s1), isTrue);
    });

    test('deleteAccount calls repository', () async {
      when(() => mockRepo.watchAccounts()).thenAnswer((_) => resultStream(const Success([])));
      when(() => mockRepo.deleteAccount(any())).thenAnswer((_) async => const Success(null));
      final container = createContainer();
      await wait();
      await container.read(accountListProvider.notifier).deleteAccount('a1');
      verify(() => mockRepo.deleteAccount('a1')).called(1);
    });

    test('reorderAccounts at root level', () async {
      final a = acc('a1', sort: 0, name: 'A');
      final b = acc('a2', sort: 1, name: 'B');
      final c = acc('a3', sort: 2, name: 'C');
      when(() => mockRepo.watchAccounts()).thenAnswer((_) => resultStream(Success([a, b, c])));
      when(
        () => mockRepo.reorderAccounts(any(), any(), parentId: any(named: 'parentId')),
      ).thenAnswer((_) async => const Success(null));
      final container = createContainer();
      await wait();

      await container.read(accountListProvider.notifier).reorderAccounts(0, 2);

      final state = container.read(accountListProvider).value!;
      expect(state.aggregates[0].account.id, 'a2');
      expect(state.aggregates[1].account.id, 'a1');
      verify(() => mockRepo.reorderAccounts(0, 2, parentId: null)).called(1);
    });

    test('reorderAccounts within pockets', () async {
      final parent = acc('p0', name: 'Parent');
      final pocketA = acc('pk1', parentId: 'p0', sort: 0);
      final pocketB = acc('pk2', parentId: 'p0', sort: 1);
      when(() => mockRepo.watchAccounts()).thenAnswer((_) => resultStream(Success([parent, pocketA, pocketB])));
      when(
        () => mockRepo.reorderAccounts(any(), any(), parentId: any(named: 'parentId')),
      ).thenAnswer((_) async => const Success(null));
      final container = createContainer();
      await wait();

      await container.read(accountListProvider.notifier).reorderAccounts(0, 2, parentId: 'p0');

      final state = container.read(accountListProvider).value!;
      final parentAgg = state.aggregates.firstWhere((a) => a.account.id == 'p0');
      expect(parentAgg.pockets[0].id, 'pk2');
      expect(parentAgg.pockets[1].id, 'pk1');
      verify(() => mockRepo.reorderAccounts(0, 2, parentId: 'p0')).called(1);
    });

    test('reorderAccounts reverts via invalidateSelf on repo error', () async {
      final a = acc('a1', sort: 0);
      final b = acc('a2', sort: 1);
      when(() => mockRepo.watchAccounts()).thenAnswer((_) => resultStream(Success([a, b])));
      when(
        () => mockRepo.reorderAccounts(any(), any(), parentId: any(named: 'parentId')),
      ).thenAnswer((_) async => const ErrorResult<void, Failure>(DatabaseFailure('fail')));
      final container = createContainer();
      await wait();

      await container.read(accountListProvider.notifier).reorderAccounts(0, 2);
      await wait();

      // After invalidation the stream re-yields original order
      final state = container.read(accountListProvider).value!;
      expect(state.aggregates[0].account.id, 'a1');
      expect(state.aggregates[1].account.id, 'a2');
    });

    test('regularAccountList and goalAccountList split by type', () async {
      final regular = acc('r1', name: 'Cash');
      final goal = acc('g1', type: AccountType.goal, name: 'Trip');
      when(() => mockRepo.watchAccounts()).thenAnswer((_) => resultStream(Success([regular, goal])));
      final container = createContainer();
      await wait();

      final regularList = container.read(regularAccountListProvider).value!;
      expect(regularList.accounts.map((a) => a.id), ['r1']);
      expect(regularList.aggregates.length, 1);

      final goalList = container.read(goalAccountListProvider).value!;
      expect(goalList.accounts.map((a) => a.id), ['g1']);
      expect(goalList.aggregates.length, 1);
    });

    test('accountMetrics computes net worth from accounts', () async {
      final asset = acc('a1', balance: 5000);
      final liability = acc('l1', type: AccountType.liability, balance: -1200);
      when(() => mockRepo.watchAccounts()).thenAnswer((_) => resultStream(Success([asset, liability])));
      final container = createContainer();
      await wait();

      final metrics = container.read(accountMetricsProvider);
      expect(metrics.activeAccountCount, 2);
      expect(metrics.totalAssets, 5000);
      expect(metrics.totalLiabilities, 1200);
      expect(metrics.netWorth, 3800);
    });

    test('accountAggregate returns aggregate for existing account', () async {
      final parent = acc('p0', name: 'Parent');
      final pocket = acc('pk1', parentId: 'p0');
      when(() => mockRepo.watchAccounts()).thenAnswer((_) => resultStream(Success([parent, pocket])));
      final container = createContainer();
      await wait();

      final aggregate = container.read(accountAggregateProvider('p0'));
      expect(aggregate, isNotNull);
      expect(aggregate!.pockets.length, 1);
      expect(aggregate.totalBalance, parent.balance + pocket.balance);

      expect(container.read(accountAggregateProvider('unknown')), isNull);
    });

    test('accountTransactions filters by source or destination account', () async {
      when(() => mockRepo.watchAccounts()).thenAnswer((_) => resultStream(const Success([])));
      TransactionModel tx(String id, String accountId, {String? destination}) => TransactionModel(
        id: id,
        accountId: accountId,
        destinationAccountId: destination,
        type: TransactionType.transfer,
        amount: 100,
        transactionDate: DateTime.utc(2024, 1, 1),
        createdAt: DateTime.utc(2024, 1, 1),
        updatedAt: DateTime.utc(2024, 1, 1),
      );
      final txs = [tx('t1', 'a1'), tx('t2', 'a2', destination: 'a1'), tx('t3', 'a2')];
      when(() => mockTxRepo.watchTransactions()).thenAnswer(
        (_) => Stream.value(Success<List<TransactionModel>, Failure>(txs)).asBroadcastStream(),
      );
      final container = createContainer();
      container.listen(recentTransactionsStreamProvider, (_, __) {});
      await wait();

      final result = container.read(accountTransactionsProvider({'a1'}));
      expect(result.map((t) => t.id).toSet(), {'t1', 't2'});
    });

    test('accountMap indexes accounts by id', () async {
      final a = acc('a1', name: 'One');
      final b = acc('a2', name: 'Two');
      when(() => mockRepo.watchAccounts()).thenAnswer((_) => resultStream(Success([a, b])));
      final container = createContainer();
      container.listen(accountsStreamProvider, (_, __) {});
      await wait();

      final map = container.read(accountMapProvider);
      expect(map.keys.toSet(), {'a1', 'a2'});
      expect(map['a1']!.name, 'One');
    });
  });
}
