// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_form_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BackupFormNotifier)
final backupFormProvider = BackupFormNotifierProvider._();

final class BackupFormNotifierProvider
    extends $NotifierProvider<BackupFormNotifier, BackupFormState> {
  BackupFormNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backupFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backupFormNotifierHash();

  @$internal
  @override
  BackupFormNotifier create() => BackupFormNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackupFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackupFormState>(value),
    );
  }
}

String _$backupFormNotifierHash() =>
    r'a3d9e038571e6a92fa484b62d5a4712796fb9b04';

abstract class _$BackupFormNotifier extends $Notifier<BackupFormState> {
  BackupFormState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<BackupFormState, BackupFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BackupFormState, BackupFormState>,
              BackupFormState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
