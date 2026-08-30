import 'package:flutter/material.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/features/settings/presentation/sheets/currency_picker_sheet.dart';
import 'package:poka_ce/features/settings/presentation/sheets/language_picker_sheet.dart';
import 'package:poka_ce/features/settings/presentation/sheets/number_format_picker_sheet.dart';
import 'package:poka_ce/features/settings/presentation/sheets/theme_picker_sheet.dart';
import 'package:poka_ce/features/settings/presentation/widgets/settings_menu_item.dart';
import 'package:poka_ce/features/settings/presentation/widgets/settings_menu_section.dart';
import 'package:poka_ce/i18n/strings.g.dart';

class PreferencesSection extends ConsumerWidget {
  const PreferencesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsProvider);
    final currentCurrency = settingsState.settings?.baseCurrency?.code ?? 'Not Set';
    final currentTheme = settingsState.settings?.themeMode ?? 'System';
    final currentLanguage = settingsState.settings?.language ?? 'system';
    final currentNumberFormat = settingsState.settings?.numberFormat ?? 'system';

    return SettingsMenuSection(
      title: context.t.settings.preferences,
      items: [
        SettingsMenuItem(
          title: context.t.settings.theme,
          subtitle: currentTheme == 'system'
              ? context.t.settings.system
              : (currentTheme == 'light' ? context.t.settings.themeLight : context.t.settings.themeDark),
          icon: FPhosphorIcons.palette,
          onTap: () async {
            final selected = await showThemePickerSheet(context, currentTheme);
            if (selected != null) {
              await ref.read(settingsProvider.notifier).setThemeMode(selected);
            }
          },
        ),
        SettingsMenuItem(
          title: context.t.settings.language,
          subtitle: currentLanguage == 'system'
              ? context.t.settings.system
              : (currentLanguage == 'id' ? context.t.settings.indonesia : context.t.settings.english),
          icon: FPhosphorIcons.translate,
          onTap: () async {
            final selected = await showLanguagePickerSheet(context, currentLanguage);
            if (selected != null) {
              await ref.read(settingsProvider.notifier).setLanguage(selected);
            }
          },
        ),
        SettingsMenuItem(
          title: context.t.settings.baseCurrency,
          subtitle: currentCurrency,
          icon: FPhosphorIcons.currencyDollar,
          onTap: () async {
            final currencies = await ref.read(settingsProvider.notifier).getAvailableCurrencies();
            if (!context.mounted) return;
            final selected = await showCurrencyPickerSheet(context, currencies, settingsState.settings?.baseCurrency);
            if (selected != null) {
              await ref.read(settingsProvider.notifier).setBaseCurrency(selected.id);
            }
          },
        ),
        SettingsMenuItem(
          title: context.t.settings.numberFormat,
          subtitle: currentNumberFormat == 'system'
              ? context.t.settings.formatSystem
              : (currentNumberFormat == 'id_ID'
                    ? context.t.settings.formatId
                    : (currentNumberFormat == 'en_US' ? context.t.settings.formatUs : context.t.settings.formatFr)),
          icon: FPhosphorIcons.hash,
          onTap: () async {
            final selected = await showNumberFormatPickerSheet(context, currentNumberFormat);
            if (selected != null) {
              await ref.read(settingsProvider.notifier).setNumberFormat(selected);
            }
          },
        ),
      ],
    );
  }
}
