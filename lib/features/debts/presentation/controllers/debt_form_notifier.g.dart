// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt_form_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier managing input state and validation for creating or editing debts and loans.

@ProviderFor(DebtForm)
final debtFormProvider = DebtFormProvider._();

/// Notifier managing input state and validation for creating or editing debts and loans.
final class DebtFormProvider extends $NotifierProvider<DebtForm, DebtFormState> {
  /// Notifier managing input state and validation for creating or editing debts and loans.
  DebtFormProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debtFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debtFormHash();

  @$internal
  @override
  DebtForm create() => DebtForm();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DebtFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DebtFormState>(value),
    );
  }
}

String _$debtFormHash() => r'1828e33699d2caf544339fca61351a4772c33608';

/// Notifier managing input state and validation for creating or editing debts and loans.

abstract class _$DebtForm extends $Notifier<DebtFormState> {
  DebtFormState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DebtFormState, DebtFormState>;
    final element =
        ref.element
            as $ClassProviderElement<AnyNotifier<DebtFormState, DebtFormState>, DebtFormState, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
