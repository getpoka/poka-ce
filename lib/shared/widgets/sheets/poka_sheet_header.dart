import 'package:flutter/material.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/theme/theme.dart';

class PokaSheetHeader extends StatelessWidget {
  const PokaSheetHeader({
    required this.title,
    this.leading,
    this.trailing,
    this.showCloseButton = true,
    super.key,
  });

  final String title;
  final Widget? leading;
  final Widget? trailing;
  final bool showCloseButton;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final effectiveTrailing =
        trailing ??
        (showCloseButton
            ? FButton.icon(
                onPress: () => Navigator.of(context).pop(),
                variant: FButtonVariant.ghost,
                child: const Icon(FPhosphorIcons.x, size: 20),
              )
            : null);

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            title,
            style: theme.typography.titleCard,
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (leading != null) leading! else const SizedBox.shrink(),
              if (effectiveTrailing != null) effectiveTrailing else const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
