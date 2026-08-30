import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';
import 'package:poka_ce/theme/theme.dart';

// ─────────────────────────────────────────────────────────────────────────────

class AccountMiniCard extends StatelessWidget {
  const AccountMiniCard({
    required this.account,
    required this.balance,
    required this.onTap,
    this.onEdit,
    this.onDelete,
    super.key,
    this.ratio,
    this.ratioLabel,
    this.pocketCount,
  });

  final AccountModel account;
  final int balance;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final double? ratio;
  final String? ratioLabel;
  final int? pocketCount;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final accentColor = account.color?.toColor() ?? theme.colors.primary;
    final accountIcon = IconUtil.getIcon(account.icon);

    return GestureDetector(
      onTap: onTap,
      child: FCard(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Top row: icon + 3-dot menu ──────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      PokaIcon(
                        icon: accountIcon,
                        color: accentColor,
                        size: PokaIconSize.small,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: theme.colors.muted,
                          borderRadius: theme.style.borderRadius.sm,
                        ),
                        child: Text(
                          account.type.name.toUpperCase(),
                          style: theme.typography.labelBadge.copyWith(color: theme.colors.mutedForeground),
                        ),
                      ),
                      if (pocketCount != null && pocketCount! > 0 && account.type != AccountType.goal) ...[
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: accentColor.withValues(alpha: 0.12),
                            borderRadius: theme.style.borderRadius.sm,
                          ),
                          child: Text(
                            '$pocketCount pocket${pocketCount! > 1 ? 's' : ''}',
                            style: theme.typography.labelBadge.copyWith(color: accentColor),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (onEdit != null)
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        HapticFeedback.lightImpact();
                        showPokaSheet<void>(
                          context: context,
                          fitContent: true,
                          builder: (ctx) => PokaSheet(
                            title: account.name,
                            isScrollable: false,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                PokaSheetActionItem(
                                  icon: FPhosphorIcons.pencilSimple,
                                  title: t.accounts.editAccount,
                                  subtitle: t.accounts.updateNameIconOrColor,
                                  onTap: () {
                                    Navigator.of(ctx).pop();
                                    onEdit!();
                                  },
                                ),
                                PokaSheetActionItem(
                                  icon: FPhosphorIcons.trash,
                                  title: t.accounts.deleteAccount,
                                  subtitle: t.accounts.permanentlyRemoveThisAccount,
                                  iconColor: theme.colors.destructive,
                                  titleColor: theme.colors.destructive,
                                  onTap: () {
                                    Navigator.of(ctx).pop();
                                    onDelete?.call();
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Icon(
                          FPhosphorIcons.dotsThreeVertical,
                          size: 16,
                          color: theme.colors.mutedForeground,
                        ),
                      ),
                    ),
                ],
              ),
              const Spacer(),
              Text(
                account.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.typography.body.sm.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 2),
              PokaAmountText(
                amount: balance,
                type: balance >= 0 ? TransactionType.income : TransactionType.expense,
                style: theme.typography.amountCard,
              ),
              if (ratio != null && ratioLabel != null) ...[
                const SizedBox(height: 8),
                LayoutBuilder(
                  builder: (context, constraints) => Container(
                    height: 4,
                    width: constraints.maxWidth,
                    decoration: BoxDecoration(
                      color: theme.colors.muted,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: ratio,
                        child: Container(
                          decoration: BoxDecoration(
                            color: accentColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  ratioLabel!,
                  style: theme.typography.caption.copyWith(
                    color: theme.colors.mutedForeground,
                  ),
                ),
              ] else ...[
                const SizedBox(height: 4),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
