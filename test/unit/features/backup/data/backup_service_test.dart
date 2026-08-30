import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:poka_ce/features/backup/data/backup_service.dart';

/// Fake path provider that returns controlled temp directories.
class FakePathProviderPlatform extends PathProviderPlatform with MockPlatformInterfaceMixin {
  FakePathProviderPlatform(this.appDocsPath, this.tempPath);

  final String appDocsPath;
  final String tempPath;

  @override
  Future<String?> getApplicationDocumentsPath() async => appDocsPath;

  @override
  Future<String?> getApplicationSupportPath() async => appDocsPath;

  @override
  Future<String?> getTemporaryPath() async => tempPath;
}

/// Platform that throws to exercise catch branch.
class ThrowingPathProviderPlatform extends PathProviderPlatform with MockPlatformInterfaceMixin {
  @override
  Future<String?> getApplicationDocumentsPath() async => throw Exception('boom');

  @override
  Future<String?> getApplicationSupportPath() async => throw Exception('boom');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('BackupService', () {
    late Directory appDocsDir;
    late Directory tempDir;
    late BackupService service;
    late PathProviderPlatform originalPlatform;

    setUp(() async {
      originalPlatform = PathProviderPlatform.instance;
      appDocsDir = await Directory.systemTemp.createTemp('poka_app_docs_');
      tempDir = await Directory.systemTemp.createTemp('poka_temp_');
      PathProviderPlatform.instance = FakePathProviderPlatform(appDocsDir.path, tempDir.path);
      service = BackupService();
    });

    tearDown(() async {
      PathProviderPlatform.instance = originalPlatform;
      if (await appDocsDir.exists()) {
        await appDocsDir.delete(recursive: true);
      }
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    Future<File> createFakeDb({String content = 'hello poka db content'}) async {
      final dbFile = File(p.join(appDocsDir.path, service.dbName));
      await dbFile.writeAsString(content);
      return dbFile;
    }

    test('createEncryptedBackup — happy path creates file with correct binary format', () async {
      final dbFile = await createFakeDb(content: 'original-bytes-123');
      final originalBytes = await dbFile.readAsBytes();

      final result = await service.createEncryptedBackup('mySecret123');

      expect(result.isSuccess(), isTrue);
      final backupFile = result.getOrThrow();
      expect(await backupFile.exists(), isTrue);

      final bytes = await backupFile.readAsBytes();
      // Format: [salt(12)][nonce(12)][mac(16)][cipherText(N)]
      expect(bytes.length, greaterThan(40));
      // Salt + nonce + mac are 40 bytes, remainder is ciphertext (should be >= original length, but at least >0)
      expect(bytes.length, greaterThanOrEqualTo(40 + 1));

      // Verify we can manually extract prefix lengths
      final salt = bytes.sublist(0, 12);
      final nonce = bytes.sublist(12, 24);
      final mac = bytes.sublist(24, 40);
      final cipherText = bytes.sublist(40);

      expect(salt.length, 12);
      expect(nonce.length, 12);
      expect(mac.length, 16);
      expect(cipherText.length, greaterThan(0));

      // Filename pattern: poka-YYYYMMDD-HHmmss.sqlite
      expect(p.basename(backupFile.path), matches(RegExp(r'^poka-\d{8}-\d{6}\.sqlite$')));

      // Ensure original DB unchanged
      final afterBytes = await dbFile.readAsBytes();
      expect(afterBytes, equals(originalBytes));
    });

    test('createEncryptedBackup — DB file not found returns Failure', () async {
      // Do not create DB file
      final result = await service.createEncryptedBackup('pass');
      expect(result.isSuccess(), isFalse);
      expect(result.exceptionOrNull(), isA<Exception>());
      expect(result.exceptionOrNull().toString(), contains('Database file not found'));
    });

    test('createEncryptedBackup — wrong password used to decrypt fails', () async {
      await createFakeDb(content: 'secret data for wrong pass');
      final result = await service.createEncryptedBackup('correctPassword');
      expect(result.isSuccess(), isTrue);
      final backupFile = result.getOrThrow();

      // Try to restore with wrong password — should fail
      final restore = await service.restoreEncryptedBackup(backupFile.path, 'wrongPassword');
      expect(restore.isSuccess(), isFalse);
      expect(restore.exceptionOrNull().toString(), contains('Invalid password'));
    });

    test('round-trip: encrypt -> decrypt -> original bytes match', () async {
      const original = 'round-trip-content-💰-with-unicode-12345';
      final dbFile = await createFakeDb(content: original);
      final originalBytes = await dbFile.readAsBytes();

      final enc = await service.createEncryptedBackup('roundTripPass');
      expect(enc.isSuccess(), isTrue);
      final backupFile = enc.getOrThrow();

      // Change DB content to ensure restore overwrites
      await dbFile.writeAsString('corrupted');

      final dec = await service.restoreEncryptedBackup(backupFile.path, 'roundTripPass');
      expect(dec.isSuccess(), isTrue);

      final restoredBytes = await dbFile.readAsBytes();
      expect(restoredBytes, equals(originalBytes));
      expect(await dbFile.readAsString(), equals(original));
    });

    test('restoreEncryptedBackup — backup file not found returns Failure', () async {
      final fakePath = p.join(tempDir.path, 'nonexistent.enc.db');
      final result = await service.restoreEncryptedBackup(fakePath, 'pass');
      expect(result.isSuccess(), isFalse);
      expect(result.exceptionOrNull().toString(), contains('Backup file not found'));
    });

    test('restoreEncryptedBackup — file too short (<40 bytes) returns Failure', () async {
      final shortFile = File(p.join(tempDir.path, 'short.enc.db'));
      await shortFile.writeAsBytes(List<int>.filled(10, 0));
      final result = await service.restoreEncryptedBackup(shortFile.path, 'pass');
      expect(result.isSuccess(), isFalse);
      expect(result.exceptionOrNull().toString(), contains('Invalid backup file format'));

      // Also test exactly 39 bytes
      final file39 = File(p.join(tempDir.path, 'short39.enc.db'));
      await file39.writeAsBytes(List<int>.filled(39, 1));
      final r2 = await service.restoreEncryptedBackup(file39.path, 'pass');
      expect(r2.isSuccess(), isFalse);
    });

    test('restoreEncryptedBackup — wrong password returns Failure (MAC verification fails)', () async {
      await createFakeDb(content: 'some-db-bytes');
      final enc = await service.createEncryptedBackup('goodPass123');
      expect(enc.isSuccess(), isTrue);
      final backupFile = enc.getOrThrow();

      final bad = await service.restoreEncryptedBackup(backupFile.path, 'badPass123');
      expect(bad.isSuccess(), isFalse);
      expect(bad.exceptionOrNull().toString(), contains('Invalid password'));
    });

    test('restoreEncryptedBackup — happy path decrypted bytes written to DB path', () async {
      const dbContent = 'happy-path-db-content';
      final dbFile = await createFakeDb(content: dbContent);
      final original = await dbFile.readAsBytes();

      final enc = await service.createEncryptedBackup('happyPass');
      expect(enc.isSuccess(), isTrue);
      final backupFile = enc.getOrThrow();

      // Overwrite DB to prove restore writes correctly
      await dbFile.writeAsString('tampered');

      final res = await service.restoreEncryptedBackup(backupFile.path, 'happyPass');
      expect(res.isSuccess(), isTrue);
      expect(res.getOrThrow(), isNotNull);

      final after = await dbFile.readAsBytes();
      expect(after, equals(original));
    });

    test('createEncryptedBackup — exception during getApplicationDocumentsDirectory returns Failure', () async {
      PathProviderPlatform.instance = ThrowingPathProviderPlatform();
      final result = await service.createEncryptedBackup('pass');
      expect(result.isSuccess(), isFalse);
      expect(result.exceptionOrNull().toString(), contains('Failed to create backup'));
    });

    test('restoreEncryptedBackup — corrupted ciphertext fails', () async {
      await createFakeDb(content: 'corrupt-test');
      final enc = await service.createEncryptedBackup('pass123');
      final backupFile = enc.getOrThrow();
      final bytes = await backupFile.readAsBytes();
      // Corrupt last byte
      final corrupted = List<int>.from(bytes);
      corrupted[corrupted.length - 1] ^= 0xFF;
      final corruptFile = File(p.join(tempDir.path, 'corrupt.enc.db'));
      await corruptFile.writeAsBytes(corrupted);
      // Need to delete original DB content or keep? restore will still try decrypt corrupted
      final res = await service.restoreEncryptedBackup(corruptFile.path, 'pass123');
      expect(res.isSuccess(), isFalse);
    });
  });
}
