// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AccountListNotifier)
final accountListProvider = AccountListNotifierProvider._();

final class AccountListNotifierProvider extends $StreamNotifierProvider<AccountListNotifier, AccountListState> {
  AccountListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountListNotifierHash();

  @$internal
  @override
  AccountListNotifier create() => AccountListNotifier();
}

String _$accountListNotifierHash() => r'39ef2379c54b16dbcd706c33ac33211889a23236';

abstract class _$AccountListNotifier extends $StreamNotifier<AccountListState> {
  Stream<AccountListState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AccountListState>, AccountListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AccountListState>, AccountListState>,
              AsyncValue<AccountListState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(regularAccountList)
final regularAccountListProvider = RegularAccountListProvider._();

final class RegularAccountListProvider
    extends
        $FunctionalProvider<AsyncValue<AccountListState>, AsyncValue<AccountListState>, AsyncValue<AccountListState>>
    with $Provider<AsyncValue<AccountListState>> {
  RegularAccountListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'regularAccountListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$regularAccountListHash();

  @$internal
  @override
  $ProviderElement<AsyncValue<AccountListState>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AsyncValue<AccountListState> create(Ref ref) {
    return regularAccountList(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<AccountListState> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<AccountListState>>(value),
    );
  }
}

String _$regularAccountListHash() => r'a1d5868b05d5cb390b45e5d863967ac96c356cca';

@ProviderFor(goalAccountList)
final goalAccountListProvider = GoalAccountListProvider._();

final class GoalAccountListProvider
    extends
        $FunctionalProvider<AsyncValue<AccountListState>, AsyncValue<AccountListState>, AsyncValue<AccountListState>>
    with $Provider<AsyncValue<AccountListState>> {
  GoalAccountListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalAccountListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalAccountListHash();

  @$internal
  @override
  $ProviderElement<AsyncValue<AccountListState>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AsyncValue<AccountListState> create(Ref ref) {
    return goalAccountList(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<AccountListState> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<AccountListState>>(value),
    );
  }
}

String _$goalAccountListHash() => r'a318c0b1226ac8a03293de388b06e5d6e06c358c';

@ProviderFor(accountMetrics)
final accountMetricsProvider = AccountMetricsProvider._();

final class AccountMetricsProvider
    extends $FunctionalProvider<AccountMetricsData, AccountMetricsData, AccountMetricsData>
    with $Provider<AccountMetricsData> {
  AccountMetricsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountMetricsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountMetricsHash();

  @$internal
  @override
  $ProviderElement<AccountMetricsData> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AccountMetricsData create(Ref ref) {
    return accountMetrics(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AccountMetricsData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AccountMetricsData>(value),
    );
  }
}

String _$accountMetricsHash() => r'b99b90e64c5d1cdf47707d5726e89c662c4375b4';

@ProviderFor(accountAggregate)
final accountAggregateProvider = AccountAggregateFamily._();

final class AccountAggregateProvider
    extends $FunctionalProvider<AccountAggregate?, AccountAggregate?, AccountAggregate?>
    with $Provider<AccountAggregate?> {
  AccountAggregateProvider._({
    required AccountAggregateFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'accountAggregateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$accountAggregateHash();

  @override
  String toString() {
    return r'accountAggregateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<AccountAggregate?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AccountAggregate? create(Ref ref) {
    final argument = this.argument as String;
    return accountAggregate(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AccountAggregate? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AccountAggregate?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AccountAggregateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$accountAggregateHash() => r'5aff591642a0874d8915f55cde24a8e8463bdd19';

final class AccountAggregateFamily extends $Family with $FunctionalFamilyOverride<AccountAggregate?, String> {
  AccountAggregateFamily._()
    : super(
        retry: null,
        name: r'accountAggregateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AccountAggregateProvider call(String accountId) => AccountAggregateProvider._(argument: accountId, from: this);

  @override
  String toString() => r'accountAggregateProvider';
}

@ProviderFor(accountTransactions)
final accountTransactionsProvider = AccountTransactionsFamily._();

final class AccountTransactionsProvider
    extends $FunctionalProvider<List<TransactionModel>, List<TransactionModel>, List<TransactionModel>>
    with $Provider<List<TransactionModel>> {
  AccountTransactionsProvider._({
    required AccountTransactionsFamily super.from,
    required Set<String> super.argument,
  }) : super(
         retry: null,
         name: r'accountTransactionsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$accountTransactionsHash();

  @override
  String toString() {
    return r'accountTransactionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<TransactionModel>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<TransactionModel> create(Ref ref) {
    final argument = this.argument as Set<String>;
    return accountTransactions(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TransactionModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TransactionModel>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AccountTransactionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$accountTransactionsHash() => r'96c9e099e9d4d0211ac2fdca490e0374bb393a65';

final class AccountTransactionsFamily extends $Family
    with $FunctionalFamilyOverride<List<TransactionModel>, Set<String>> {
  AccountTransactionsFamily._()
    : super(
        retry: null,
        name: r'accountTransactionsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AccountTransactionsProvider call(Set<String> accountIds) =>
      AccountTransactionsProvider._(argument: accountIds, from: this);

  @override
  String toString() => r'accountTransactionsProvider';
}

@ProviderFor(accountMap)
final accountMapProvider = AccountMapProvider._();

final class AccountMapProvider
    extends $FunctionalProvider<Map<String, AccountModel>, Map<String, AccountModel>, Map<String, AccountModel>>
    with $Provider<Map<String, AccountModel>> {
  AccountMapProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountMapProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountMapHash();

  @$internal
  @override
  $ProviderElement<Map<String, AccountModel>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<String, AccountModel> create(Ref ref) {
    return accountMap(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, AccountModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, AccountModel>>(value),
    );
  }
}

String _$accountMapHash() => r'8242408973b46bcbd3d0efdc2c9ca94b051efae5';
