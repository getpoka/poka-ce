// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_list_view_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(goalListView)
final goalListViewProvider = GoalListViewProvider._();

final class GoalListViewProvider
    extends
        $FunctionalProvider<
          GoalListViewState,
          GoalListViewState,
          GoalListViewState
        >
    with $Provider<GoalListViewState> {
  GoalListViewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalListViewProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalListViewHash();

  @$internal
  @override
  $ProviderElement<GoalListViewState> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GoalListViewState create(Ref ref) {
    return goalListView(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoalListViewState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoalListViewState>(value),
    );
  }
}

String _$goalListViewHash() => r'197f4cdf0767aa4afa9c8a77dfc41c4f4de59a10';
