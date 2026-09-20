import 'package:flutter/material.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';
import 'package:poka_ce/theme/theme.dart';

/// Interactive tile allowing users to select the parent account where a goal pocket is anchored.
class GoalAccountPickerTile extends StatelessWidget {
  /// Creates a [GoalAccountPickerTile].
  const new({
    required this.accounts,
    required this.selectedAccountId,
    required this.isEditing,
    required this.onAccountSelected,
    super.key,
  });

  /// Available parent root accounts.
  final List<AccountModel> accounts;

  /// ID of the currently selected parent account.
  final String? selectedAccountId;

  /// Whether the parent form is in edit mode (locks parent account reassignment).
  final bool isEditing;

  /// Callback fired when an account is tapped.
  final ValueChanged<String> onAccountSelected;

  AccountModel? get _selectedAccount => accounts.where((a) => a.id == selectedAccountId).firstOrNull;

  void _openSelectionSheet(BuildContext context) {
    showPokaSheet<void>(
      context: context,
      builder: (ctx) => PokaSheet(
        title: t.goals.selectAccount,
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: accounts.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (ctx, index) {
            final acc = accounts[index];
            final isSel = acc.id == selectedAccountId;
            return GestureDetector(
              onTap: () {
                onAccountSelected(acc.id);
                Navigator.of(ctx).pop();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: isSel ? ctx.theme.colors.primary.withValues(alpha: 0.1) : ctx.theme.colors.card,
                  borderRadius: ctx.theme.style.borderRadius.md,
                  border: Border.all(
                    color: isSel ? ctx.theme.colors.primary : ctx.theme.colors.border,
                    width: isSel ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    PokaIcon(
                      icon: IconUtil.getIcon(acc.icon),
                      color: acc.color?.toColor() ?? ctx.theme.colors.primary,
                      size: PokaIconSize.small,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        acc.name,
                        style: ctx.theme.typography.bodyPrimary.copyWith(
                          fontWeight: isSel ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                    if (isSel) Icon(FPhosphorIcons.checkCircle, size: 18, color: ctx.theme.colors.primary),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final account = _selectedAccount;

    // Edit mode: parent account is permanently anchored to prevent pocket orphaned states
    if (isEditing) {
      if (account == null) return const SizedBox.shrink();
      return FLabel(
        layout: FLabelLayout.vertical,
        label: Text(t.goals.saveInAccount),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: theme.colors.muted,
            borderRadius: theme.style.borderRadius.md,
            border: Border.all(color: theme.colors.border),
          ),
          child: Row(
            children: [
              PokaIcon(
                icon: IconUtil.getIcon(account.icon),
                color: account.color?.toColor() ?? theme.colors.primary,
                size: PokaIconSize.small,
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(account.name, style: theme.typography.bodyPrimary)),
              Icon(FPhosphorIcons.lock, size: 16, color: theme.colors.mutedForeground),
            ],
          ),
        ),
      );
    }

    // Create mode: allows selecting a root account via bottom sheet
    return FLabel(
      layout: FLabelLayout.vertical,
      label: Text(t.goals.saveInAccount),
      child: GestureDetector(
        onTap: () => _openSelectionSheet(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: theme.colors.card,
            borderRadius: theme.style.borderRadius.md,
            border: Border.all(color: theme.colors.border),
          ),
          child: Row(
            children: [
              if (account != null) ...[
                PokaIcon(
                  icon: IconUtil.getIcon(account.icon),
                  color: account.color?.toColor() ?? theme.colors.primary,
                  size: PokaIconSize.small,
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(account.name, style: theme.typography.bodyPrimary)),
              ] else ...[
                Icon(FPhosphorIcons.wallet, size: 20, color: theme.colors.mutedForeground),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    t.goals.selectAccount,
                    style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
                  ),
                ),
              ],
              Icon(FPhosphorIcons.caretDown, size: 16, color: theme.colors.mutedForeground),
            ],
          ),
        ),
      ),
    );
  }
}
