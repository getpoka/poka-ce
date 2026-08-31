// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_form_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier for the category creation and editing form.
/// Manages form state, validation (e.g., empty name), and orchestrates save operations.

@ProviderFor(CategoryFormNotifier)
final categoryFormProvider = CategoryFormNotifierProvider._();

/// Notifier for the category creation and editing form.
/// Manages form state, validation (e.g., empty name), and orchestrates save operations.
final class CategoryFormNotifierProvider extends $NotifierProvider<CategoryFormNotifier, CategoryFormState> {
  /// Notifier for the category creation and editing form.
  /// Manages form state, validation (e.g., empty name), and orchestrates save operations.
  CategoryFormNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoryFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoryFormNotifierHash();

  @$internal
  @override
  CategoryFormNotifier create() => CategoryFormNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CategoryFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CategoryFormState>(value),
    );
  }
}

String _$categoryFormNotifierHash() => r'21797f677e8b00fca4782fc6b22722d14cf847d1';

/// Notifier for the category creation and editing form.
/// Manages form state, validation (e.g., empty name), and orchestrates save operations.

abstract class _$CategoryFormNotifier extends $Notifier<CategoryFormState> {
  CategoryFormState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CategoryFormState, CategoryFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CategoryFormState, CategoryFormState>,
              CategoryFormState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
