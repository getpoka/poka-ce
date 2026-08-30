import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:poka_ce/core/utils/logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

final appLockServiceProvider = Provider<AppLockService>((ref) {
  return AppLockService(LocalAuthentication(), talker);
});

/// Wraps [LocalAuthentication] to provide biometric authentication capabilities,
/// including the ability to cancel an in-progress prompt via [stopAuthentication].
class AppLockService {
  /// Creates the service with a [LocalAuthentication] instance and a [Talker]
  /// logger for debugging authentication failures.
  const AppLockService(this._auth, this._talker);

  final LocalAuthentication _auth;
  final Talker _talker;

  /// Returns true if the device supports biometric or device-credential authentication.
  Future<bool> canAuthenticate() async {
    final isAvailable = await _auth.canCheckBiometrics;
    final isDeviceSupported = await _auth.isDeviceSupported();
    return isAvailable || isDeviceSupported;
  }

  /// Returns the list of enrolled biometric types available on the device.
  Future<List<BiometricType>> getAvailableBiometrics() {
    return _auth.getAvailableBiometrics();
  }

  /// Presents the biometric or device-credential prompt to the user.
  ///
  /// `persistAcrossBackgrounding` keeps the prompt alive when the app is briefly
  /// sent to the background (e.g. notification shade during fingerprint scan).
  ///
  /// When at least one biometric is enrolled, the prompt is restricted to
  /// biometrics only (`biometricOnly: true`) so only the legitimate owner's
  /// biometrics can unlock Poka. If no biometric is enrolled but the device
  /// supports device credentials, the prompt falls back to the device
  /// PIN/pattern — otherwise a user without enrolled biometrics could never
  /// unlock the app.
  ///
  /// Returns `true` on success, `false` on user cancellation.
  /// Throws [PlatformException] for other failures (e.g. locked out) so the
  /// caller can surface a meaningful error instead of silently failing.
  Future<bool> authenticate() async {
    try {
      final biometrics = await _auth.getAvailableBiometrics();
      _talker.info('Available biometrics on device: $biometrics');

      // Only restrict to biometrics when one is actually enrolled; otherwise
      // fall back to device credentials so the user is not locked out.
      final biometricOnly = biometrics.isNotEmpty;

      final result = await _auth.authenticate(
        localizedReason: 'Authenticate to access Poka',
        // Keep the prompt alive when the user briefly backgrounds the app
        // (e.g. notification shade appears during fingerprint scan).
        persistAcrossBackgrounding: true,
        biometricOnly: biometricOnly,
        sensitiveTransaction: false,
      );

      _talker.info('Biometric authenticate result: $result');
      return result;
    } on PlatformException catch (e, stack) {
      // PlatformException carries a structured error code (e.g. lockedOut,
      // notAvailable) — log it so we can diagnose device-specific failures.
      _talker.error('Biometric PlatformException [${e.code}]', e, stack);
      rethrow; // Propagate so controller can distinguish cancel from hard error.
    } on Exception catch (e, stack) {
      _talker.error('Biometric unexpected exception', e, stack);
      return false;
    }
  }

  /// Aborts any currently in-progress biometric authentication prompt.
  /// Safe to call even if no prompt is active.
  Future<void> stopAuthentication() async {
    try {
      await _auth.stopAuthentication();
    } on Exception {
      // Ignore — prompt may have already resolved on its own.
    }
  }
}
