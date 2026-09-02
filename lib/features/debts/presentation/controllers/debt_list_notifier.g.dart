// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DebtList)
final debtListProvider = DebtListProvider._();

final class DebtListProvider
    extends $StreamNotifierProvider<DebtList, List<DebtModel>> {
  DebtListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debtListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debtListHash();

  @$internal
  @override
  DebtList create() => DebtList();
}

String _$debtListHash() => r'54179221aa0922f3635c52bf34ba197004d4f317';

abstract class _$DebtList extends $StreamNotifier<List<DebtModel>> {
  Stream<List<DebtModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<DebtModel>>, List<DebtModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<DebtModel>>, List<DebtModel>>,
              AsyncValue<List<DebtModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
