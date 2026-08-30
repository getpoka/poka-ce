import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/router/router.dart';
import 'package:poka_ce/features/accounts/domain/account_aggregate.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/cards/account_mini_card.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/forms/account_form_sheet.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/dialogs/poka_confirm_dialog.dart';

class AccountGrid extends ConsumerWidget {
  const AccountGrid({
    required this.aggregates,
    required this.totalAssets,
    super.key,
  });

  final List<AccountAggregate> aggregates;
  final double totalAssets;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ReorderableBuilder<Widget>(
        dragChildBoxDecoration: const BoxDecoration(),
        onReorderPositions: (positions) {
          for (final pos in positions) {
            ref.read(accountListProvider.notifier).reorderAccounts(pos.oldIndex, pos.newIndex);
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
        children: aggregates.map((aggregate) {
          return AccountMiniCard(
            key: ValueKey(aggregate.account.id),
            account: aggregate.account,
            balance: aggregate.totalBalance,
            ratio: aggregate.calculateRatio(totalAssets),
            ratioLabel: aggregate.formatRatioLabel(totalAssets),
            pocketCount: aggregate.pockets.length,
            onEdit: () => AccountFormSheet.show(context, initialAccount: aggregate.account),
            onDelete: () async {
              final confirm = await showPokaConfirmDialog(
                context,
                title: t.accounts.deleteAccount,
                body: t.accounts.areYouSureYouWantToDeleteThisAccountItWillBeHiddenFromTheApp,
                confirmText: t.accounts.delete,
              );
              if (confirm == true) {
                await ref.read(accountListProvider.notifier).deleteAccount(aggregate.account.id);
              }
            },
            onTap: () => AccountDetailRoute(aggregate.account.id).push<void>(context),
          );
        }).toList(),
      ),
    );
  }
}
