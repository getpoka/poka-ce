import 'package:flutter/material.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/app/router/router.dart';
import 'package:poka_ce/core/utils/log_exporter.dart';
import 'package:poka_ce/features/settings/presentation/widgets/easter_egg_icon.dart';
import 'package:poka_ce/features/settings/presentation/widgets/settings_menu_item.dart';
import 'package:poka_ce/features/settings/presentation/widgets/settings_menu_section.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';
import 'package:poka_ce/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FScaffold(
      header: PokaHeader(
        title: t.settings.about,
        showBack: true,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.only(top: 48, bottom: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const EasterEggIcon(),
                  const SizedBox(height: 16),
                  Text(
                    t.settings.pokaCe,
                    style: theme.typography.display.sm.copyWith(
                      color: theme.colors.foreground,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: theme.colors.muted,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      const String.fromEnvironment('APP_VERSION', defaultValue: 'dev-main'),
                      style: theme.typography.caption.copyWith(color: theme.colors.mutedForeground),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  t.settings.aboutDescription,
                  textAlign: TextAlign.center,
                  style: theme.typography.bodyPrimary.copyWith(
                    color: theme.colors.mutedForeground,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 32),
                SettingsMenuSection(
                  title: t.settings.support,
                  items: [
                    SettingsMenuItem(
                      title: t.settings.helpIssues,
                      subtitle: t.settings.reportBugsOrRequestFeatures,
                      icon: FPhosphorIcons.question,
                      onTap: () => _launchUrl('https://github.com/getpoka/poka-ce/issues'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SettingsMenuSection(
                  title: t.settings.legal,
                  items: [
                    SettingsMenuItem(
                      title: t.settings.termsOfService,
                      subtitle: t.settings.readOurTermsAndConditions,
                      icon: FPhosphorIcons.fileText,
                      onTap: () => const SupportTermsRoute().push<void>(context),
                    ),
                    SettingsMenuItem(
                      title: t.settings.privacyPolicy,
                      subtitle: t.settings.learnHowWeHandleYourData,
                      icon: FPhosphorIcons.shieldCheck,
                      onTap: () => const SupportPrivacyRoute().push<void>(context),
                    ),
                    SettingsMenuItem(
                      title: t.settings.openSourceLicenses,
                      subtitle: t.settings.viewThirdpartySoftwareLicenses,
                      icon: FPhosphorIcons.code,
                      onTap: () => const SupportLicensesRoute().push<void>(context),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SettingsMenuSection(
                  title: t.settings.advanced,
                  items: [
                    SettingsMenuItem(
                      title: t.settings.exportDebugLogs,
                      subtitle: t.settings.shareErrorLogsForTroubleshooting,
                      icon: FPhosphorIcons.bug,
                      onTap: () async {
                        try {
                          await LogExporter.exportLogs();
                        } on Exception catch (_) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(t.settings.failedToExportLogs)),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  t.settings.copyright,
                  textAlign: TextAlign.center,
                  style: theme.typography.bodySecondary.copyWith(
                    color: theme.colors.mutedForeground,
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } on Exception catch (e) {
      debugPrint('Could not launch $url: $e');
    }
  }
}
