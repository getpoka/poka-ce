// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller managing the execution of encrypted backup and restore operations,
/// updating its async state and invoking system share sheets.

@ProviderFor(BackupController)
final backupControllerProvider = BackupControllerProvider._();

/// Controller managing the execution of encrypted backup and restore operations,
/// updating its async state and invoking system share sheets.
final class BackupControllerProvider extends $AsyncNotifierProvider<BackupController, void> {
  /// Controller managing the execution of encrypted backup and restore operations,
  /// updating its async state and invoking system share sheets.
  BackupControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backupControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backupControllerHash();

  @$internal
  @override
  BackupController create() => BackupController();
}

String _$backupControllerHash() => r'c33ac93a240f945063edff8f10898d1dd7eb6cb8';

/// Controller managing the execution of encrypted backup and restore operations,
/// updating its async state and invoking system share sheets.

abstract class _$BackupController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element as $ClassProviderElement<AnyNotifier<AsyncValue<void>, void>, AsyncValue<void>, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
