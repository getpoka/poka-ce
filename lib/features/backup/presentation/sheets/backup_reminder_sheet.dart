import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/backup/domain/backup_reminder_service.dart';
import 'package:poka_ce/features/backup/presentation/sheets/notification_permission_sheet.dart';
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

class _BackupReminderSheet extends ConsumerWidget {
  const _BackupReminderSheet({required this.currentInterval});

  final BackupReminderInterval currentInterval;

  Future<void> _selectInterval(
    BuildContext context,
    WidgetRef ref,
    BackupReminderInterval interval,
  ) async {
    if (interval == BackupReminderInterval.off) {
      Navigator.of(context).pop(interval);
      return;
    }

    final reminderService = ref.read(backupReminderServiceProvider);
    var hasPermission = await reminderService.hasNotificationPermission();

    if (!hasPermission && context.mounted) {
      final proceed = await showNotificationRationaleSheet(context);
      if (proceed == true) {
        hasPermission = await reminderService.requestNotificationPermission();
      }
    }

    if (!context.mounted) return;

    if (hasPermission) {
      Navigator.of(context).pop(interval);
    } else {
      showFToast(
        context: context,
        title: Text(context.t.backup.permissionDenied),
        variant: FToastVariant.destructive,
      );
    }
  }

  Future<void> _testNotification(BuildContext context, WidgetRef ref) async {
    final reminderService = ref.read(backupReminderServiceProvider);
    var hasPermission = await reminderService.hasNotificationPermission();

    if (!hasPermission && context.mounted) {
      final proceed = await showNotificationRationaleSheet(context);
      if (proceed == true) {
        hasPermission = await reminderService.requestNotificationPermission();
      }
    }

    if (!context.mounted) return;

    if (hasPermission) {
      await reminderService.triggerTestReminder();
      if (context.mounted) {
        Navigator.of(context).pop();
        showFToast(
          context: context,
          title: Text(context.t.backup.testNotificationSent),
        );
      }
    } else {
      showFToast(
        context: context,
        title: Text(context.t.backup.permissionDenied),
        variant: FToastVariant.destructive,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            onTap: () => _selectInterval(context, ref, BackupReminderInterval.off),
          ),
          PokaSheetActionItem(
            title: t.backup.reminderWeekly,
            icon: FPhosphorIcons.calendarDots,
            trailing: currentInterval == BackupReminderInterval.weekly
                ? Icon(FPhosphorIcons.check, color: context.theme.colors.primary)
                : null,
            onTap: () => _selectInterval(context, ref, BackupReminderInterval.weekly),
          ),
          PokaSheetActionItem(
            title: t.backup.reminderMonthly,
            icon: FPhosphorIcons.calendar,
            trailing: currentInterval == BackupReminderInterval.monthly
                ? Icon(FPhosphorIcons.check, color: context.theme.colors.primary)
                : null,
            onTap: () => _selectInterval(context, ref, BackupReminderInterval.monthly),
          ),
          const SizedBox(height: 8),
          PokaSheetActionItem(
            title: t.backup.sendTestNotification,
            icon: FPhosphorIcons.bellSimpleRinging,
            onTap: () => _testNotification(context, ref),
          ),
        ],
      ),
    );
  }
}
