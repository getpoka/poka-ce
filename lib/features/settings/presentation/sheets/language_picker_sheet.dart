import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';

/// Shows the language picker sheet and returns the selected locale code.
Future<String?> showLanguagePickerSheet(BuildContext context, String currentLanguage) {
  return showPokaSheet<String>(
    context: context,
    builder: (context) => PokaSheet(
      title: context.t.settings.selectLanguage,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PokaSheetActionItem(
            title: context.t.settings.english,
            icon: FPhosphorIcons.translate,
            trailing: currentLanguage == 'en' ? Icon(FPhosphorIcons.check, color: context.theme.colors.primary) : null,
            onTap: () => Navigator.of(context).pop('en'),
          ),
          PokaSheetActionItem(
            title: context.t.settings.indonesia,
            icon: FPhosphorIcons.translate,
            trailing: currentLanguage == 'id' ? Icon(FPhosphorIcons.check, color: context.theme.colors.primary) : null,
            onTap: () => Navigator.of(context).pop('id'),
          ),
          PokaSheetActionItem(
            title: context.t.settings.malay,
            icon: FPhosphorIcons.translate,
            trailing: currentLanguage == 'ms' ? Icon(FPhosphorIcons.check, color: context.theme.colors.primary) : null,
            onTap: () => Navigator.of(context).pop('ms'),
          ),
          PokaSheetActionItem(
            title: context.t.settings.vietnam,
            icon: FPhosphorIcons.translate,
            trailing: currentLanguage == 'vi' ? Icon(FPhosphorIcons.check, color: context.theme.colors.primary) : null,
            onTap: () => Navigator.of(context).pop('vi'),
          ),
          PokaSheetActionItem(
            title: context.t.settings.russian,
            icon: FPhosphorIcons.translate,
            trailing: currentLanguage == 'ru' ? Icon(FPhosphorIcons.check, color: context.theme.colors.primary) : null,
            onTap: () => Navigator.of(context).pop('ru'),
          ),
          PokaSheetActionItem(
            title: context.t.settings.spanish,
            icon: FPhosphorIcons.translate,
            trailing: currentLanguage == 'es' ? Icon(FPhosphorIcons.check, color: context.theme.colors.primary) : null,
            onTap: () => Navigator.of(context).pop('es'),
          ),
          PokaSheetActionItem(
            title: context.t.settings.portuguese,
            icon: FPhosphorIcons.translate,
            trailing: currentLanguage == 'pt' ? Icon(FPhosphorIcons.check, color: context.theme.colors.primary) : null,
            onTap: () => Navigator.of(context).pop('pt'),
          ),
          PokaSheetActionItem(
            title: context.t.settings.german,
            icon: FPhosphorIcons.translate,
            trailing: currentLanguage == 'de' ? Icon(FPhosphorIcons.check, color: context.theme.colors.primary) : null,
            onTap: () => Navigator.of(context).pop('de'),
          ),
        ],
      ),
    ),
  );
}
