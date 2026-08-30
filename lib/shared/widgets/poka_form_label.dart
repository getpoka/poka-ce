import 'package:flutter/material.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class PokaFormLabel extends StatelessWidget {
  const PokaFormLabel(
    this.title, {
    this.isOptional = false,
    super.key,
  });

  final String title;
  final bool isOptional;

  @override
  Widget build(BuildContext context) {
    if (!isOptional) {
      return Text(title);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(
          t.shared.optional,
          style: context.theme.typography.bodySecondary.copyWith(
            color: context.theme.colors.mutedForeground,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
