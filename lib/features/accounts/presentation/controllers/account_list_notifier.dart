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

/// Immutable UI state holding raw accounts and their parent-child hierarchical aggregates.
@immutable
class AccountListState {
  /// Creates an [AccountListState].
  const AccountListState({
    this.accounts = const [],
    this.aggregates = const [],
  });

  /// All accounts flatly represented.
  final List<AccountModel> accounts;

  /// Grouped parent accounts paired with their respective pocket sub-wallets.
  final List<AccountAggregate> aggregates;

  /// Filtered view containing only currently active (non-archived) aggregates.
  List<AccountAggregate> get activeAggregates => aggregates.where((a) => a.account.isActive).toList();

  /// Creates a copy of this state with optional updated parameters.
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

/// Riverpod StreamNotifier managing the live stream of accounts and their hierarchical aggregates.
@riverpod
class AccountListNotifier extends _$AccountListNotifier {
  @override
  Stream<AccountListState> build() async* {
    final accountRepo = ref.watch(accountRepositoryProvider);

    await for (final result in accountRepo.watchAccounts()) {
      final accounts = result.fold((s) => s, (f) => <AccountModel>[]);

      // Group parent accounts and their nested pockets into aggregates
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

  /// Deactivates (soft deletes) an account by its unique [id].
  Future<void> deactivateAccount(String id) async {
    final repo = ref.read(accountRepositoryProvider);
    await repo.deactivateAccount(id);
    // No need to manually refresh state: the reactive database stream automatically yields the updated list
  }

  /// Permanently removes an account by its unique [id].
  Future<void> deleteAccount(String id) async {
    final repo = ref.read(accountRepositoryProvider);
    await repo.deleteAccount(id);
  }

  /// Reorders accounts within their group (root accounts or pockets under [parentId]).
  ///
  /// Applies an optimistic state update immediately, reverting via provider invalidation
  /// if the underlying database write fails.
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
      // Revert optimistic changes on failure by invalidating provider to reload from database stream
      ref.invalidateSelf();
    }
  }
}

/// Filters the active account list to exclude goal-linked pocket accounts.
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

/// Filters the active account list to only include goal-linked pocket accounts.
@riverpod
AsyncValue<AccountListState> goalAccountList(Ref ref) {
  final asyncState = ref.watch(accountListProvider);
  return asyncState.whenData((state) {
    final goalAccounts = state.accounts.where((a) => a.type == AccountType.goal).toList();
    final goalAggregates = state.aggregates.where((agg) => agg.account.type == AccountType.goal).toList();

    return AccountListState(
      accounts: goalAccounts,
      aggregates: goalAggregates,
    );
  });
}

/// Record type holding computed metrics for active accounts.
typedef AccountMetricsData = ({int activeAccountCount, double netWorth, double totalAssets, double totalLiabilities});

/// Computes global asset, liability, and net worth metrics across all active accounts.
@riverpod
AccountMetricsData accountMetrics(Ref ref) {
  final accounts = ref.watch(accountListProvider).value?.accounts ?? [];
  return DashboardAnalyticsService.calculateAccountMetrics(accounts);
}

/// Retrieves the [AccountAggregate] (parent account + its nested pockets) for a given [accountId].
@riverpod
AccountAggregate? accountAggregate(Ref ref, String accountId) {
  final state = ref.watch(accountListProvider).value;
  if (state == null) return null;

  final account = state.accounts.where((a) => a.id == accountId).firstOrNull;
  if (account == null) return null;

  final pockets = state.accounts.where((a) => a.parentId == accountId).toList();
  return AccountAggregate(account: account, pockets: pockets);
}

/// Provides a list of transactions involving any of the specified [accountIds] as source or destination.
@riverpod
List<TransactionModel> accountTransactions(Ref ref, Set<String> accountIds) {
  final allTransactions = ref.watch(recentTransactionsStreamProvider).value ?? [];
  return allTransactions
      .where(
        (t) =>
            accountIds.contains(t.accountId) ||
            (t.destinationAccountId != null && accountIds.contains(t.destinationAccountId)),
      )
      .toList();
}

/// Provides an indexed lookup map of accounts by their unique ID string.
@riverpod
Map<String, AccountModel> accountMap(Ref ref) {
  final accounts = ref.watch(accountsStreamProvider).value ?? [];
  return {for (final a in accounts) a.id: a};
}
