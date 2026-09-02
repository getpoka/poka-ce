// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_lock_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// While `true`, the app is not re-locked when it is backgrounded.
///
/// Used around system share sheets and file pickers (backup/restore) which
/// briefly pause the app — locking in the middle of those flows would abort
/// the operation.

@ProviderFor(AppLockSuppression)
final appLockSuppressionProvider = AppLockSuppressionProvider._();

/// While `true`, the app is not re-locked when it is backgrounded.
///
/// Used around system share sheets and file pickers (backup/restore) which
/// briefly pause the app — locking in the middle of those flows would abort
/// the operation.
final class AppLockSuppressionProvider extends $NotifierProvider<AppLockSuppression, bool> {
  /// While `true`, the app is not re-locked when it is backgrounded.
  ///
  /// Used around system share sheets and file pickers (backup/restore) which
  /// briefly pause the app — locking in the middle of those flows would abort
  /// the operation.
  AppLockSuppressionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLockSuppressionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLockSuppressionHash();

  @$internal
  @override
  AppLockSuppression create() => AppLockSuppression();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$appLockSuppressionHash() => r'cb70d0912f3d4fbaf4756050ed4b47b642c1b79f';

/// While `true`, the app is not re-locked when it is backgrounded.
///
/// Used around system share sheets and file pickers (backup/restore) which
/// briefly pause the app — locking in the middle of those flows would abort
/// the operation.

abstract class _$AppLockSuppression extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<bool, bool>, bool, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}

/// Manages the app-lock state, including PIN verification and biometric unlock.
///
/// The PIN is never stored in plaintext: only a PBKDF2-HMAC-SHA256 hash with a
/// random per-install salt is kept in secure storage. Repeated failed attempts
/// trigger a temporary lockout to slow down brute-force guessing.

@ProviderFor(AppLockController)
final appLockControllerProvider = AppLockControllerProvider._();

/// Manages the app-lock state, including PIN verification and biometric unlock.
///
/// The PIN is never stored in plaintext: only a PBKDF2-HMAC-SHA256 hash with a
/// random per-install salt is kept in secure storage. Repeated failed attempts
/// trigger a temporary lockout to slow down brute-force guessing.
final class AppLockControllerProvider extends $NotifierProvider<AppLockController, AppLockState> {
  /// Manages the app-lock state, including PIN verification and biometric unlock.
  ///
  /// The PIN is never stored in plaintext: only a PBKDF2-HMAC-SHA256 hash with a
  /// random per-install salt is kept in secure storage. Repeated failed attempts
  /// trigger a temporary lockout to slow down brute-force guessing.
  AppLockControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLockControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLockControllerHash();

  @$internal
  @override
  AppLockController create() => AppLockController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLockState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppLockState>(value),
    );
  }
}

String _$appLockControllerHash() => r'91d6614d584fc27ff2d02738a249b3116c4c8377';

/// Manages the app-lock state, including PIN verification and biometric unlock.
///
/// The PIN is never stored in plaintext: only a PBKDF2-HMAC-SHA256 hash with a
/// random per-install salt is kept in secure storage. Repeated failed attempts
/// trigger a temporary lockout to slow down brute-force guessing.

abstract class _$AppLockController extends $Notifier<AppLockState> {
  AppLockState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AppLockState, AppLockState>;
    final element =
        ref.element as $ClassProviderElement<AnyNotifier<AppLockState, AppLockState>, AppLockState, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
