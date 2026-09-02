// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_quick_actions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the default CE list of quick actions.

@ProviderFor(dashboardQuickActions)
final dashboardQuickActionsProvider = DashboardQuickActionsProvider._();

/// Provides the default CE list of quick actions.

final class DashboardQuickActionsProvider
    extends
        $FunctionalProvider<
          List<DashboardQuickAction>,
          List<DashboardQuickAction>,
          List<DashboardQuickAction>
        >
    with $Provider<List<DashboardQuickAction>> {
  /// Provides the default CE list of quick actions.
  DashboardQuickActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardQuickActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardQuickActionsHash();

  @$internal
  @override
  $ProviderElement<List<DashboardQuickAction>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<DashboardQuickAction> create(Ref ref) {
    return dashboardQuickActions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<DashboardQuickAction> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<DashboardQuickAction>>(value),
    );
  }
}

String _$dashboardQuickActionsHash() =>
    r'41f373143ef314a8dff39007e8f873287877b0bc';
