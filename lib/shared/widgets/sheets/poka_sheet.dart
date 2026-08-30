import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet_header.dart';
import 'package:poka_ce/theme/theme.dart';

export 'poka_sheet_action_item.dart';
export 'poka_sheet_header.dart';

Future<T?> showPokaSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isScrollControlled = false,
  // When true, the sheet height fits its content by using forui's default ratio.
  // When false (default), the sheet fills the full screen height.
  bool fitContent = false,
  // When true, the sheet can only be closed via its close button, a save
  // action, or the system back gesture. When false, tapping outside dismisses it.
  bool persistent = true,
  bool useRootNavigator = true,
}) {
  // The decoration is built from the builder's context so the background color
  // tracks live theme changes (e.g. system dark mode toggled at runtime). A
  // decoration captured from the caller's context would freeze the sheet
  // background while its content already switched to the new theme.
  BoxDecoration decoration(BuildContext ctx) => BoxDecoration(
    color: ctx.theme.colors.background,
    borderRadius: BorderRadius.vertical(
      top: ctx.theme.style.borderRadius.xl.topLeft,
    ),
  );

  if (fitContent) {
    // Allows the sheet to shrink to its content up to the full screen height (dynamic).
    return showFSheet<T>(
      context: context,
      useRootNavigator: useRootNavigator,
      side: FLayout.btt,
      mainAxisMaxRatio: null,
      barrierDismissible: !persistent,
      draggable: !persistent,
      builder: (ctx) => DecoratedBox(
        decoration: decoration(ctx),
        child: builder(ctx),
      ),
    );
  }

  // Full-screen: mainAxisMaxRatio: null removes the max constraint.
  return showFSheet<T>(
    context: context,
    useRootNavigator: useRootNavigator,
    side: FLayout.btt,
    mainAxisMaxRatio: null,
    barrierDismissible: !persistent,
    draggable: !persistent,
    builder: (ctx) => DecoratedBox(
      decoration: decoration(ctx),
      child: builder(ctx),
    ),
  );
}

EdgeInsets pokaSheetBottomInset(BuildContext context) {
  final homeIndicatorHeight = MediaQuery.viewPaddingOf(context).bottom;
  // 12px breathing room + home indicator height
  return EdgeInsets.only(bottom: homeIndicatorHeight + 12);
}

class PokaSheetHandle extends StatelessWidget {
  const PokaSheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Center(
      child: Container(
        width: 48,
        height: 4,
        margin: const EdgeInsets.only(top: 12, bottom: 4),
        decoration: BoxDecoration(
          color: theme.colors.mutedForeground.withValues(alpha: 0.3),
          borderRadius: theme.style.borderRadius.xs2,
        ),
      ),
    );
  }
}

/// A reusable bottom sheet layout that automatically includes the drag handle,
/// centered title, optional close button, and handles scrolling & keyboard insets.
class PokaSheet extends StatelessWidget {
  const PokaSheet({
    required this.title,
    required this.child,
    this.leading,
    this.trailing,
    this.showCloseButton = true,
    this.isScrollable = true,
    this.padding = const EdgeInsets.fromLTRB(12, 0, 12, 0),
    super.key,
  });

  final String title;
  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final bool showCloseButton;
  final bool isScrollable;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final effectivePadding = padding.add(pokaSheetBottomInset(context));

    Widget content = Padding(
      padding: effectivePadding,
      child: child,
    );

    if (isScrollable) {
      content = Flexible(
        child: SingleChildScrollView(
          child: content,
        ),
      );
    }

    return SafeArea(
      top: false,
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const PokaSheetHandle(),
          PokaSheetHeader(
            title: title,
            leading: leading,
            trailing: trailing,
            showCloseButton: showCloseButton,
          ),
          content,
        ],
      ),
    );
  }
}
