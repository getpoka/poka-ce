// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt_repayment_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier driving the debt/loan repayment sheet and keypad calculator.

@ProviderFor(DebtRepaymentNotifier)
final debtRepaymentProvider = DebtRepaymentNotifierProvider._();

/// Notifier driving the debt/loan repayment sheet and keypad calculator.
final class DebtRepaymentNotifierProvider extends $NotifierProvider<DebtRepaymentNotifier, DebtRepaymentState> {
  /// Notifier driving the debt/loan repayment sheet and keypad calculator.
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
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<DebtRepaymentState>(value));
  }
}

String _$debtRepaymentNotifierHash() => r'6e27d56feb8f14ef3ed1e8221905c3ec25155944';

/// Notifier driving the debt/loan repayment sheet and keypad calculator.

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
