// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt_form_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DebtForm)
final debtFormProvider = DebtFormProvider._();

final class DebtFormProvider extends $NotifierProvider<DebtForm, DebtFormState> {
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

String _$debtFormHash() => r'a8a1ed53f779c340fcc0696ffce1efef1dfb94e3';

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
