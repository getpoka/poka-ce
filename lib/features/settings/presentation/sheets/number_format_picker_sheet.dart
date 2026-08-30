import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';

Future<String?> showNumberFormatPickerSheet(BuildContext context, String currentFormat) {
  return showPokaSheet<String>(
    context: context,
    builder: (context) => PokaSheet(
      title: context.t.settings.selectNumberFormat,
      isScrollable: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PokaSheetActionItem(
            title: context.t.settings.formatSystem,
            icon: FPhosphorIcons.devices,
            trailing: currentFormat == 'system'
                ? Icon(FPhosphorIcons.check, color: context.theme.colors.primary)
                : null,
            onTap: () => Navigator.of(context).pop('system'),
          ),
          PokaSheetActionItem(
            title: context.t.settings.formatId,
            icon: FPhosphorIcons.coins,
            trailing: currentFormat == 'id_ID' ? Icon(FPhosphorIcons.check, color: context.theme.colors.primary) : null,
            onTap: () => Navigator.of(context).pop('id_ID'),
          ),
          PokaSheetActionItem(
            title: context.t.settings.formatUs,
            icon: FPhosphorIcons.currencyDollar,
            trailing: currentFormat == 'en_US' ? Icon(FPhosphorIcons.check, color: context.theme.colors.primary) : null,
            onTap: () => Navigator.of(context).pop('en_US'),
          ),
          PokaSheetActionItem(
            title: context.t.settings.formatFr,
            icon: FPhosphorIcons.currencyEur,
            trailing: currentFormat == 'fr_FR' ? Icon(FPhosphorIcons.check, color: context.theme.colors.primary) : null,
            onTap: () => Navigator.of(context).pop('fr_FR'),
          ),
        ],
      ),
    ),
  );
}
