// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReportNotifier)
final reportProvider = ReportNotifierProvider._();

final class ReportNotifierProvider extends $NotifierProvider<ReportNotifier, ReportState> {
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

String _$reportNotifierHash() => r'34a74f20a085410789ba6e0945a14ab143f38490';

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
