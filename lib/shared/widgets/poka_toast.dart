import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

/// Displays an auto-dismissing toast notification.
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
  return showRawFToast(
    context: context,
    builder: (context, entry) => FToast(
      variant: variant,
      icon: icon,
      title: title,
      description: description,
      suffix: suffixBuilder?.call(context, entry),
    ),
    alignment: alignment,
    swipeToDismiss: swipeToDismiss,
    duration: duration,
    onDismiss: onDismiss,
  );
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
  List<AxisDirection> swipeToDismiss = const [AxisDirection.down, AxisDirection.left, AxisDirection.right],
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
