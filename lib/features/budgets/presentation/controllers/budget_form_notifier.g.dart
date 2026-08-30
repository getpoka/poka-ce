// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_form_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BudgetFormNotifier)
final budgetFormProvider = BudgetFormNotifierProvider._();

final class BudgetFormNotifierProvider extends $NotifierProvider<BudgetFormNotifier, BudgetFormState> {
  BudgetFormNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'budgetFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$budgetFormNotifierHash();

  @$internal
  @override
  BudgetFormNotifier create() => BudgetFormNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BudgetFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BudgetFormState>(value),
    );
  }
}

String _$budgetFormNotifierHash() => r'955a9813cf15f1089edee20999e4204acfda67ea';

abstract class _$BudgetFormNotifier extends $Notifier<BudgetFormState> {
  BudgetFormState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<BudgetFormState, BudgetFormState>;
    final element =
        ref.element
            as $ClassProviderElement<AnyNotifier<BudgetFormState, BudgetFormState>, BudgetFormState, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
