import 'package:flutter/material.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';

enum BackupAction { backup, restore }

Future<BackupAction?> showBackupRestoreActionSheet(BuildContext context) async {
  return showPokaSheet<BackupAction>(
    context: context,
    builder: (context) => const _BackupRestoreActionSheet(),
  );
}

class _BackupRestoreActionSheet extends StatelessWidget {
  const _BackupRestoreActionSheet();

  @override
  Widget build(BuildContext context) {
    return PokaSheet(
      title: context.t.backup.title,
      isScrollable: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PokaSheetActionItem(
            title: context.t.backup.backupAction,
            subtitle: context.t.settings.backupRestoreDesc,
            icon: FPhosphorIcons.uploadSimple,
            onTap: () => Navigator.of(context).pop(BackupAction.backup),
          ),
          PokaSheetActionItem(
            title: context.t.backup.restoreAction,
            subtitle: context.t.settings.backupRestoreDesc,
            icon: FPhosphorIcons.downloadSimple,
            onTap: () => Navigator.of(context).pop(BackupAction.restore),
          ),
        ],
      ),
    );
  }
}
