import 'package:flutter/material.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/keypad.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';
import 'package:poka_ce/theme/theme.dart';

Future<String?> showPinSetupSheet(BuildContext context) async {
  return showPokaSheet<String>(
    context: context,
    fitContent: true,
    builder: (context) => const PinSetupSheet(),
  );
}

class PinSetupSheet extends StatefulWidget {
  const PinSetupSheet({super.key});

  @override
  State<PinSetupSheet> createState() => _PinSetupSheetState();
}

class _PinSetupSheetState extends State<PinSetupSheet> {
  String _pin = '';
  String _confirmPin = '';
  bool _isConfirmStep = false;
  bool _isError = false;

  void _onKeyPressed(String key) {
    if (_isConfirmStep) {
      if (_confirmPin.length < 6) {
        setState(() {
          _confirmPin += key;
          _isError = false;
        });
        if (_confirmPin.length == 6) {
          _verifyMatch();
        }
      }
    } else {
      if (_pin.length < 6) {
        setState(() {
          _pin += key;
        });
        if (_pin.length == 6) {
          setState(() {
            _isConfirmStep = true;
          });
        }
      }
    }
  }

  void _onBackspacePressed() {
    if (_isConfirmStep) {
      if (_confirmPin.isNotEmpty) {
        setState(() {
          _confirmPin = _confirmPin.substring(0, _confirmPin.length - 1);
          _isError = false;
        });
      } else {
        setState(() {
          _isConfirmStep = false;
          _pin = _pin.substring(0, _pin.length - 1);
        });
      }
    } else {
      if (_pin.isNotEmpty) {
        setState(() {
          _pin = _pin.substring(0, _pin.length - 1);
        });
      }
    }
  }

  void _verifyMatch() {
    if (_pin == _confirmPin) {
      Navigator.pop(context, _pin);
    } else {
      setState(() {
        _isError = true;
        _confirmPin = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentPin = _isConfirmStep ? _confirmPin : _pin;

    return PokaSheet(
      title: _isConfirmStep ? context.t.lock.confirmPin : context.t.lock.createPin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _isError
                ? context.t.lock.pinsDoNotMatch
                : (_isConfirmStep ? context.t.lock.reenterPin : context.t.lock.enterPinAppLock),
            style: context.theme.typography.body.md.copyWith(
              color: _isError ? context.theme.colors.destructive : context.theme.colors.mutedForeground,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(6, (index) {
              final isFilled = index < currentPin.length;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isFilled ? context.theme.colors.primary : context.theme.colors.muted,
                  border: Border.all(
                    color: isFilled
                        ? context.theme.colors.primary
                        : context.theme.colors.mutedForeground.withValues(alpha: 0.3),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 48),
          Keypad(
            isBiometricActive: false,
            hasBiometric: false,
            onKeyPressed: _onKeyPressed,
            onBackspacePressed: _onBackspacePressed,
            onBiometricPressed: () {},
          ),
        ],
      ),
    );
  }
}
