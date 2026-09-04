import 'package:flutter/material.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/theme/theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Aligned Tile Content
// ─────────────────────────────────────────────────────────────────────────────

class TransactionTileContent extends StatelessWidget {
  const TransactionTileContent({
    required this.catLabel,
    required this.catColor,
    required this.hasMultipleItems,
    required this.itemCount,
    required this.amount,
    required this.type,
    required this.isBalanceVisible,
    required this.isTransfer,
    this.accLabel,
    this.accIcon,
    this.accColor,
    this.destAccLabel,
    this.destAccColor,
    this.timeStr,
    this.note,
    this.allocation,
    this.hasDebt = false,
    this.isRecurring = false,
    super.key,
  });

  final String catLabel;
  final Color catColor;
  final bool hasMultipleItems;
  final int itemCount;
  final int amount;
  final TransactionType type;
  final bool isBalanceVisible;
  final String? accLabel;
  final IconData? accIcon;
  final Color? accColor;
  final String? destAccLabel;
  final Color? destAccColor;
  final bool isTransfer;
  final String? timeStr;
  final String? note;
  final TransactionAllocation? allocation;
  final bool hasDebt;
  final bool isRecurring;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Row 1: Category Name & Amount
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      catLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.typography.bodySecondary.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  if (hasMultipleItems) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: catColor.withValues(alpha: theme.style.app.iconBgOpacity),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: catColor.withValues(alpha: theme.style.app.iconBorderOpacity),
                          width: theme.style.borderWidth,
                        ),
                      ),
                      child: Text(
                        '$itemCount',
                        style: theme.typography.labelBadge.copyWith(
                          color: catColor,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            PokaAmountText(
              amount: amount,
              type: type,
              isObscured: !isBalanceVisible,
              style: theme.typography.amountTile,
            ),
          ],
        ),

        // Row 2: Account & Time
        if (accLabel != null || timeStr != null) ...[
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: accLabel != null && accIcon != null && accColor != null
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(accIcon, size: 10, color: accColor),
                          const SizedBox(width: 3),
                          Flexible(
                            child: Text(
                              accLabel!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.typography.caption.copyWith(
                                color: accColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (isTransfer && destAccLabel != null) ...[
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Icon(FPhosphorIcons.arrowRight, size: 9),
                            ),
                            Flexible(
                              child: Text(
                                destAccLabel!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.typography.caption.copyWith(
                                  color: destAccColor ?? theme.colors.mutedForeground,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
              if (timeStr != null) ...[
                const SizedBox(width: 8),
                Text(
                  timeStr!,
                  style: theme.typography.caption.copyWith(
                    color: theme.colors.mutedForeground,
                  ),
                ),
              ],
            ],
          ),
        ],

        // Row 3: Note & Allocation (Always render to maintain fixed height)
        const SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                (note != null && note!.isNotEmpty) ? note! : ' ', // Space preserves height
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.typography.bodySecondary.copyWith(
                  color: theme.colors.mutedForeground,
                ),
              ),
            ),
            if (hasDebt || isRecurring) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: (hasDebt ? theme.colors.destructive : theme.colors.primary).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: (hasDebt ? theme.colors.destructive : theme.colors.primary).withValues(alpha: 0.2),
                    width: 0.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      hasDebt ? FPhosphorIcons.handshake : FPhosphorIcons.repeat,
                      size: 9,
                      color: hasDebt ? theme.colors.destructive : theme.colors.primary,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      hasDebt ? 'Debt' : 'Recurring',
                      style: theme.typography.labelBadge.copyWith(
                        color: hasDebt ? theme.colors.destructive : theme.colors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (allocation != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: theme.colors.primary.withValues(alpha: 0.2),
                    width: 0.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(FPhosphorIcons.chartPieSlice, size: 9, color: theme.colors.primary),
                    const SizedBox(width: 3),
                    Text(
                      '${allocation!.name[0].toUpperCase()}${allocation!.name.substring(1)}',
                      style: theme.typography.labelBadge.copyWith(
                        color: theme.colors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ], // Closes Row's children
        ), // Closes Row
      ],
    ); // Closes Column's children and Column
  }
}
