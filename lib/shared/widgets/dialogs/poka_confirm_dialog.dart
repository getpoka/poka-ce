import 'package:flutter/material.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/theme/theme.dart';

/// Shows a reusable destructive confirmation dialog.
///
/// Returns `true` when the user confirms, `false` when cancelled/dismissed.
///
/// - [title]       : Dialog headline.
/// - [body]        : Descriptive body text explaining the consequence.
/// - [confirmText] : Override label for the confirm button (defaults to "Delete").
Future<bool?> showPokaConfirmDialog(
  BuildContext context, {
  required String title,
  required String body,
  String? confirmText,
}) {
  return showFDialog<bool>(
    context: context,
    builder: (ctx, style, animation) => FDialog(
      animation: animation,
      builder: (dialogCtx, dialogStyle) {
        final theme = ctx.theme;
        final colors = theme.colors;
        final typography = theme.typography;

        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Icon circle
              Center(
                child: PokaIcon(
                  icon: FPhosphorIcons.warning,
                  shape: PokaIconShape.circle,
                  color: colors.destructive,
                  size: PokaIconSize.hero,
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                title,
                style: typography.display.sm.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colors.foreground,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Body description
              Text(
                body,
                style: typography.body.md.copyWith(
                  color: colors.mutedForeground,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // "Cannot be undone" warning
              Text(
                context.t.common.cannotBeUndone,
                style: typography.bodyPrimary.copyWith(
                  color: colors.destructive,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Actions
              Row(
                children: [
                  Expanded(
                    child: FButton(
                      onPress: () => Navigator.of(ctx).pop(false),
                      variant: FButtonVariant.outline,
                      child: Text(context.t.common.cancel),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FButton(
                      onPress: () => Navigator.of(ctx).pop(true),
                      variant: FButtonVariant.destructive,
                      child: Text(confirmText ?? context.t.common.delete),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  );
}
