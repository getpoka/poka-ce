// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt_form_sheet_builder_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides an optional [DebtFormSheetBuilder] override for the debt form.
///
/// Returns `null` by default — callers fall back to the default [DebtFormSheet.show].
/// Can be overridden in the root ProviderScope to inject a custom form sheet.

@ProviderFor(debtFormSheetBuilder)
final debtFormSheetBuilderProvider = DebtFormSheetBuilderProvider._();

/// Provides an optional [DebtFormSheetBuilder] override for the debt form.
///
/// Returns `null` by default — callers fall back to the default [DebtFormSheet.show].
/// Can be overridden in the root ProviderScope to inject a custom form sheet.

final class DebtFormSheetBuilderProvider
    extends $FunctionalProvider<DebtFormSheetBuilder?, DebtFormSheetBuilder?, DebtFormSheetBuilder?>
    with $Provider<DebtFormSheetBuilder?> {
  /// Provides an optional [DebtFormSheetBuilder] override for the debt form.
  ///
  /// Returns `null` by default — callers fall back to the default [DebtFormSheet.show].
  /// Can be overridden in the root ProviderScope to inject a custom form sheet.
  DebtFormSheetBuilderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debtFormSheetBuilderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debtFormSheetBuilderHash();

  @$internal
  @override
  $ProviderElement<DebtFormSheetBuilder?> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  DebtFormSheetBuilder? create(Ref ref) {
    return debtFormSheetBuilder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DebtFormSheetBuilder? value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<DebtFormSheetBuilder?>(value));
  }
}

String _$debtFormSheetBuilderHash() => r'8478986d7d90843594b7fecd4025921e189ede0b';
