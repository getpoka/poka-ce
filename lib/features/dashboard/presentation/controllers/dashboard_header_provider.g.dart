// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_header_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides a custom header builder for the Dashboard.
///
/// By default (in CE), this returns null, meaning the default CE header is used.
/// Poka PE overrides this to inject a custom header (e.g., with avatar and greeting).

@ProviderFor(dashboardHeaderBuilder)
final dashboardHeaderBuilderProvider = DashboardHeaderBuilderProvider._();

/// Provides a custom header builder for the Dashboard.
///
/// By default (in CE), this returns null, meaning the default CE header is used.
/// Poka PE overrides this to inject a custom header (e.g., with avatar and greeting).

final class DashboardHeaderBuilderProvider
    extends
        $FunctionalProvider<
          DashboardHeaderBuilder?,
          DashboardHeaderBuilder?,
          DashboardHeaderBuilder?
        >
    with $Provider<DashboardHeaderBuilder?> {
  /// Provides a custom header builder for the Dashboard.
  ///
  /// By default (in CE), this returns null, meaning the default CE header is used.
  /// Poka PE overrides this to inject a custom header (e.g., with avatar and greeting).
  DashboardHeaderBuilderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardHeaderBuilderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardHeaderBuilderHash();

  @$internal
  @override
  $ProviderElement<DashboardHeaderBuilder?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DashboardHeaderBuilder? create(Ref ref) {
    return dashboardHeaderBuilder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DashboardHeaderBuilder? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DashboardHeaderBuilder?>(value),
    );
  }
}

String _$dashboardHeaderBuilderHash() =>
    r'690318f16b9fd65b68a62ed6fe911611ec20dcd9';
