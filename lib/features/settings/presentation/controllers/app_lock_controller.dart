import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poka_ce/core/services/app_lock_service.dart';
import 'package:poka_ce/core/services/preferences_service.dart';
import 'package:poka_ce/core/services/secure_storage_service.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_lock_controller.freezed.dart';
part 'app_lock_controller.g.dart';

/// Outcome of a PIN verification attempt.
enum PinVerificationResult {
  /// The PIN matched and the app is now authenticated.
  success,

  /// The PIN did not match.
  wrongPin,

  /// Too many failed attempts — the app is temporarily locked out.
  lockedOut,
}

@freezed
abstract class AppLockState with _$AppLockState {
  const factory AppLockState({
    @Default(false) bool isEnabled,
    @Default(false) bool isAuthenticated,
    @Default(false) bool isBiometricEnabled,

    /// True while a biometric prompt is actively being shown to the user.
    @Default(false) bool isBiometricActive,

    /// Timestamp until which PIN attempts are blocked after too many failures.
    DateTime? lockoutUntil,
  }) = _AppLockState;
}

/// While `true`, the app is not re-locked when it is backgrounded.
///
/// Used around system share sheets and file pickers (backup/restore) which
/// briefly pause the app — locking in the middle of those flows would abort
/// the operation.
@riverpod
class AppLockSuppression extends _$AppLockSuppression {
  @override
  bool build() => false;

  /// Suppresses the automatic re-lock until [release] is called.
  void suppress() => state = true;

  /// Re-enables the automatic re-lock.
  void release() => state = false;
}

/// Manages the app-lock state, including PIN verification and biometric unlock.
///
/// The PIN is never stored in plaintext: only a PBKDF2-HMAC-SHA256 hash with a
/// random per-install salt is kept in secure storage. Repeated failed attempts
/// trigger a temporary lockout to slow down brute-force guessing.
@riverpod
class AppLockController extends _$AppLockController {
  static const _appLockKey = 'app_lock_enabled';
  static const _appPinKey = 'app_lock_pin';
  static const _appPinHashKey = 'app_lock_pin_hash';
  static const _appPinSaltKey = 'app_lock_pin_salt';
  static const _biometricKey = 'app_lock_biometric';

  static const _failedAttemptsKey = 'app_lock_failed_attempts';
  static const _lockoutUntilKey = 'app_lock_locked_until';

  /// Consecutive failures allowed before a lockout begins.
  static const int _maxFailedAttempts = 5;

  /// How long PIN entry is blocked once the attempt limit is reached.
  static const Duration _lockoutDuration = Duration(seconds: 30);

  /// Key-derivation parameters used for the PIN hash.
  static final Pbkdf2 _pinKdf = Pbkdf2.hmacSha256(iterations: 100000, bits: 256);

  static final Random _random = Random.secure();

  @override
  AppLockState build() {
    final prefs = ref.watch(preferencesServiceProvider);
    final isEnabled = prefs.getBool(_appLockKey) ?? false;
    final isBiometricEnabled = prefs.getBool(_biometricKey) ?? false;
    final lockoutUntil = _parseLockoutUntil(prefs.getString(_lockoutUntilKey));

    return AppLockState(
      isEnabled: isEnabled,
      isBiometricEnabled: isBiometricEnabled,
      // If not enabled, we consider it authenticated by default to skip the lock screen.
      // If enabled, it starts as unauthenticated (locked).
      isAuthenticated: !isEnabled,
      lockoutUntil: lockoutUntil,
    );
  }

  /// Enables the app lock with a new PIN.
  Future<void> enableAppLock(String pin) async {
    final prefs = ref.read(preferencesServiceProvider);
    final secureStorage = ref.read(secureStorageProvider);

    final salt = _randomBytes(16);
    final hash = await _hashPin(pin, salt);
    await secureStorage.write(_appPinHashKey, _hexEncode(hash));
    await secureStorage.write(_appPinSaltKey, _hexEncode(salt));
    // Remove any legacy plaintext PIN from older versions.
    await secureStorage.delete(_appPinKey);
    await _clearLockout(prefs);

    await prefs.saveBool(_appLockKey, true);
    state = state.copyWith(
      isEnabled: true,
      isAuthenticated: true,
      lockoutUntil: null,
    );
  }

  /// Disables the app lock completely (removes PIN and biometric).
  Future<void> disableAppLock() async {
    final prefs = ref.read(preferencesServiceProvider);
    final secureStorage = ref.read(secureStorageProvider);
    await secureStorage.delete(_appPinKey);
    await secureStorage.delete(_appPinHashKey);
    await secureStorage.delete(_appPinSaltKey);
    await prefs.saveBool(_appLockKey, false);
    await prefs.saveBool(_biometricKey, false);
    await _clearLockout(prefs);
    state = state.copyWith(
      isEnabled: false,
      isBiometricEnabled: false,
      isAuthenticated: true,
      lockoutUntil: null,
    );
  }

  /// Toggles biometric authentication on or off.
  ///
  /// When [enable] is `true`, attempts a biometric/device-credential prompt
  /// before persisting the preference. If the device does not support any
  /// authentication method, the preference is saved directly without prompting
  /// (the PIN already protects the app lock).
  ///
  /// Returns `true` when the state was actually changed, `false` if the user
  /// cancelled or authentication failed — so the UI can revert optimistic UI.
  Future<bool> toggleBiometric({required bool enable}) async {
    if (!state.isEnabled) return false; // App Lock must be enabled first.
    if (state.isBiometricActive) return false; // Prevent concurrent prompts.

    if (enable) {
      final lockService = ref.read(appLockServiceProvider);
      final canAuth = await lockService.canAuthenticate();

      if (canAuth) {
        state = state.copyWith(isBiometricActive: true);
        try {
          // Device supports auth — require a successful prompt before enabling.
          final authenticated = await lockService.authenticate();
          state = state.copyWith(isBiometricActive: false);

          if (!authenticated) {
            // User cancelled or failed the prompt — do not change state.
            return false;
          }
        } on Exception {
          state = state.copyWith(isBiometricActive: false);
          return false;
        }
      }
      // If canAuth is false the device has no biometric/credential enrolled;
      // we still allow the toggle because the app-lock PIN already guards access.
    }

    final prefs = ref.read(preferencesServiceProvider);
    await prefs.saveBool(_biometricKey, enable);
    state = state.copyWith(isBiometricEnabled: enable);
    return true;
  }

  /// Verifies the entered PIN against the stored PIN hash.
  ///
  /// Returns [PinVerificationResult.lockedOut] when the attempt limit has been
  /// reached (until [AppLockState.lockoutUntil] expires).
  Future<PinVerificationResult> verifyPin(String pin) async {
    final prefs = ref.read(preferencesServiceProvider);
    final secureStorage = ref.read(secureStorageProvider);

    // Lockout gate: block attempts while a lockout is active.
    final lockoutUntil = state.lockoutUntil;
    if (lockoutUntil != null && DateTime.now().isBefore(lockoutUntil)) {
      return PinVerificationResult.lockedOut;
    }

    final storedHash = await secureStorage.read(_appPinHashKey);
    if (storedHash == null) {
      // Legacy installs stored the PIN in plaintext — verify and upgrade.
      final legacy = await secureStorage.read(_appPinKey);
      if (legacy == null) {
        return PinVerificationResult.wrongPin;
      }
      if (!_constantTimeEquals(utf8.encode(legacy), utf8.encode(pin))) {
        return _onFailedAttempt(prefs);
      }
      await _upgradeLegacyPin(secureStorage, pin);
      await _clearLockout(prefs);
      state = state.copyWith(isAuthenticated: true, lockoutUntil: null);
      return PinVerificationResult.success;
    }

    final saltHex = await secureStorage.read(_appPinSaltKey);
    if (saltHex == null) {
      return PinVerificationResult.wrongPin;
    }

    final candidate = await _hashPin(pin, _hexDecode(saltHex));
    final storedHashBytes = _hexDecode(storedHash);
    if (!_constantTimeEquals(storedHashBytes, candidate)) {
      return _onFailedAttempt(prefs);
    }

    await _clearLockout(prefs);
    state = state.copyWith(isAuthenticated: true, lockoutUntil: null);
    return PinVerificationResult.success;
  }

  /// Shows the biometric prompt if biometric is enabled.
  Future<bool> authenticateBiometric() async {
    if (!state.isEnabled || !state.isBiometricEnabled) return true;

    state = state.copyWith(isBiometricActive: true);
    try {
      final lockService = ref.read(appLockServiceProvider);
      final authenticated = await lockService.authenticate();
      if (authenticated) {
        state = state.copyWith(isAuthenticated: true, isBiometricActive: false);
      } else {
        state = state.copyWith(isBiometricActive: false);
      }
      return authenticated;
    } on Exception {
      state = state.copyWith(isBiometricActive: false);
      return false;
    }
  }

  /// Aborts any currently active biometric prompt.
  Future<void> cancelBiometric() async {
    if (!state.isBiometricActive) return;
    final lockService = ref.read(appLockServiceProvider);
    await lockService.stopAuthentication();
    state = state.copyWith(isBiometricActive: false);
  }

  /// Locks the app, requiring re-authentication on the next access.
  void lock() {
    if (state.isEnabled) {
      state = state.copyWith(isAuthenticated: false);
    }
  }

  /// Manually marks the session as authenticated.
  void unlock() {
    state = state.copyWith(isAuthenticated: true);
  }

  // ── PIN hashing helpers ────────────────────────────────────────────────────

  Future<List<int>> _hashPin(String pin, List<int> salt) async {
    final key = await _pinKdf.deriveKey(
      secretKey: SecretKey(utf8.encode(pin)),
      nonce: salt,
    );
    return key.extractBytes();
  }

  Future<void> _upgradeLegacyPin(SecureStorageService storage, String pin) async {
    final salt = _randomBytes(16);
    final hash = await _hashPin(pin, salt);
    await storage.write(_appPinHashKey, _hexEncode(hash));
    await storage.write(_appPinSaltKey, _hexEncode(salt));
    await storage.delete(_appPinKey);
  }

  // ── Lockout helpers ────────────────────────────────────────────────────────

  Future<PinVerificationResult> _onFailedAttempt(PreferencesService prefs) async {
    final attempts = (int.tryParse(prefs.getString(_failedAttemptsKey) ?? '') ?? 0) + 1;
    await prefs.saveString(_failedAttemptsKey, '$attempts');

    if (attempts >= _maxFailedAttempts) {
      final until = DateTime.now().add(_lockoutDuration);
      await prefs.saveString(_lockoutUntilKey, until.toIso8601String());
      await prefs.remove(_failedAttemptsKey);
      state = state.copyWith(lockoutUntil: until);
      return PinVerificationResult.lockedOut;
    }
    return PinVerificationResult.wrongPin;
  }

  Future<void> _clearLockout(PreferencesService prefs) async {
    await prefs.remove(_failedAttemptsKey);
    await prefs.remove(_lockoutUntilKey);
  }

  DateTime? _parseLockoutUntil(String? raw) {
    if (raw == null) return null;
    final parsed = DateTime.tryParse(raw);
    if (parsed == null || !parsed.isAfter(DateTime.now())) return null;
    return parsed;
  }

  // ── Utility helpers ────────────────────────────────────────────────────────

  Uint8List _randomBytes(int length) {
    final bytes = Uint8List(length);
    for (var i = 0; i < length; i++) {
      bytes[i] = _random.nextInt(256);
    }
    return bytes;
  }

  bool _constantTimeEquals(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a[i] ^ b[i];
    }
    return diff == 0;
  }

  String _hexEncode(List<int> bytes) => bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

  List<int> _hexDecode(String hex) {
    final bytes = Uint8List(hex.length ~/ 2);
    for (var i = 0; i < bytes.length; i++) {
      bytes[i] = int.parse(hex.substring(i * 2, i * 2 + 2), radix: 16);
    }
    return bytes;
  }
}
