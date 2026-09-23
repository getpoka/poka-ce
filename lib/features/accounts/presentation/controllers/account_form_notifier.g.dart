// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_form_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier managing account creation and editing form state and validation logic.

@ProviderFor(AccountFormNotifier)
final accountFormProvider = AccountFormNotifierProvider._();

/// Notifier managing account creation and editing form state and validation logic.
final class AccountFormNotifierProvider extends $NotifierProvider<AccountFormNotifier, AccountFormState> {
  /// Notifier managing account creation and editing form state and validation logic.
  AccountFormNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountFormNotifierHash();

  @$internal
  @override
  AccountFormNotifier create() => AccountFormNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AccountFormState value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<AccountFormState>(value));
  }
}

String _$accountFormNotifierHash() => r'3d6ba1b553806284ec5de71465030d87587aa731';

/// Notifier managing account creation and editing form state and validation logic.

abstract class _$AccountFormNotifier extends $Notifier<AccountFormState> {
  AccountFormState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AccountFormState, AccountFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AccountFormState, AccountFormState>,
              AccountFormState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
