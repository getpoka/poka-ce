import 'package:flutter/foundation.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/accounts/domain/account_aggregate.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/dashboard/domain/services/dashboard_analytics_service.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_list_notifier.g.dart';

@immutable
class AccountListState {
  const AccountListState({
    this.accounts = const [],
    this.aggregates = const [],
  });

  final List<AccountModel> accounts;
  final List<AccountAggregate> aggregates;

  List<AccountAggregate> get activeAggregates => aggregates.where((a) => a.account.isActive).toList();

  AccountListState copyWith({
    List<AccountModel>? accounts,
    List<AccountAggregate>? aggregates,
  }) {
    return AccountListState(
      accounts: accounts ?? this.accounts,
      aggregates: aggregates ?? this.aggregates,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AccountListState &&
        listEquals(other.accounts, accounts) &&
        listEquals(other.aggregates, aggregates);
  }

  @override
  int get hashCode => accounts.hashCode ^ aggregates.hashCode;
}

@riverpod
class AccountListNotifier extends _$AccountListNotifier {
  @override
  Stream<AccountListState> build() async* {
    final accountRepo = ref.watch(accountRepositoryProvider);

    await for (final result in accountRepo.watchAccounts()) {
      final accounts = result.fold((s) => s, (f) => <AccountModel>[]);

      // Group into aggregates
      final aggregates = <AccountAggregate>[];
      final parentAccounts = accounts.where((a) => !a.isPocket).toList()..sort((a, b) => a.sort.compareTo(b.sort));
      for (final parent in parentAccounts) {
        final pockets = accounts.where((a) => a.parentId == parent.id).toList()
          ..sort((a, b) => a.sort.compareTo(b.sort));
        aggregates.add(AccountAggregate(account: parent, pockets: pockets));
      }

      yield AccountListState(accounts: accounts, aggregates: aggregates);
    }
  }

  Future<void> deactivateAccount(String id) async {
    final repo = ref.read(accountRepositoryProvider);
    await repo.deactivateAccount(id);
    // No need to refresh, the stream will yield the new state
  }

  Future<void> deleteAccount(String id) async {
    final repo = ref.read(accountRepositoryProvider);
    await repo.deleteAccount(id);
  }

  Future<void> reorderAccounts(int oldIndex, int newIndex, {String? parentId}) async {
    // Optimistic UI update
    var safeNewIndex = newIndex;
    if (oldIndex < safeNewIndex) safeNewIndex -= 1;

    final currentState = state.value;
    if (currentState == null) return;

    if (parentId == null) {
      final newAggs = List<AccountAggregate>.from(currentState.aggregates);
      final item = newAggs.removeAt(oldIndex);
      newAggs.insert(safeNewIndex, item);
      state = AsyncData(currentState.copyWith(aggregates: newAggs));
    } else {
      final newAggs = List<AccountAggregate>.from(currentState.aggregates);
      final parentIndex = newAggs.indexWhere((a) => a.account.id == parentId);
      if (parentIndex != -1) {
        final parentAgg = newAggs[parentIndex];
        final newPockets = List<AccountModel>.from(parentAgg.pockets);
        final item = newPockets.removeAt(oldIndex);
        newPockets.insert(safeNewIndex, item);
        newAggs[parentIndex] = parentAgg.copyWith(pockets: newPockets);
        state = AsyncData(currentState.copyWith(aggregates: newAggs));
      }
    }

    final repo = ref.read(accountRepositoryProvider);
    final result = await repo.reorderAccounts(oldIndex, newIndex, parentId: parentId);
    if (result is ErrorResult) {
      // Revert on error by invalidating provider so it refetches from stream
      ref.invalidateSelf();
    }
  }
}

@riverpod
AsyncValue<AccountListState> regularAccountList(Ref ref) {
  final asyncState = ref.watch(accountListProvider);
  return asyncState.whenData((state) {
    final regularAccounts = state.accounts.where((a) => a.type != AccountType.goal).toList();
    final regularAggregates = state.aggregates.where((agg) => agg.account.type != AccountType.goal).toList();

    return AccountListState(
      accounts: regularAccounts,
      aggregates: regularAggregates,
    );
  });
}

typedef AccountMetricsData = ({int activeAccountCount, double netWorth, double totalAssets, double totalLiabilities});

@riverpod
AccountMetricsData accountMetrics(Ref ref) {
  final accounts = ref.watch(accountListProvider).value?.accounts ?? [];
  return DashboardAnalyticsService.calculateAccountMetrics(accounts);
}

@riverpod
AccountAggregate? accountAggregate(Ref ref, String accountId) {
  final state = ref.watch(accountListProvider).value;
  if (state == null) return null;

  final account = state.accounts.where((a) => a.id == accountId).firstOrNull;
  if (account == null) return null;

  final pockets = state.accounts.where((a) => a.parentId == accountId).toList();
  return AccountAggregate(account: account, pockets: pockets);
}

@riverpod
List<TransactionModel> accountTransactions(Ref ref, Set<String> accountIds) {
  final allTransactions = ref.watch(recentTransactionsStreamProvider).value ?? [];
  return allTransactions.where((t) => accountIds.contains(t.accountId)).toList();
}
