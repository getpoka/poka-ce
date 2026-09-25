// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_form_sheet_builder_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides an optional [RecurringFormSheetBuilder] override for the recurring form.
///
/// Returns `null` by default — callers fall back to the default [RecurringFormSheet.show].
/// Can be overridden in the root ProviderScope to inject a custom form sheet.

@ProviderFor(recurringFormSheetBuilder)
final recurringFormSheetBuilderProvider = RecurringFormSheetBuilderProvider._();

/// Provides an optional [RecurringFormSheetBuilder] override for the recurring form.
///
/// Returns `null` by default — callers fall back to the default [RecurringFormSheet.show].
/// Can be overridden in the root ProviderScope to inject a custom form sheet.

final class RecurringFormSheetBuilderProvider
    extends $FunctionalProvider<RecurringFormSheetBuilder?, RecurringFormSheetBuilder?, RecurringFormSheetBuilder?>
    with $Provider<RecurringFormSheetBuilder?> {
  /// Provides an optional [RecurringFormSheetBuilder] override for the recurring form.
  ///
  /// Returns `null` by default — callers fall back to the default [RecurringFormSheet.show].
  /// Can be overridden in the root ProviderScope to inject a custom form sheet.
  RecurringFormSheetBuilderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recurringFormSheetBuilderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recurringFormSheetBuilderHash();

  @$internal
  @override
  $ProviderElement<RecurringFormSheetBuilder?> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  RecurringFormSheetBuilder? create(Ref ref) {
    return recurringFormSheetBuilder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecurringFormSheetBuilder? value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<RecurringFormSheetBuilder?>(value));
  }
}

String _$recurringFormSheetBuilderHash() => r'fc0fdf9a296ffe3bbcaba8f46f1d407e7b300ae5';
