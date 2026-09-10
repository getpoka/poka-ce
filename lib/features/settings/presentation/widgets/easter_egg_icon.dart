import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_toast.dart';

/// An interactive app icon widget that reveals an easter egg dialog upon multiple rapid taps.
class EasterEggIcon extends StatefulWidget {
  /// Creates an [EasterEggIcon].
  ///
  /// [package] can be supplied if the widget is consumed inside an external app
  /// (e.g. `poka-pe`) that depends on `poka_ce` as a package. If omitted, it defaults
  /// to root asset loading with an automatic fallback to `package: 'poka_ce'`.
  const EasterEggIcon({
    super.key,
    this.package,
  });

  /// The package containing the assets, if consumed from a downstream package.
  final String? package;

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
      showPokaToast(
        context: context,
        title: Text(t.settings.easterEggRemaining(remaining: remaining)),
      );
    }

    if (_tapCount >= _requiredTaps) {
      _tapCount = 0;
      _firstTapTime = null;

      showPokaToast(
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
                      package: widget.package,
                      width: 280,
                      fit: BoxFit.cover,
                      errorBuilder: widget.package == null
                          ? (context, error, stackTrace) => Image.asset(
                              'assets/images/hasbullah.gif',
                              package: 'poka_ce',
                              width: 280,
                              fit: BoxFit.cover,
                            )
                          : null,
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
          package: widget.package,
          width: 96,
          height: 96,
          fit: BoxFit.cover,
          errorBuilder: widget.package == null
              ? (context, error, stackTrace) => Image.asset(
                  'assets/images/logo.png',
                  package: 'poka_ce',
                  width: 96,
                  height: 96,
                  fit: BoxFit.cover,
                )
              : null,
        ),
      ),
    );
  }
}
