import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';

Future<String?> showThemePickerSheet(BuildContext context, String currentTheme) {
  return showPokaSheet<String>(
    context: context,
    builder: (context) => PokaSheet(
      title: context.t.settings.selectTheme,
      isScrollable: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PokaSheetActionItem(
            title: context.t.settings.system,
            icon: FPhosphorIcons.devices,
            trailing: currentTheme == 'system' ? Icon(FPhosphorIcons.check, color: context.theme.colors.primary) : null,
            onTap: () => Navigator.of(context).pop('system'),
          ),
          PokaSheetActionItem(
            title: context.t.settings.themeLight,
            icon: FPhosphorIcons.sun,
            trailing: currentTheme == 'light' ? Icon(FPhosphorIcons.check, color: context.theme.colors.primary) : null,
            onTap: () => Navigator.of(context).pop('light'),
          ),
          PokaSheetActionItem(
            title: context.t.settings.themeDark,
            icon: FPhosphorIcons.moon,
            trailing: currentTheme == 'dark' ? Icon(FPhosphorIcons.check, color: context.theme.colors.primary) : null,
            onTap: () => Navigator.of(context).pop('dark'),
          ),
        ],
      ),
    ),
  );
}
