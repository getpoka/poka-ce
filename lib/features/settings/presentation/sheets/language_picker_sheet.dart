import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';

Future<String?> showLanguagePickerSheet(BuildContext context, String currentLanguage) {
  return showPokaSheet<String>(
    context: context,
    builder: (context) => PokaSheet(
      title: context.t.settings.selectLanguage,
      isScrollable: false,
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
        ],
      ),
    ),
  );
}
