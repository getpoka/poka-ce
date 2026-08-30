import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/pickers/poka_icon_picker.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';

class CategoryIconPickerButton extends StatelessWidget {
  const CategoryIconPickerButton({
    required this.selectedIcon,
    required this.selectedColor,
    required this.onIconSelected,
    super.key,
  });

  final String? selectedIcon;
  final String? selectedColor;
  final ValueChanged<String> onIconSelected;

  @override
  Widget build(BuildContext context) {
    final color = selectedColor?.toColor() ?? context.theme.colors.primary;

    return GestureDetector(
      onTap: () {
        showPokaSheet<void>(
          context: context,
          builder: (context) => PokaSheet(
            title: t.categories.selectIcon,
            child: PokaIconPicker(
              selectedIcon: selectedIcon,
              onIconSelected: (icon) {
                onIconSelected(icon);
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
      child: Container(
        width: 84,
        height: 84,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Icon(
                IconUtil.getIcon(selectedIcon),
                size: 40,
                color: color,
              ),
            ),
            Positioned(
              bottom: -4,
              right: -4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: context.theme.colors.background,
                  shape: BoxShape.circle,
                  border: Border.all(color: context.theme.colors.border),
                ),
                child: Icon(
                  FPhosphorIcons.pencilSimple,
                  size: 16,
                  color: context.theme.colors.foreground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
