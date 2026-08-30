// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RecurringListNotifier)
final recurringListProvider = RecurringListNotifierProvider._();

final class RecurringListNotifierProvider extends $NotifierProvider<RecurringListNotifier, RecurringListState> {
  RecurringListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recurringListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recurringListNotifierHash();

  @$internal
  @override
  RecurringListNotifier create() => RecurringListNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecurringListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecurringListState>(value),
    );
  }
}

String _$recurringListNotifierHash() => r'03eb65b234863f5ab79499257717d7f2f810b084';

abstract class _$RecurringListNotifier extends $Notifier<RecurringListState> {
  RecurringListState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<RecurringListState, RecurringListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RecurringListState, RecurringListState>,
              RecurringListState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
