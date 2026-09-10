import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

/// Displays an auto-dismissing toast notification with watchdog timer protection.
///
/// Prevents mobile touch hover traps, gesture arena cancel traps, and route transition
/// race conditions by attaching an independent timer that safely dismisses the toast
/// post-frame if ForUI's internal timer is cancelled or interrupted.
FToasterEntry showPokaToast({
  required BuildContext context,
  required Widget title,
  FToastVariant variant = FToastVariant.primary,
  Widget? icon,
  Widget? description,
  Widget Function(BuildContext context, FToasterEntry entry)? suffixBuilder,
  FToastAlignment? alignment,
  List<AxisDirection>? swipeToDismiss,
  Duration duration = const Duration(seconds: 4),
  VoidCallback? onDismiss,
}) {
  Timer? watchdogTimer;
  late final FToasterEntry entry;

  entry = showFToast(
    context: context,
    title: title,
    variant: variant,
    icon: icon,
    description: description,
    suffixBuilder: suffixBuilder,
    alignment: alignment,
    swipeToDismiss: swipeToDismiss,
    duration: duration,
    onDismiss: () {
      watchdogTimer?.cancel();
      onDismiss?.call();
    },
  );

  // Watchdog timer ensures the toast auto-dismisses even if mobile touch / hover events
  // or gesture arena cancellations froze the internal timer.
  watchdogTimer = Timer(duration + const Duration(milliseconds: 300), () {
    if (entry.showing) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (entry.showing) {
          entry.dismiss();
        }
      });
    }
  });

  return entry;
}

/// Displays an actionable toast notification (e.g. Delete with Undo button)
/// positioned at [FToastAlignment.bottomCenter] for optimal thumb ergonomics.
FToasterEntry showPokaActionToast({
  required BuildContext context,
  required Widget title,
  required String actionLabel,
  required VoidCallback onAction,
  FToastVariant variant = FToastVariant.primary,
  Widget? icon,
  Widget? description,
  FToastAlignment alignment = FToastAlignment.bottomCenter,
  List<AxisDirection> swipeToDismiss = const [
    AxisDirection.down,
    AxisDirection.left,
    AxisDirection.right,
  ],
  Duration duration = const Duration(seconds: 5),
  VoidCallback? onDismiss,
}) {
  return showPokaToast(
    context: context,
    title: title,
    variant: variant,
    icon: icon,
    description: description,
    alignment: alignment,
    swipeToDismiss: swipeToDismiss,
    duration: duration,
    onDismiss: onDismiss,
    suffixBuilder: (toastContext, entry) => FButton(
      size: FButtonSizeVariant.sm,
      variant: FButtonVariant.outline,
      onPress: () {
        entry.dismiss();
        onAction();
      },
      child: Text(actionLabel),
    ),
  );
}
