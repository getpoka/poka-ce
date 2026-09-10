// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier driving the financial reports tab, calculating metrics dynamically as ledger data mutates.

@ProviderFor(ReportNotifier)
final reportProvider = ReportNotifierProvider._();

/// Notifier driving the financial reports tab, calculating metrics dynamically as ledger data mutates.
final class ReportNotifierProvider extends $NotifierProvider<ReportNotifier, ReportState> {
  /// Notifier driving the financial reports tab, calculating metrics dynamically as ledger data mutates.
  ReportNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportNotifierHash();

  @$internal
  @override
  ReportNotifier create() => ReportNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportState>(value),
    );
  }
}

String _$reportNotifierHash() => r'c55f07b57ed13c4bf6da67594e084e895a1ca326';

/// Notifier driving the financial reports tab, calculating metrics dynamically as ledger data mutates.

abstract class _$ReportNotifier extends $Notifier<ReportState> {
  ReportState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ReportState, ReportState>;
    final element =
        ref.element as $ClassProviderElement<AnyNotifier<ReportState, ReportState>, ReportState, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
