import 'package:flutter/material.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class BackupPasswordForm extends StatelessWidget {
  const BackupPasswordForm({
    required this.isBackup,
    required this.passwordController,
    required this.confirmController,
    required this.isSubmitting,
    required this.onSubmit,
    super.key,
    this.filePath,
    this.passwordError,
    this.confirmError,
  });

  final bool isBackup;
  final String? filePath;
  final TextEditingController passwordController;
  final TextEditingController confirmController;
  final String? passwordError;
  final String? confirmError;
  final bool isSubmitting;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!isBackup && filePath != null) ...[
          Text(
            filePath!,
            style: context.theme.typography.bodyPrimary.copyWith(
              color: context.theme.colors.mutedForeground,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
        ],
        FTextField.password(
          control: FTextFieldControl.managed(controller: passwordController),
          label: Text(context.t.backup.password),
          error: passwordError != null ? Text(passwordError!) : null,
          textInputAction: isBackup ? TextInputAction.next : TextInputAction.done,
          enabled: !isSubmitting,
        ),
        if (isBackup) ...[
          const SizedBox(height: 16),
          FTextField.password(
            control: FTextFieldControl.managed(controller: confirmController),
            label: Text(context.t.backup.confirmPassword),
            error: confirmError != null ? Text(confirmError!) : null,
            textInputAction: TextInputAction.done,
            enabled: !isSubmitting,
          ),
        ],
        const SizedBox(height: 24),
        FButton(
          onPress: isSubmitting ? null : onSubmit,
          prefix: isSubmitting ? const FCircularProgress() : null,
          child: Text(context.t.common.confirm),
        ),
      ],
    );
  }
}
