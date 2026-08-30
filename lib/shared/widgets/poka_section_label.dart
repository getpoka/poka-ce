import 'package:flutter/material.dart';
import 'package:poka_ce/theme/theme.dart';

class PokaSectionLabel extends StatelessWidget {
  const PokaSectionLabel({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            color: theme.colors.primary,
            borderRadius: theme.style.borderRadius.xs,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title.toUpperCase(),
          style: theme.typography.labelSection.copyWith(
            color: theme.colors.mutedForeground,
          ),
        ),
      ],
    );
  }
}
