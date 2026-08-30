import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';

class SettingsMenuSection extends StatelessWidget {
  const SettingsMenuSection({
    required this.title,
    required this.items,
    super.key,
  });

  final String title;
  final List<FItemMixin> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PokaSectionLabel(title: title),
        const SizedBox(height: 8),
        FItemGroup(
          children: items,
        ),
      ],
    );
  }
}
