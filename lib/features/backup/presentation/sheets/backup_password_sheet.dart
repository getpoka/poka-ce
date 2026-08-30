import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/backup/presentation/controllers/backup_form_notifier.dart';
import 'package:poka_ce/features/backup/presentation/widgets/forms/backup_password_form.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';

Future<String?> showBackupPasswordSheet(
  BuildContext context, {
  required bool isBackup,
  Future<bool> Function(String)? onValidateRestore,
  String? filePath,
}) async {
  return showPokaSheet<String>(
    context: context,
    builder: (context) => _BackupPasswordSheet(
      isBackup: isBackup,
      onValidateRestore: onValidateRestore,
      filePath: filePath,
    ),
  );
}

class _BackupPasswordSheet extends HookConsumerWidget {
  const _BackupPasswordSheet({
    required this.isBackup,
    this.onValidateRestore,
    this.filePath,
  });

  final bool isBackup;
  final Future<bool> Function(String)? onValidateRestore;
  final String? filePath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordController = useTextEditingController();
    final confirmController = useTextEditingController();

    final formState = ref.watch(backupFormProvider);
    final formNotifier = ref.read(backupFormProvider.notifier);

    Future<void> submit() async {
      final success = await formNotifier.submit(
        password: passwordController.text,
        confirmPassword: confirmController.text,
        isBackup: isBackup,
        passwordRequiredText: context.t.backup.passwordRequired,
        passwordsDoNotMatchText: context.t.backup.passwordsDoNotMatch,
        incorrectPasswordText: context.t.backup.incorrectPassword,
        onValidateRestore: onValidateRestore,
      );

      if (success && context.mounted) {
        Navigator.of(context).pop(passwordController.text);
      }
    }

    return PokaSheet(
      title: isBackup ? context.t.backup.enterPasswordToEncrypt : context.t.backup.enterPasswordToDecrypt,
      child: BackupPasswordForm(
        isBackup: isBackup,
        filePath: filePath,
        passwordController: passwordController,
        confirmController: confirmController,
        passwordError: formState.passwordError,
        confirmError: formState.confirmError,
        isSubmitting: formState.isSubmitting,
        onSubmit: submit,
      ),
    );
  }
}
