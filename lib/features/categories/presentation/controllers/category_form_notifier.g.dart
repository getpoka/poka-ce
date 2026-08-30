// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_form_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CategoryFormNotifier)
final categoryFormProvider = CategoryFormNotifierProvider._();

final class CategoryFormNotifierProvider extends $NotifierProvider<CategoryFormNotifier, CategoryFormState> {
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

String _$categoryFormNotifierHash() => r'580beba45a6e72010348a9809afe29a0585cde44';

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
