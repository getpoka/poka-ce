import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/theme/theme.dart';

class PokaIconPicker extends HookWidget {
  const PokaIconPicker({
    required this.selectedIcon,
    required this.onIconSelected,
    super.key,
  });

  final String? selectedIcon;
  final ValueChanged<String> onIconSelected;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final selectedCategory = useState<IconCategory>(IconUtil.categories.first);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: IconUtil.categories.map((category) {
              final isSelected = selectedCategory.value.name == category.name;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => selectedCategory.value = category,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? theme.colors.primary : theme.colors.secondary,
                      borderRadius: BorderRadius.circular(100), // Pill shape
                    ),
                    child: Text(
                      category.name,
                      style: theme.typography.bodyPrimary.copyWith(
                        color: isSelected ? theme.colors.primaryForeground : theme.colors.secondaryForeground,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: selectedCategory.value.icons.entries.map((entry) {
            final iconName = entry.key;
            final iconData = entry.value;
            final isSelected = selectedIcon == iconName;

            return GestureDetector(
              onTap: () => onIconSelected(iconName),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isSelected ? theme.colors.primary.withValues(alpha: 0.1) : theme.colors.background,
                  borderRadius: theme.style.borderRadius.md,
                  border: Border.all(
                    color: isSelected ? theme.colors.primary : theme.colors.border,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Icon(
                  iconData,
                  color: isSelected ? theme.colors.primary : theme.colors.foreground,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
