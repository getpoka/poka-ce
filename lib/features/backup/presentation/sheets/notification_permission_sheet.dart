import 'package:flutter/material.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';
import 'package:poka_ce/theme/theme.dart';

/// Shows an explanatory bottom sheet detailing why notification permission is needed
/// for periodic local backup reminders.
///
/// Returns `true` if the user opts to allow notifications, or `false`/`null` if cancelled.
Future<bool?> showNotificationRationaleSheet(BuildContext context) {
  return showPokaSheet<bool>(
    context: context,
    persistent: false,
    fitContent: true,
    builder: (context) => const _NotificationRationaleSheet(),
  );
}

class _NotificationRationaleSheet extends StatelessWidget {
  const _NotificationRationaleSheet();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;
    final typography = theme.typography;
    final t = context.t.backup;

    return PokaSheet(
      title: t.permissionRationaleTitle,
      isScrollable: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          Center(
            child: PokaIcon(
              icon: FPhosphorIcons.bellSimpleRinging,
              shape: PokaIconShape.circle,
              color: colors.primary,
              size: PokaIconSize.hero,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            t.permissionRationaleDesc,
            style: typography.body.md.copyWith(
              color: colors.mutedForeground,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: FButton(
                  onPress: () => Navigator.of(context).pop(false),
                  variant: FButtonVariant.outline,
                  child: Text(context.t.common.cancel),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FButton(
                  onPress: () => Navigator.of(context).pop(true),
                  child: Text(t.allowNotifications),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
