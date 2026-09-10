// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_form_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier managing budget creation and editing form state and persistence.

@ProviderFor(BudgetFormNotifier)
final budgetFormProvider = BudgetFormNotifierProvider._();

/// Notifier managing budget creation and editing form state and persistence.
final class BudgetFormNotifierProvider extends $NotifierProvider<BudgetFormNotifier, BudgetFormState> {
  /// Notifier managing budget creation and editing form state and persistence.
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

String _$budgetFormNotifierHash() => r'30292d6af8d811432bfebfca813ca7ca14d05b2b';

/// Notifier managing budget creation and editing form state and persistence.

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
