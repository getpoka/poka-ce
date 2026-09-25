import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/router/router.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/cards/account_mini_card.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/forms/account_form_sheet.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/forms/account_reconcile_sheet.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/dialogs/poka_confirm_dialog.dart';
import 'package:poka_ce/shared/widgets/poka_empty_view.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';
import 'package:poka_ce/theme/theme.dart';

/// Section in AccountDetailPage presenting operational pockets (spending, bills, etc.).
///
/// The Main Pocket (isDefault) is hidden when it is the only pocket — the account
/// appears as a simple flat wallet. Once the user creates at least one custom pocket,
/// both the Main Pocket and all custom pockets become visible, making the split clear.
class AccountPocketsSection extends HookConsumerWidget {
  const new({required this.accountId, required this.pockets, required this.totalBalance, super.key});

  final String accountId;
  final List<AccountModel> pockets;
  final int totalBalance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    // Only custom (non-default) pockets created by the user.
    final customPockets = pockets.where((p) => !p.isDefault).toList();

    // When custom pockets exist, show all pockets (Main + custom) so the split is
    // immediately visible. When only the auto-generated Main Pocket exists, hide it
    // and show an empty state prompting the user to create their first pocket.
    final visiblePockets = customPockets.isNotEmpty ? pockets : <AccountModel>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PokaSectionLabel(title: t.accounts.pockets),
            GestureDetector(
              onTap: () => AccountFormSheet.show(context, parentAccountId: accountId),
              child: Row(
                children: [
                  Icon(FPhosphorIcons.plus, size: 14, color: theme.colors.primary),
                  const SizedBox(width: 4),
                  Text(
                    t.accounts.addPocket,
                    style: theme.typography.bodySecondary.copyWith(
                      color: theme.colors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ).animate().fade(duration: 300.ms, delay: 60.ms).slideY(begin: 0.05, end: 0),
        const SizedBox(height: 8),
        if (visiblePockets.isEmpty)
          PokaEmptyView(
            icon: FPhosphorIcons.wallet,
            title: t.accounts.noPocketsYet,
            subtitle: t.accounts.pocketsHelpYouSplitYourWalletIntoCategories,
            hasBorder: true,
          ).animate().fade(duration: 300.ms, delay: 120.ms).slideY(begin: 0.05, end: 0)
        else
          ReorderableBuilder<Widget>(
            dragChildBoxDecoration: const BoxDecoration(),
            onReorderPositions: (positions) {
              for (final pos in positions) {
                ref.read(accountListProvider.notifier).reorderAccounts(pos.oldIndex, pos.newIndex, parentId: accountId);
              }
            },
            builder: (children) {
              return GridView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.3,
                ),
                children: children,
              );
            },
            children: visiblePockets.map((pocket) {
              final ratio = totalBalance > 0 ? (pocket.balance / totalBalance).clamp(0.0, 1.0) : 0.0;
              final ratioLabel = t.accounts.ratioOfAccount(percent: (ratio * 100).toStringAsFixed(0));

              return AccountMiniCard(
                key: ValueKey(pocket.id),
                account: pocket,
                balance: pocket.balance,
                ratio: ratio,
                ratioLabel: ratioLabel,
                pocketCount: 0,
                onEdit: () => AccountFormSheet.show(context, initialAccount: pocket),
                onReconcile: () => AccountReconcileSheet.show(context, account: pocket, currentBalance: pocket.balance),
                onDelete: pocket.canDelete
                    ? () async {
                        final confirm = await showPokaConfirmDialog(
                          context,
                          title: t.accounts.deletePocket,
                          body: t.accounts.areYouSureYouWantToDeleteThisPocketItWillBeHiddenFromTheApp,
                          confirmText: t.accounts.delete,
                        );
                        if (confirm == true) {
                          await ref.read(accountListProvider.notifier).deleteAccount(pocket.id);
                        }
                      }
                    : null,
                onTap: () => AccountDetailRoute(pocket.id).push<void>(context),
              );
            }).toList(),
          ),
      ],
    );
  }
}
