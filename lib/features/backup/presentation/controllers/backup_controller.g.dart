// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BackupController)
final backupControllerProvider = BackupControllerProvider._();

final class BackupControllerProvider extends $AsyncNotifierProvider<BackupController, void> {
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

String _$backupControllerHash() => r'038d8f484469501120691bc39e997b38224a60cd';

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
