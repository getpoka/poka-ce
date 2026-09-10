// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier managing recurring transaction schedules, deletion, and pause/resume toggling.

@ProviderFor(RecurringListNotifier)
final recurringListProvider = RecurringListNotifierProvider._();

/// Notifier managing recurring transaction schedules, deletion, and pause/resume toggling.
final class RecurringListNotifierProvider extends $NotifierProvider<RecurringListNotifier, RecurringListState> {
  /// Notifier managing recurring transaction schedules, deletion, and pause/resume toggling.
  RecurringListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recurringListProvider',
        isAutoDispose: false,
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

String _$recurringListNotifierHash() => r'6fdaf42eb6b2baf8104e97a4b7c9a81ada42d012';

/// Notifier managing recurring transaction schedules, deletion, and pause/resume toggling.

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
