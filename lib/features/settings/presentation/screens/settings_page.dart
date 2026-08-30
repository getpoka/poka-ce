import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/features/settings/presentation/widgets/sections/data_management_section.dart';
import 'package:poka_ce/features/settings/presentation/widgets/sections/preferences_section.dart';
import 'package:poka_ce/features/settings/presentation/widgets/sections/security_section.dart';
import 'package:poka_ce/features/settings/presentation/widgets/sections/support_section.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: PokaHeader(title: context.t.settings.title),
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          PreferencesSection(),
          SizedBox(height: 20),
          SecuritySection(),
          SizedBox(height: 20),
          DataManagementSection(),
          SizedBox(height: 20),
          SupportSection(),
          SizedBox(height: 20),
        ],
      ).animate().fade(duration: 400.ms).slideY(begin: 0.05, end: 0),
    );
  }
}
