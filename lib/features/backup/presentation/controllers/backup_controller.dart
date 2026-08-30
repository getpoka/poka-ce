import 'dart:ui';

import 'package:poka_ce/features/backup/data/backup_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

part 'backup_controller.g.dart';

@Riverpod(keepAlive: true)
class BackupController extends _$BackupController {
  @override
  FutureOr<void> build() {}

  Future<bool> backup(String password, {Rect? sharePositionOrigin}) async {
    state = const AsyncLoading();
    try {
      final service = ref.read(backupServiceProvider);
      final result = await service.createEncryptedBackup(password);
      if (result.isSuccess()) {
        final backupFile = result.getOrThrow();
        // We use Share.shareXFiles for stability but package structure causes this lint
        // ignore: deprecated_member_use
        await Share.shareXFiles(
          [XFile(backupFile.path, mimeType: 'application/octet-stream')],
          sharePositionOrigin: sharePositionOrigin != null
              ? Rect.fromCenter(center: sharePositionOrigin.center, width: 1, height: 1)
              : null,
        );
        state = const AsyncData(null);
        return true;
      } else {
        state = AsyncError(
          result.exceptionOrNull() ?? Exception('Unknown error'),
          StackTrace.current,
        );
        return false;
      }
    } on Object catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }

  Future<bool> restore(String password, String filePath) async {
    state = const AsyncLoading();
    try {
      final service = ref.read(backupServiceProvider);
      final result = await service.restoreEncryptedBackup(filePath, password);
      if (result.isSuccess()) {
        state = const AsyncData(null);
        return true;
      } else {
        state = AsyncError(
          result.exceptionOrNull() ?? Exception('Unknown error'),
          StackTrace.current,
        );
        return false;
      }
    } on Object catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }
}
