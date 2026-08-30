import 'package:flutter/material.dart';
import 'package:poka_ce/theme/theme.dart';

class Keypad extends StatelessWidget {
  const Keypad({
    required this.isBiometricActive,
    required this.hasBiometric,
    required this.onKeyPressed,
    required this.onBackspacePressed,
    required this.onBiometricPressed,
    super.key,
  });

  final bool isBiometricActive;
  final bool hasBiometric;
  final void Function(String) onKeyPressed;
  final VoidCallback onBackspacePressed;
  final VoidCallback onBiometricPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _KeypadButton(text: '1', onPress: () => onKeyPressed('1')),
              _KeypadButton(text: '2', onPress: () => onKeyPressed('2')),
              _KeypadButton(text: '3', onPress: () => onKeyPressed('3')),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _KeypadButton(text: '4', onPress: () => onKeyPressed('4')),
              _KeypadButton(text: '5', onPress: () => onKeyPressed('5')),
              _KeypadButton(text: '6', onPress: () => onKeyPressed('6')),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _KeypadButton(text: '7', onPress: () => onKeyPressed('7')),
              _KeypadButton(text: '8', onPress: () => onKeyPressed('8')),
              _KeypadButton(text: '9', onPress: () => onKeyPressed('9')),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (hasBiometric)
                _KeypadIconButton(
                  icon: isBiometricActive ? null : FPhosphorIcons.fingerprint,
                  isLoading: isBiometricActive,
                  onPress: onBiometricPressed,
                )
              else
                const SizedBox(width: 64, height: 64),
              _KeypadButton(text: '0', onPress: () => onKeyPressed('0')),
              _KeypadIconButton(
                icon: FPhosphorIcons.backspace,
                onPress: onBackspacePressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _KeypadButton extends StatelessWidget {
  const _KeypadButton({required this.text, required this.onPress});
  final String text;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return FTappable(
      onPress: onPress,
      child: Container(
        width: 64,
        height: 64,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.theme.colors.secondary,
        ),
        child: Text(
          text,
          style: context.theme.typography.display.sm.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _KeypadIconButton extends StatelessWidget {
  const _KeypadIconButton({
    required this.onPress,
    this.icon,
    this.isLoading = false,
  });

  final IconData? icon;
  final bool isLoading;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return FTappable(
      onPress: onPress,
      child: Container(
        width: 64,
        height: 64,
        alignment: Alignment.center,
        child: isLoading
            ? const FCircularProgress()
            : Icon(
                icon ?? FPhosphorIcons.question,
                size: 28,
                color: context.theme.colors.primary,
              ),
      ),
    );
  }
}
