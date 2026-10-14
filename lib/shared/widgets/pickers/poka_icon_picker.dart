import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';
import 'package:poka_ce/theme/theme.dart';

/// A sheet widget for searching and selecting an icon across categorized sections.
class PokaIconPicker extends HookWidget {
  /// Creates a [PokaIconPicker] with the currently [selectedIcon] and [onIconSelected] callback.
  const new({required this.selectedIcon, required this.onIconSelected, super.key});

  /// The currently selected icon identifier, if any.
  final String? selectedIcon;

  /// Callback triggered when an icon is selected.
  final ValueChanged<String> onIconSelected;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final searchController = useTextEditingController();
    useListenable(searchController);
    final query = searchController.text.trim();

    final screenHeight = MediaQuery.sizeOf(context).height;
    final pickerHeight = screenHeight > 0 ? screenHeight * 0.65 : 420.0;

    return SizedBox(
      height: pickerHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FTextField(
            control: FTextFieldControl.managed(controller: searchController),
            hint: t.categories.searchIcons,
            prefixBuilder: (context, style, variants) => FTextField.prefixIconBuilder(
              context,
              style,
              variants,
              const Icon(FPhosphorIcons.magnifyingGlass, size: 18),
            ),
            clearable: (value) => value.text.isNotEmpty,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: query.isEmpty
                ? _buildCategorizedSections(context, theme)
                : _buildSearchResults(context, theme, query),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorizedSections(BuildContext context, FThemeData theme) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: IconUtil.categories.length,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final category = IconUtil.categories[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PokaSectionLabel(title: category.name),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: category.icons.entries.map((entry) {
                final iconName = entry.key;
                final iconData = entry.value;
                final isSelected = selectedIcon == iconName;

                return _IconTile(
                  iconName: iconName,
                  iconData: iconData,
                  isSelected: isSelected,
                  onTap: () => onIconSelected(iconName),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchResults(BuildContext context, FThemeData theme, String query) {
    final searchResults = IconUtil.searchIcons(query);

    if (searchResults.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(color: theme.colors.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Icon(FPhosphorIcons.magnifyingGlass, size: 32, color: theme.colors.primary),
                ),
              ),
              const SizedBox(height: 16),
              Text(t.categories.noIconsFound, style: theme.typography.titleCard),
              const SizedBox(height: 4),
              Text(
                t.categories.weCouldntFindAnyIconMatching(search: query),
                style: theme.typography.bodyPrimary.copyWith(color: theme.colors.mutedForeground),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 16),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: searchResults.entries.map((entry) {
          final iconName = entry.key;
          final iconData = entry.value;
          final isSelected = selectedIcon == iconName;

          return _IconTile(
            iconName: iconName,
            iconData: iconData,
            isSelected: isSelected,
            onTap: () => onIconSelected(iconName),
          );
        }).toList(),
      ),
    );
  }
}

class _IconTile extends StatelessWidget {
  const new({required this.iconName, required this.iconData, required this.isSelected, required this.onTap});

  final String iconName;
  final IconData iconData;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? theme.colors.primary.withValues(alpha: 0.1) : theme.colors.background,
          borderRadius: theme.style.borderRadius.md,
          border: Border.all(color: isSelected ? theme.colors.primary : theme.colors.border, width: isSelected ? 2 : 1),
        ),
        child: Icon(iconData, size: 24, color: isSelected ? theme.colors.primary : theme.colors.foreground),
      ),
    );
  }
}
