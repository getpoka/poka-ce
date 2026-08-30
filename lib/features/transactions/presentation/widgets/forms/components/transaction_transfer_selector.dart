import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/shared/widgets/poka_pocket_selector.dart';
import 'package:poka_ce/theme/theme.dart';

class TransactionTransferSelector extends StatelessWidget {
  const TransactionTransferSelector({
    required this.accounts,
    required this.fromAccount,
    required this.toAccount,
    required this.onPickFromAccount,
    required this.onPickToAccount,
    required this.onSwapAccounts,
    super.key,
  });

  final List<AccountModel> accounts;
  final AccountModel? fromAccount;
  final AccountModel? toAccount;
  final ValueChanged<AccountModel> onPickFromAccount;
  final ValueChanged<AccountModel> onPickToAccount;
  final VoidCallback onSwapAccounts;

  Color _accountColor(AccountModel a) {
    return Color(int.parse(a.color?.replaceFirst('#', '0xFF') ?? '0xFF94A3B8'));
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    if (accounts.isEmpty) {
      return SizedBox(
        height: 50,
        child: Center(child: Text(t.transactions.noAccountsAvailable)),
      );
    }

    final effectiveFrom = fromAccount ?? accounts.first;
    final effectiveTo = toAccount ?? (accounts.length > 1 ? accounts[1] : accounts.first);

    final fromColor = _accountColor(effectiveFrom);
    final toColor = _accountColor(effectiveTo);

    Future<void> pickAccount({required bool isFrom}) async {
      final acc = await PokaPocketSelector.show(
        context,
        title: isFrom ? 'From Account' : 'To Account',
        accounts: accounts,
        selectedId: isFrom ? effectiveFrom.id : effectiveTo.id,
      );
      if (acc != null) {
        await HapticFeedback.selectionClick();
        if (isFrom) {
          onPickFromAccount(acc);
        } else {
          onPickToAccount(acc);
        }
      }
    }

    return SizedBox(
      height: 50,

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => pickAccount(isFrom: true),
              child: _TransactionTransferChip(
                theme: theme,
                label: t.transactions.from,
                account: effectiveFrom,
                color: fromColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: _TransactionSwapButton(
                theme: theme,
                onTap: onSwapAccounts,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => pickAccount(isFrom: false),
              child: _TransactionTransferChip(
                theme: theme,
                label: t.transactions.to,
                account: effectiveTo,
                color: toColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionSwapButton extends StatelessWidget {
  const _TransactionSwapButton({required this.theme, required this.onTap});

  final FThemeData theme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final transferColor = theme.colors.primary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: transferColor.withValues(alpha: 0.08),
          shape: BoxShape.circle,
          border: Border.all(
            color: transferColor.withValues(alpha: 0.25),
          ),
        ),
        child: Center(
          child: Icon(
            FPhosphorIcons.arrowsDownUp,
            size: 15,
            color: transferColor,
          ),
        ),
      ),
    );
  }
}

class _TransactionTransferChip extends StatelessWidget {
  const _TransactionTransferChip({
    required this.theme,
    required this.label,
    required this.account,
    required this.color,
  });

  final FThemeData theme;
  final String label;
  final AccountModel account;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: theme.style.borderRadius.md,
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          PokaIcon(
            icon: IconUtil.getIcon(account.icon),
            shape: PokaIconShape.circle,
            size: PokaIconSize.small,
            color: color,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: theme.typography.bodySecondary.copyWith(
                    color: theme.colors.mutedForeground,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  account.name,
                  style: theme.typography.bodyPrimary.copyWith(
                    color: theme.colors.foreground,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Icon(
            FPhosphorIcons.caretDown,
            size: 12,
            color: theme.colors.muted,
          ),
        ],
      ),
    );
  }
}
