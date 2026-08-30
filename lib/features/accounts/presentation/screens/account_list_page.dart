import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/router/router.dart';
import 'package:poka_ce/features/accounts/domain/account_aggregate.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/cards/account_mini_card.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/cards/account_networth_card.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/forms/account_form_sheet.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/dialogs/poka_confirm_dialog.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';
import 'package:poka_ce/theme/theme.dart';

// Account List Page — top-level entry showing all parent accounts
// ─────────────────────────────────────────────────────────────────────────────

class AccountListPage extends HookConsumerWidget {
  const AccountListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(regularAccountListProvider);
    final state = asyncState.value ?? const AccountListState();
    final aggregates = state.activeAggregates;
    final metrics = ref.watch(accountMetricsProvider);

    return FScaffold(
      header: PokaHeader(title: t.accounts.walletsPockets),
      child: asyncState.isLoading && state.accounts.isEmpty
          ? const Center(child: FCircularProgress())
          : RefreshIndicator(
              onRefresh: () async => ref.invalidate(accountListProvider),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  _AccountListHeader(
                    metrics: metrics,
                    onAddAccount: () => AccountFormSheet.show(context),
                  ),
                  if (aggregates.isEmpty)
                    const _EmptyAccountState()
                  else
                    _AccountGrid(
                      aggregates: aggregates,
                      totalAssets: metrics.totalAssets,
                    ),
                ],
              ),
            ),
    );
  }
}

class _AccountListHeader extends StatelessWidget {
  const _AccountListHeader({
    required this.metrics,
    required this.onAddAccount,
  });

  final AccountMetricsData metrics;
  final VoidCallback onAddAccount;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          children: [
            AccountNetworthCard(
              netWorth: metrics.netWorth,
              totalAssets: metrics.totalAssets,
              totalLiabilities: metrics.totalLiabilities,
              activeAccountCount: metrics.activeAccountCount,
            ).animateEntrance(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PokaSectionLabel(title: t.accounts.accounts),
                GestureDetector(
                  key: const Key('account-add-button'),
                  onTap: onAddAccount,
                  child: Row(
                    children: [
                      Icon(FPhosphorIcons.plus, size: 14, color: context.theme.colors.primary),
                      const SizedBox(width: 4),
                      Text(
                        t.accounts.addAccount,
                        style: context.theme.typography.bodySecondary.copyWith(
                          color: context.theme.colors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ).animateEntrance(delay: 80.ms),
          ],
        ),
      ),
    );
  }
}

class _EmptyAccountState extends StatelessWidget {
  const _EmptyAccountState();

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                    FPhosphorIcons.wallet,
                    size: 48,
                    color: context.theme.colors.mutedForeground,
                  )
                  .animate()
                  .fade(duration: 400.ms, delay: 120.ms)
                  .scale(
                    begin: const Offset(0.7, 0.7),
                    end: const Offset(1, 1),
                    curve: Curves.easeOutBack,
                  ),
              const SizedBox(height: 16),
              Text(
                t.accounts.noAccountsFound,
                style: context.theme.typography.body.lg.copyWith(
                  color: context.theme.colors.mutedForeground,
                ),
              ).animateEntrance(delay: 180.ms),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccountGrid extends ConsumerWidget {
  const _AccountGrid({
    required this.aggregates,
    required this.totalAssets,
  });

  final List<AccountAggregate> aggregates;
  final double totalAssets;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverToBoxAdapter(
      child: Padding(
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
      ),
    );
  }
}

// ── Extensions ─────────────────────────────────────────────────────────────

extension _AccountAggregateRatioExt on AccountAggregate {
  double calculateRatio(double totalAssets) {
    if (totalAssets <= 0) return 0;
    return (totalBalance / totalAssets).clamp(0, 1);
  }

  String formatRatioLabel(double totalAssets) {
    final ratio = calculateRatio(totalAssets);
    return '${(ratio * 100).toStringAsFixed(0)}% of assets';
  }
}

extension _EntranceAnimationExt on Widget {
  Widget animateEntrance({Duration delay = Duration.zero}) {
    return animate().fade(duration: 300.ms, delay: delay).slideY(begin: 0.05, end: 0);
  }
}
