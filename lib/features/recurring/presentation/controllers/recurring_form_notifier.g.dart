// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_form_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RecurringFormNotifier)
final recurringFormProvider = RecurringFormNotifierProvider._();

final class RecurringFormNotifierProvider extends $NotifierProvider<RecurringFormNotifier, RecurringFormState> {
  RecurringFormNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recurringFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recurringFormNotifierHash();

  @$internal
  @override
  RecurringFormNotifier create() => RecurringFormNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecurringFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecurringFormState>(value),
    );
  }
}

String _$recurringFormNotifierHash() => r'6987359b58f026a5192ed5235fc0194c583dbdd9';

abstract class _$RecurringFormNotifier extends $Notifier<RecurringFormState> {
  RecurringFormState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<RecurringFormState, RecurringFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RecurringFormState, RecurringFormState>,
              RecurringFormState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
