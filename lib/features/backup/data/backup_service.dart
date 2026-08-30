import 'dart:io';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:result_dart/result_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'backup_service.g.dart';

@riverpod
BackupService backupService(Ref ref) => BackupService();

class BackupService {
  final String dbName = 'poka.sqlite';
  final _cipher = AesGcm.with256bits();
  final _kdf = Pbkdf2(
    macAlgorithm: Hmac.sha256(),
    iterations: 10000,
    bits: 256,
  );

  /// Generates a backup filename: poka-YYYYMMDD-HHmmss.sqlite
  String _generateBackupFilename() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyyMMdd-HHmmss');
    return 'poka-${formatter.format(now)}.sqlite';
  }

  /// Derives a SecretKey from the given password and salt
  Future<SecretKey> _deriveKey(String password, List<int> salt) async {
    final secretKey = SecretKey(password.codeUnits);
    return _kdf.deriveKey(
      secretKey: secretKey,
      nonce: salt,
    );
  }

  /// Encrypts the active database and returns the path to the temporary encrypted file
  Future<Result<File>> createEncryptedBackup(String password) async {
    try {
      final docsFolder = await getApplicationDocumentsDirectory();
      final supportFolder = await getApplicationSupportDirectory();

      File? dbFile;
      final possiblePaths = [
        p.join(supportFolder.path, dbName),
        p.join(docsFolder.path, dbName),
      ];

      for (final path in possiblePaths) {
        final f = File(path);
        if (f.existsSync()) {
          dbFile = f;
          break;
        }
      }

      if (dbFile == null) {
        return Failure(Exception('Database file not found'));
      }

      final dbBytes = await dbFile.readAsBytes();

      // Generate a random salt (16 bytes) and nonce (12 bytes for GCM)
      final salt = _cipher.newNonce(); // 12 bytes nonce for salt
      final nonce = _cipher.newNonce();

      // Derive key
      final key = await _deriveKey(password, salt);

      // Encrypt
      final secretBox = await _cipher.encrypt(
        dbBytes,
        secretKey: key,
        nonce: nonce,
      );

      // We need to pack the salt, nonce, mac, and cipherText into a single file
      // Format: [salt(12)] [nonce(12)] [mac(16)] [cipherText(N)]
      final b = BytesBuilder()
        ..add(salt)
        ..add(nonce)
        ..add(secretBox.mac.bytes)
        ..add(secretBox.cipherText);

      final tempDir = await getTemporaryDirectory();
      final backupFile = File(p.join(tempDir.path, _generateBackupFilename()));
      await backupFile.writeAsBytes(b.toBytes(), flush: true);

      return Success(backupFile);
    } on Exception catch (e) {
      return Failure(Exception('Failed to create backup: $e'));
    }
  }

  /// Decrypts the given backup file and overwrites the active database
  Future<Result<Unit>> restoreEncryptedBackup(String backupFilePath, String password) async {
    try {
      final backupFile = File(backupFilePath);
      if (!backupFile.existsSync()) {
        return Failure(Exception('Backup file not found'));
      }

      final fileBytes = await backupFile.readAsBytes();

      // Expected minimum length: 12 (salt) + 12 (nonce) + 16 (mac) = 40 bytes
      if (fileBytes.length < 40) {
        return Failure(Exception('Invalid backup file format'));
      }

      // Unpack
      final salt = fileBytes.sublist(0, 12);
      final nonce = fileBytes.sublist(12, 24);
      final macBytes = fileBytes.sublist(24, 40);
      final cipherText = fileBytes.sublist(40);

      // Derive key
      final key = await _deriveKey(password, salt);

      final secretBox = SecretBox(
        cipherText,
        nonce: nonce,
        mac: Mac(macBytes),
      );

      // Decrypt
      // This will throw if password/mac is wrong
      final clearText = await _cipher.decrypt(
        secretBox,
        secretKey: key,
      );

      // Overwrite db file
      final docsFolder = await getApplicationDocumentsDirectory();
      final supportFolder = await getApplicationSupportDirectory();

      File? dbFile;
      final possiblePaths = [
        p.join(supportFolder.path, dbName),
        p.join(docsFolder.path, dbName),
      ];

      for (final path in possiblePaths) {
        final f = File(path);
        if (f.existsSync()) {
          dbFile = f;
          break;
        }
      }

      dbFile ??= File(p.join(supportFolder.path, dbName));

      await dbFile.writeAsBytes(clearText, flush: true);

      return const Success(unit);
    } on Exception catch (e) {
      return Failure(Exception('Invalid password or corrupted file: $e'));
    }
  }
}
