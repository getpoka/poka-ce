// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CategoryListNotifier)
final categoryListProvider = CategoryListNotifierProvider._();

final class CategoryListNotifierProvider extends $AsyncNotifierProvider<CategoryListNotifier, List<CategoryModel>> {
  CategoryListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoryListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoryListNotifierHash();

  @$internal
  @override
  CategoryListNotifier create() => CategoryListNotifier();
}

String _$categoryListNotifierHash() => r'9808309d774dc75ab01b61f68bcd9d62ed973d29';

abstract class _$CategoryListNotifier extends $AsyncNotifier<List<CategoryModel>> {
  FutureOr<List<CategoryModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<CategoryModel>>, List<CategoryModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<CategoryModel>>, List<CategoryModel>>,
              AsyncValue<List<CategoryModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(categoryMap)
final categoryMapProvider = CategoryMapProvider._();

final class CategoryMapProvider
    extends $FunctionalProvider<Map<String, CategoryModel>, Map<String, CategoryModel>, Map<String, CategoryModel>>
    with $Provider<Map<String, CategoryModel>> {
  CategoryMapProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoryMapProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoryMapHash();

  @$internal
  @override
  $ProviderElement<Map<String, CategoryModel>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<String, CategoryModel> create(Ref ref) {
    return categoryMap(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, CategoryModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, CategoryModel>>(value),
    );
  }
}

String _$categoryMapHash() => r'fdbfc6f7d461681510793534582e4f3ea2defbdf';
