// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_form_sheet_builder_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides an optional [GoalFormSheetBuilder] override for the goal form.
///
/// In CE, returns `null` — callers fall back to the default [GoalFormSheet.show].
/// Poka PE overrides this in the root [ProviderScope] to inject
/// [PeGoalFormSheet.show], which adds a [CurrencySelectField] for the
/// automatically-generated goal pocket account.

@ProviderFor(goalFormSheetBuilder)
final goalFormSheetBuilderProvider = GoalFormSheetBuilderProvider._();

/// Provides an optional [GoalFormSheetBuilder] override for the goal form.
///
/// In CE, returns `null` — callers fall back to the default [GoalFormSheet.show].
/// Poka PE overrides this in the root [ProviderScope] to inject
/// [PeGoalFormSheet.show], which adds a [CurrencySelectField] for the
/// automatically-generated goal pocket account.

final class GoalFormSheetBuilderProvider
    extends $FunctionalProvider<GoalFormSheetBuilder?, GoalFormSheetBuilder?, GoalFormSheetBuilder?>
    with $Provider<GoalFormSheetBuilder?> {
  /// Provides an optional [GoalFormSheetBuilder] override for the goal form.
  ///
  /// In CE, returns `null` — callers fall back to the default [GoalFormSheet.show].
  /// Poka PE overrides this in the root [ProviderScope] to inject
  /// [PeGoalFormSheet.show], which adds a [CurrencySelectField] for the
  /// automatically-generated goal pocket account.
  GoalFormSheetBuilderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalFormSheetBuilderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalFormSheetBuilderHash();

  @$internal
  @override
  $ProviderElement<GoalFormSheetBuilder?> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  GoalFormSheetBuilder? create(Ref ref) {
    return goalFormSheetBuilder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoalFormSheetBuilder? value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<GoalFormSheetBuilder?>(value));
  }
}

String _$goalFormSheetBuilderHash() => r'd67ebc52825048465ab42b4e88f3c1ff1c6b5d3c';
