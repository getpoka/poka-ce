import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provider exposing [SecureStorageService] configured with platform keystore/keychain.
final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService(const FlutterSecureStorage());
});

/// Thin wrapper around [FlutterSecureStorage] used by the local app lock
/// (PIN / biometrics). Values never leave the device.
class SecureStorageService {
  /// Creates a [SecureStorageService] wrapping [_storage].
  SecureStorageService(this._storage);
  final FlutterSecureStorage _storage;

  /// Writes an encrypted key-value pair to hardware-backed storage.
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Reads a decrypted value for [key] from storage, or returns null.
  Future<String?> read(String key) async {
    return _storage.read(key: key);
  }

  /// Deletes a key-value entry from secure storage.
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }
}
