// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_form_sheet_builder_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides an optional [BudgetFormSheetBuilder] override for the budget form.
///
/// Returns `null` by default — callers fall back to the default [BudgetFormSheet.show].
/// Can be overridden in the root ProviderScope to inject a custom form sheet.

@ProviderFor(budgetFormSheetBuilder)
final budgetFormSheetBuilderProvider = BudgetFormSheetBuilderProvider._();

/// Provides an optional [BudgetFormSheetBuilder] override for the budget form.
///
/// Returns `null` by default — callers fall back to the default [BudgetFormSheet.show].
/// Can be overridden in the root ProviderScope to inject a custom form sheet.

final class BudgetFormSheetBuilderProvider
    extends $FunctionalProvider<BudgetFormSheetBuilder?, BudgetFormSheetBuilder?, BudgetFormSheetBuilder?>
    with $Provider<BudgetFormSheetBuilder?> {
  /// Provides an optional [BudgetFormSheetBuilder] override for the budget form.
  ///
  /// Returns `null` by default — callers fall back to the default [BudgetFormSheet.show].
  /// Can be overridden in the root ProviderScope to inject a custom form sheet.
  BudgetFormSheetBuilderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'budgetFormSheetBuilderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$budgetFormSheetBuilderHash();

  @$internal
  @override
  $ProviderElement<BudgetFormSheetBuilder?> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  BudgetFormSheetBuilder? create(Ref ref) {
    return budgetFormSheetBuilder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BudgetFormSheetBuilder? value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<BudgetFormSheetBuilder?>(value));
  }
}

String _$budgetFormSheetBuilderHash() => r'ba91c702078b58c3cd143e09e303cd1b8c9b1889';
