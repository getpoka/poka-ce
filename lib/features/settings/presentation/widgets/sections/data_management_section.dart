import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/app/router/router.dart';
import 'package:poka_ce/core/services/preferences_service.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/backup/presentation/controllers/backup_controller.dart';
import 'package:poka_ce/features/backup/presentation/sheets/backup_password_sheet.dart';
import 'package:poka_ce/features/backup/presentation/sheets/backup_restore_action_sheet.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/settings/presentation/controllers/app_lock_controller.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/features/settings/presentation/sheets/pin_setup_sheet.dart';
import 'package:poka_ce/features/settings/presentation/sheets/pin_verification_sheet.dart';
import 'package:poka_ce/features/settings/presentation/widgets/settings_menu_item.dart';
import 'package:poka_ce/features/settings/presentation/widgets/settings_menu_section.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/dialogs/poka_confirm_dialog.dart';

class DataManagementSection extends ConsumerWidget {
  const DataManagementSection({super.key});

  Future<bool> _verifySecurity(BuildContext context, WidgetRef ref) async {
    final appLockState = ref.read(appLockControllerProvider);
    if (!appLockState.isEnabled) {
      // Force setup if not active
      showFToast(
        context: context,
        title: Text(context.t.lock.setupPinBody),
      );
      final pin = await showPinSetupSheet(context);
      if (pin != null) {
        await ref.read(appLockControllerProvider.notifier).enableAppLock(pin);
        return true;
      }
      return false;
    } else {
      final verified = await showPinVerificationSheet(context);
      return verified;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsMenuSection(
      title: context.t.settings.dataManagement,
      items: [
        SettingsMenuItem(
          title: context.t.backup.title,
          subtitle: context.t.settings.backupRestoreDesc,
          icon: FPhosphorIcons.database,
          onTap: () async {
            final box = context.findRenderObject() as RenderBox?;
            final rect = box != null ? box.localToGlobal(Offset.zero) & box.size : null;
            final backupNotifier = ref.read(backupControllerProvider.notifier);

            final action = await showBackupRestoreActionSheet(context);
            if (action == null) return;
            if (!context.mounted) return;

            if (action == BackupAction.backup) {
              final isSecure = await _verifySecurity(context, ref);
              if (!isSecure) return;
              if (!context.mounted) return;

              final password = await showBackupPasswordSheet(
                context,
                isBackup: true,
                onValidateRestore: (pass) async {
                  final success = await backupNotifier.backup(
                    pass,
                    sharePositionOrigin: rect,
                  );
                  if (!success && context.mounted) {
                    showFToast(
                      context: context,
                      title: Text(context.t.common.error),
                    );
                    Navigator.of(context).pop(); // Force close on error
                  }
                  return success;
                },
              );
              if (password == null) return;

              if (!context.mounted) return;
              showFToast(
                context: context,
                title: Text(context.t.backup.backupSuccess),
              );
            } else if (action == BackupAction.restore) {
              final confirmed = await showPokaConfirmDialog(
                context,
                title: context.t.backup.restoreAction,
                body: context.t.settings.resetDataDesc,
              );
              if (confirmed != true) return;
              if (!context.mounted) return;

              final isSecure = await _verifySecurity(context, ref);
              if (!isSecure) return;
              if (!context.mounted) return;

              final result = await FilePicker.pickFiles();
              if (!context.mounted) return;

              // file_picker v12 returns List<PlatformFile>? (null if user cancels)
              // ignore: unnecessary_null_comparison
              if (result == null || result.isEmpty) return;

              final filePath = result.first.path!;
              final fileName = result.first.name;
              final container = ProviderScope.containerOf(context);

              final password = await showBackupPasswordSheet(
                context,
                isBackup: false,
                filePath: fileName,
                onValidateRestore: (pass) async {
                  final success = await container
                      .read(backupControllerProvider.notifier)
                      .restore(
                        pass,
                        filePath,
                      );
                  if (!success) {
                    final err = container.read(backupControllerProvider).error;
                    if (err != null) return Future.error(err);
                  }
                  return success;
                },
              );
              if (password == null) return;
              if (!context.mounted) return;

              // Invalidate root database provider to force recreation
              unawaited(container.read(databaseProvider).close());

              // Refresh all Riverpod state like in Reset Data
              container
                ..invalidate(databaseProvider)
                ..invalidate(settingsProvider)
                ..invalidate(dashboardProvider)
                ..invalidate(accountListProvider)
                ..invalidate(categoryListProvider)
                ..invalidate(transactionListNotifierProvider);

              showFToast(
                context: context,
                title: Text(context.t.backup.restoreSuccess),
              );

              // Redirect to home
              const DashboardRoute().go(context);
            }
          },
        ),
        SettingsMenuItem(
          title: context.t.settings.clearOld,
          subtitle: context.t.settings.clearOldDesc,
          icon: FPhosphorIcons.trashSimple,
          onTap: () async {
            final confirmed = await showPokaConfirmDialog(
              context,
              title: context.t.settings.clearOld,
              body: context.t.settings.clearOldDesc,
            );
            if (confirmed != true) return;
            if (!context.mounted) return;

            final isSecure = await _verifySecurity(context, ref);
            if (!isSecure) return;

            final oneYearAgo = DateTime.now().subtract(const Duration(days: 365));
            await ref.read(databaseProvider).transactionsDao.clearOldTransactions(oneYearAgo);

            if (!context.mounted) return;
            showFToast(
              context: context,
              title: Text(t.settings.oldTransactionsCleared),
            );
          },
        ),
        SettingsMenuItem(
          title: context.t.settings.resetData,
          subtitle: context.t.settings.resetDataDesc,
          icon: FPhosphorIcons.warning,
          onTap: () async {
            final confirmed = await showPokaConfirmDialog(
              context,
              title: context.t.settings.resetData,
              body: context.t.settings.resetDataDesc,
              confirmText: context.t.settings.resetData,
            );
            if (confirmed != true) return;
            if (!context.mounted) return;

            final isSecure = await _verifySecurity(context, ref);
            if (!isSecure) return;
            if (!context.mounted) return;

            // 1. Reset all database tables (clears tables, seeds currencies & initial settings with null baseCurrency)
            await ref.read(databaseProvider).resetAllData();

            // 2. Clear all SharedPreferences & disable App Lock / SecureStorage
            await ref.read(preferencesServiceProvider).clear();
            await ref.read(appLockControllerProvider.notifier).disableAppLock();

            // 3. Invalidate/refresh all Riverpod state
            ref
              ..invalidate(settingsProvider)
              ..invalidate(dashboardProvider)
              ..invalidate(accountListProvider)
              ..invalidate(categoryListProvider)
              ..invalidate(transactionListNotifierProvider);

            if (!context.mounted) return;
            showFToast(
              context: context,
              title: Text(t.settings.appDataReset),
            );

            // 4. Navigate directly to Onboarding
            const OnboardingRoute().go(context);
          },
        ),
      ],
    );
  }
}
