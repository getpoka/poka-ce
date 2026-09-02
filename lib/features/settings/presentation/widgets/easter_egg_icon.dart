import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/i18n/strings.g.dart';

class EasterEggIcon extends StatefulWidget {
  const EasterEggIcon({super.key});

  @override
  State<EasterEggIcon> createState() => _EasterEggIconState();
}

class _EasterEggIconState extends State<EasterEggIcon> {
  int _tapCount = 0;
  DateTime? _firstTapTime;

  static const _resetDuration = Duration(seconds: 2);
  static const _requiredTaps = 7;

  void _onTap() {
    final now = DateTime.now();

    if (_firstTapTime == null || now.difference(_firstTapTime!) > _resetDuration) {
      _firstTapTime = now;
      _tapCount = 1;
      return;
    }

    _tapCount++;

    final remaining = _requiredTaps - _tapCount;
    if (remaining > 0 && remaining <= 3) {
      showFToast(
        context: context,
        title: Text(t.settings.easterEggRemaining(remaining: remaining)),
      );
    }

    if (_tapCount >= _requiredTaps) {
      _tapCount = 0;
      _firstTapTime = null;

      showFToast(
        context: context,
        title: Text(t.settings.easterEggFound),
      );

      showFDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (ctx, style, animation) => FDialog(
          animation: animation,
          builder: (dialogCtx, dialogStyle) {
            return SizedBox(
              width: 280,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: context.theme.style.borderRadius.lg,
                    child: Image.asset(
                      'assets/images/hasbullah.gif',
                      package: 'poka_ce',
                      width: 280,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Navigator.of(ctx).pop(),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          FPhosphorIcons.x,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return GestureDetector(
      onTap: _onTap,
      child: ClipRRect(
        borderRadius: theme.style.borderRadius.xl,
        child: Image.asset(
          'assets/images/logo.png',
          width: 96,
          height: 96,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
