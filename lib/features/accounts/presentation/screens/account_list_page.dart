import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/forms/account_form_sheet.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/lists/account_grid.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/lists/account_list_header.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/placeholders/empty_account_state.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/sections/goal_account_section.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';
import 'package:poka_ce/theme/theme.dart';

class AccountListPage extends HookConsumerWidget {
  const AccountListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final regularListState = ref.watch(regularAccountListProvider);
    final goalListState = ref.watch(goalAccountListProvider);
    final metrics = ref.watch(accountMetricsProvider);

    final regularAggregates = regularListState.value?.aggregates ?? [];
    final goalAggregates = goalListState.value?.aggregates ?? [];
    final hasRegularAccounts = regularAggregates.isNotEmpty;
    final hasGoalAccounts = goalAggregates.isNotEmpty;

    return FScaffold(
      header: PokaHeader(title: t.accounts.accounts),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AccountListHeader(metrics: metrics).animateEntrance(),
          ),

          if (!hasRegularAccounts && !hasGoalAccounts)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: EmptyAccountState(),
            )
          else ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PokaSectionLabel(title: t.accounts.mainAccounts),
                    GestureDetector(
                      onTap: () => AccountFormSheet.show(context),
                      behavior: HitTestBehavior.opaque,
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
              ),
            ),

            if (hasRegularAccounts)
              SliverToBoxAdapter(
                child: AccountGrid(
                  aggregates: regularAggregates,
                  totalAssets: metrics.totalAssets,
                ).animateEntrance(delay: 120.ms),
              )
            else
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text('No main accounts yet.'),
                  ),
                ),
              ),

            if (hasGoalAccounts)
              SliverToBoxAdapter(
                child: GoalAccountSection(
                  aggregates: goalAggregates,
                  totalAssets: metrics.totalAssets,
                ).animateEntrance(delay: 160.ms),
              ),
          ],
        ],
      ),
    );
  }
}

// ── Extensions ─────────────────────────────────────────────────────────────

extension EntranceAnimationExt on Widget {
  Widget animateEntrance({Duration delay = Duration.zero}) {
    return animate().fade(duration: 300.ms, delay: delay).slideY(begin: 0.05, end: 0);
  }
}
