import 'dart:ui';

import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/features/backup/data/backup_service.dart';
import 'package:poka_ce/features/backup/domain/backup_reminder_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

part 'backup_controller.g.dart';

/// Controller managing the execution of encrypted backup and restore operations,
/// updating its async state and invoking system share sheets.
@Riverpod(keepAlive: true)
class BackupController extends _$BackupController {
  @override
  FutureOr<void> build() {}

  /// Creates an encrypted backup of the database protected by [password]
  /// and prompts the user to export or share it via the system share sheet.
  ///
  /// Returns `true` if the backup and share succeeded, or `false` on failure.
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
        await ref.read(backupReminderServiceProvider).recordBackupCompleted();
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

  /// Restores database content from the encrypted backup at [filePath]
  /// using the provided decryption [password].
  ///
  /// Returns `true` if decryption and database replacement succeeded.
  Future<bool> restore(String password, String filePath) async {
    state = const AsyncLoading();
    var dbClosed = false;
    try {
      final service = ref.read(backupServiceProvider);
      final result = await service.restoreEncryptedBackup(
        filePath,
        password,
        onBeforeWrite: () async {
          await ref.read(databaseProvider).close();
          dbClosed = true;
        },
      );
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
    } finally {
      if (dbClosed) {
        ref.invalidate(databaseProvider);
      }
    }
  }
}
