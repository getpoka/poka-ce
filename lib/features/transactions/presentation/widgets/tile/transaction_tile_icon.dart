import 'package:flutter/material.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/theme/theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Category icon badge (flat-morphism style matching old app)
// ─────────────────────────────────────────────────────────────────────────────

class TransactionTileIcon extends StatelessWidget {
  const TransactionTileIcon({
    required this.catColor,
    required this.catIcon,
    this.subCatIcon,
    this.subCatColor,
    this.isGroup = false,
    this.isExpanded = false,
    this.isSmall = false,
    super.key,
  });

  final Color catColor;
  final IconData catIcon;
  final IconData? subCatIcon;
  final Color? subCatColor;
  final bool isGroup;
  final bool isExpanded;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final size = isSmall ? PokaIconSize.small : PokaIconSize.medium;
    final boxSize = isSmall ? 36.0 : 42.0;

    return SizedBox(
      width: boxSize,
      height: boxSize,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          PokaIcon(
            icon: catIcon,
            color: catColor,
            size: size,
          ),
          if (isGroup || subCatIcon != null)
            Positioned(
              right: -5,
              bottom: -5,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: (isGroup ? theme.colors.secondary : (subCatColor ?? theme.colors.primary)).withValues(
                    alpha: 0.88,
                  ),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: theme.colors.background,
                    width: 1.5,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                ),
                child: Center(
                  child: isGroup
                      ? AnimatedRotation(
                          turns: isExpanded ? 0.5 : 0,
                          duration: const Duration(milliseconds: 280),
                          child: Icon(
                            FPhosphorIcons.caretDown,
                            size: 9,
                            color: theme.colors.secondaryForeground,
                          ),
                        )
                      : Icon(subCatIcon, size: 9, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
