// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// StreamNotifier managing the reactive list of savings goals.

@ProviderFor(GoalNotifier)
final goalProvider = GoalNotifierProvider._();

/// StreamNotifier managing the reactive list of savings goals.
final class GoalNotifierProvider extends $StreamNotifierProvider<GoalNotifier, List<GoalModel>> {
  /// StreamNotifier managing the reactive list of savings goals.
  GoalNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalNotifierHash();

  @$internal
  @override
  GoalNotifier create() => GoalNotifier();
}

String _$goalNotifierHash() => r'0bfe8c00e771a27bc6ee4b90601871021195fb78';

/// StreamNotifier managing the reactive list of savings goals.

abstract class _$GoalNotifier extends $StreamNotifier<List<GoalModel>> {
  Stream<List<GoalModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<GoalModel>>, List<GoalModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<GoalModel>>, List<GoalModel>>,
              AsyncValue<List<GoalModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Provides a list of [GoalItemState] objects by joining goals with pocket account balances.

@ProviderFor(goalListStates)
final goalListStatesProvider = GoalListStatesProvider._();

/// Provides a list of [GoalItemState] objects by joining goals with pocket account balances.

final class GoalListStatesProvider
    extends $FunctionalProvider<List<GoalItemState>, List<GoalItemState>, List<GoalItemState>>
    with $Provider<List<GoalItemState>> {
  /// Provides a list of [GoalItemState] objects by joining goals with pocket account balances.
  GoalListStatesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalListStatesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalListStatesHash();

  @$internal
  @override
  $ProviderElement<List<GoalItemState>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<GoalItemState> create(Ref ref) {
    return goalListStates(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<GoalItemState> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<GoalItemState>>(value),
    );
  }
}

String _$goalListStatesHash() => r'eea5a1f6624e353431c3d3f480a2fc8dab1b8863';

/// Computes cumulative progress and target aggregates across all active goals.

@ProviderFor(goalSummary)
final goalSummaryProvider = GoalSummaryProvider._();

/// Computes cumulative progress and target aggregates across all active goals.

final class GoalSummaryProvider extends $FunctionalProvider<GoalSummaryState, GoalSummaryState, GoalSummaryState>
    with $Provider<GoalSummaryState> {
  /// Computes cumulative progress and target aggregates across all active goals.
  GoalSummaryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalSummaryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalSummaryHash();

  @$internal
  @override
  $ProviderElement<GoalSummaryState> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  GoalSummaryState create(Ref ref) {
    return goalSummary(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoalSummaryState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoalSummaryState>(value),
    );
  }
}

String _$goalSummaryHash() => r'0c1ac9fd2a25660c40d515e41ef31c262eaba542';
