import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/settings/presentation/controllers/app_lock_controller.dart';
import 'package:poka_ce/features/settings/presentation/widgets/pin_dots.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/keypad.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';
import 'package:poka_ce/theme/theme.dart';

/// Shows a sheet asking the user to verify their PIN or biometric.
/// Returns true if verified, false if cancelled.
Future<bool> showPinVerificationSheet(BuildContext context) async {
  final result = await showPokaSheet<bool>(
    context: context,
    fitContent: true,
    builder: (context) => const PinVerificationSheet(),
  );
  return result ?? false;
}

/// A bottom sheet that verifies the user's PIN/Biometric.
class PinVerificationSheet extends ConsumerStatefulWidget {
  /// Creates a [PinVerificationSheet].
  const PinVerificationSheet({super.key});

  @override
  ConsumerState<PinVerificationSheet> createState() => _PinVerificationSheetState();
}

class _PinVerificationSheetState extends ConsumerState<PinVerificationSheet> {
  String _pin = '';
  bool _isError = false;
  bool _busy = false;
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
    if (_busy) return;
    setState(() => _busy = true);

    final authenticated = await ref.read(appLockControllerProvider.notifier).authenticateBiometric();
    if (!mounted) return;

    setState(() => _busy = false);
    if (authenticated) {
      Navigator.of(context).pop(true);
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
        Navigator.of(context).pop(true);
      case PinVerificationResult.wrongPin:
        setState(() {
          _isError = true;
          _pin = '';
        });
      case PinVerificationResult.lockedOut:
        _startLockoutTimer();
        setState(() {
          _isError = true;
          _pin = '';
        });
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
      (false, false) => context.t.lock.verifyIdentity,
    };

    return PokaSheet(
      title: context.t.shared.authRequired,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            subtitle,
            style: context.theme.typography.body.md.copyWith(
              color: _isError ? context.theme.colors.destructive : context.theme.colors.mutedForeground,
            ),
          ),
          const SizedBox(height: 32),
          PinDots(pinLength: _pin.length),
          const SizedBox(height: 48),
          Keypad(
            isBiometricActive: isBiometricActive,
            hasBiometric: appLockState.isBiometricEnabled,
            onKeyPressed: _onKeyPressed,
            onBackspacePressed: _onBackspacePressed,
            onBiometricPressed: _triggerBiometric,
          ),
        ],
      ),
    );
  }
}
