// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt_repayment_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DebtRepaymentNotifier)
final debtRepaymentProvider = DebtRepaymentNotifierProvider._();

final class DebtRepaymentNotifierProvider extends $NotifierProvider<DebtRepaymentNotifier, DebtRepaymentState> {
  DebtRepaymentNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debtRepaymentProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debtRepaymentNotifierHash();

  @$internal
  @override
  DebtRepaymentNotifier create() => DebtRepaymentNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DebtRepaymentState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DebtRepaymentState>(value),
    );
  }
}

String _$debtRepaymentNotifierHash() => r'0238a61b8f9f7049089d5030eb297b1255aa4117';

abstract class _$DebtRepaymentNotifier extends $Notifier<DebtRepaymentState> {
  DebtRepaymentState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DebtRepaymentState, DebtRepaymentState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DebtRepaymentState, DebtRepaymentState>,
              DebtRepaymentState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
