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

String _$categoryListNotifierHash() => r'4828659d34ebb4b849063f6526887bd4c37798ee';

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
