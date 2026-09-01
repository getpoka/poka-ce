// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_form_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GoalFormNotifier)
final goalFormProvider = GoalFormNotifierProvider._();

final class GoalFormNotifierProvider extends $NotifierProvider<GoalFormNotifier, GoalFormState> {
  GoalFormNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalFormNotifierHash();

  @$internal
  @override
  GoalFormNotifier create() => GoalFormNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoalFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoalFormState>(value),
    );
  }
}

String _$goalFormNotifierHash() => r'a64fd685f659fd555dd36f0a39cd6bc8a0af2bfb';

abstract class _$GoalFormNotifier extends $Notifier<GoalFormState> {
  GoalFormState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<GoalFormState, GoalFormState>;
    final element =
        ref.element
            as $ClassProviderElement<AnyNotifier<GoalFormState, GoalFormState>, GoalFormState, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
