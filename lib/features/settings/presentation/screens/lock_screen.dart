import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/settings/presentation/controllers/app_lock_controller.dart';
import 'package:poka_ce/features/settings/presentation/widgets/pin_dots.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/keypad.dart';
import 'package:poka_ce/theme/theme.dart';

/// Dedicated screen for unlocking the app via PIN or Biometrics.
/// Shows automatically if the user has a valid session but the app is locked.
class LockScreen extends ConsumerStatefulWidget {
  const LockScreen({super.key});

  @override
  ConsumerState<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<LockScreen> {
  String _pin = '';
  bool _isError = false;
  Timer? _lockoutTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tryAutoTriggerBiometric();
    });
    _startLockoutTimer();
  }

  @override
  void dispose() {
    _lockoutTimer?.cancel();
    super.dispose();
  }

  /// Refreshes the countdown while a lockout is active, and stops once it
  /// expires so the keypad becomes usable again.
  void _startLockoutTimer() {
    _lockoutTimer?.cancel();
    final lockoutUntil = ref.read(appLockControllerProvider).lockoutUntil;
    if (lockoutUntil == null || !lockoutUntil.isAfter(DateTime.now())) return;

    _lockoutTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      final until = ref.read(appLockControllerProvider).lockoutUntil;
      if (until == null || !until.isAfter(DateTime.now())) {
        timer.cancel();
      }
      setState(() {});
    });
  }

  bool _isLockedOut(AppLockState state) {
    final until = state.lockoutUntil;
    return until != null && until.isAfter(DateTime.now());
  }

  void _tryAutoTriggerBiometric() {
    final appLockState = ref.read(appLockControllerProvider);
    if (appLockState.isBiometricEnabled) {
      _triggerBiometric();
    }
  }

  Future<void> _triggerBiometric() async {
    final authenticated = await ref.read(appLockControllerProvider.notifier).authenticateBiometric();
    if (authenticated && mounted) {
      showFToast(
        context: context,
        title: Text(context.t.lock.unlocked),
      );
      context.go('/');
    }
  }

  void _onKeyPressed(String key) {
    if (_isLockedOut(ref.read(appLockControllerProvider))) return;
    if (_pin.length < 6) {
      setState(() {
        _pin += key;
        _isError = false;
      });
      if (_pin.length == 6) {
        _verifyPin();
      }
    }
  }

  void _onBackspacePressed() {
    if (_isLockedOut(ref.read(appLockControllerProvider))) return;
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
        _isError = false;
      });
    }
  }

  Future<void> _verifyPin() async {
    final result = await ref.read(appLockControllerProvider.notifier).verifyPin(_pin);
    if (!mounted) return;

    switch (result) {
      case PinVerificationResult.success:
        showFToast(
          context: context,
          title: Text(context.t.lock.unlocked),
        );
        context.go('/');
      case PinVerificationResult.wrongPin:
        setState(() {
          _isError = true;
          _pin = '';
        });
        showFToast(
          context: context,
          title: Text(context.t.lock.invalidPin),
        );
      case PinVerificationResult.lockedOut:
        _startLockoutTimer();
        setState(() {
          _isError = true;
          _pin = '';
        });
        showFToast(
          context: context,
          title: Text(context.t.lock.tooManyAttempts),
          description: Text(context.t.lock.temporarilyLocked),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLockState = ref.watch(appLockControllerProvider);
    final isBiometricActive = appLockState.isBiometricActive;
    final isLockedOut = _isLockedOut(appLockState);
    final lockoutSeconds = isLockedOut ? appLockState.lockoutUntil!.difference(DateTime.now()).inSeconds : 0;

    final subtitle = switch ((_isError, isLockedOut)) {
      (true, true) => context.t.lock.retryInSeconds(seconds: lockoutSeconds),
      (true, false) => context.t.lock.incorrectPin,
      (false, true) => context.t.lock.retryInSeconds(seconds: lockoutSeconds),
      (false, false) => context.t.lock.enter6DigitPin,
    };

    return FScaffold(
      child: Column(
        children:
            [
                  const Spacer(),
                  const Icon(FPhosphorIcons.lockKey, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    context.t.lock.enterPin,
                    style: context.theme.typography.display.sm,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: context.theme.typography.body.md.copyWith(
                      color: _isError ? context.theme.colors.destructive : context.theme.colors.mutedForeground,
                    ),
                  ),
                  const SizedBox(height: 32),
                  PinDots(pinLength: _pin.length),
                  const Spacer(),
                  Keypad(
                    isBiometricActive: isBiometricActive,
                    hasBiometric: appLockState.isBiometricEnabled,
                    onKeyPressed: _onKeyPressed,
                    onBackspacePressed: _onBackspacePressed,
                    onBiometricPressed: _triggerBiometric,
                  ),
                  SizedBox(height: context.theme.style.app.xl),
                ]
                .animate(interval: 30.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.1, end: 0, duration: 400.ms, curve: Curves.easeOut),
      ),
    );
  }
}
