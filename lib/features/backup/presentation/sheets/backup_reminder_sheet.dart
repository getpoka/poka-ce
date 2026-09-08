import 'package:flutter/material.dart';
import 'package:poka_ce/features/backup/domain/backup_reminder_service.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';
import 'package:poka_ce/theme/theme.dart';

/// Shows a bottom sheet allowing the user to configure the periodic backup reminder interval.
Future<BackupReminderInterval?> showBackupReminderSheet(
  BuildContext context, {
  required BackupReminderInterval currentInterval,
}) async {
  return showPokaSheet<BackupReminderInterval>(
    context: context,
    persistent: false,
    fitContent: true,
    builder: (context) => _BackupReminderSheet(currentInterval: currentInterval),
  );
}

class _BackupReminderSheet extends StatelessWidget {
  const _BackupReminderSheet({required this.currentInterval});

  final BackupReminderInterval currentInterval;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return PokaSheet(
      title: t.backup.reminder,
      isScrollable: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PokaSheetActionItem(
            title: t.backup.reminderOff,
            icon: FPhosphorIcons.bellSlash,
            trailing: currentInterval == BackupReminderInterval.off
                ? Icon(FPhosphorIcons.check, color: context.theme.colors.primary)
                : null,
            onTap: () => Navigator.of(context).pop(BackupReminderInterval.off),
          ),
          PokaSheetActionItem(
            title: t.backup.reminderWeekly,
            icon: FPhosphorIcons.calendarDots,
            trailing: currentInterval == BackupReminderInterval.weekly
                ? Icon(FPhosphorIcons.check, color: context.theme.colors.primary)
                : null,
            onTap: () => Navigator.of(context).pop(BackupReminderInterval.weekly),
          ),
          PokaSheetActionItem(
            title: t.backup.reminderMonthly,
            icon: FPhosphorIcons.calendar,
            trailing: currentInterval == BackupReminderInterval.monthly
                ? Icon(FPhosphorIcons.check, color: context.theme.colors.primary)
                : null,
            onTap: () => Navigator.of(context).pop(BackupReminderInterval.monthly),
          ),
        ],
      ),
    );
  }
}
