import 'package:flutter/material.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/settings/presentation/controllers/app_lock_controller.dart';
import 'package:poka_ce/features/settings/presentation/sheets/pin_setup_sheet.dart';
import 'package:poka_ce/features/settings/presentation/sheets/pin_verification_sheet.dart';
import 'package:poka_ce/features/settings/presentation/widgets/settings_menu_item.dart';
import 'package:poka_ce/features/settings/presentation/widgets/settings_menu_section.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_switch.dart';

class SecuritySection extends ConsumerWidget {
  const SecuritySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLockState = ref.watch(appLockControllerProvider);

    return SettingsMenuSection(
      title: context.t.settings.security,
      items: [
        SettingsMenuItem(
          title: context.t.settings.appLock,
          subtitle: context.t.settings.appLockDesc,
          icon: FPhosphorIcons.lockKey,
          onTap: () {},
          trailing: PokaSwitch(
            value: appLockState.isEnabled,
            onChange: (value) async {
              if (value) {
                final pin = await showPinSetupSheet(context);
                if (pin != null) {
                  await ref.read(appLockControllerProvider.notifier).enableAppLock(pin);
                }
              } else {
                final success = await showPinVerificationSheet(context);
                if (success) {
                  await ref.read(appLockControllerProvider.notifier).disableAppLock();
                }
              }
            },
          ),
        ),
        SettingsMenuItem(
          title: context.t.settings.biometrics,
          subtitle: context.t.settings.biometricsDesc,
          icon: FPhosphorIcons.fingerprint,
          onTap: () {},
          trailing: PokaSwitch(
            value: appLockState.isBiometricEnabled,
            onChange: (value) async {
              if (value) {
                if (!appLockState.isEnabled) {
                  // Request PIN setup first
                  final pin = await showPinSetupSheet(context);
                  if (pin != null) {
                    await ref.read(appLockControllerProvider.notifier).enableAppLock(pin);
                  }
                  final newState = ref.read(appLockControllerProvider);
                  if (newState.isEnabled) {
                    await ref.read(appLockControllerProvider.notifier).toggleBiometric(enable: true);
                  }
                } else {
                  await ref.read(appLockControllerProvider.notifier).toggleBiometric(enable: true);
                }
              } else {
                await ref.read(appLockControllerProvider.notifier).toggleBiometric(enable: false);
              }
            },
          ),
        ),
      ],
    );
  }
}
