import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/cards/account_networth_card.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_header_provider.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/cards/dashboard_analytics_carousel.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/cards/dashboard_spending_chart.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/sections/dashboard_quick_actions.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/sections/dashboard_recent_transactions.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';

class DashboardPage extends HookConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);
    final customHeaderBuilder = ref.watch(dashboardHeaderBuilderProvider);

    final header = customHeaderBuilder != null
        ? customHeaderBuilder(context)
        : PokaHeader(
            subtitle: context.t.dashboard.overview,
            title: context.t.dashboard.myFinances,
          );

    return FScaffold(
      header: header,
      child: state.isLoading && state.accounts.isEmpty
          ? const Center(child: FCircularProgress())
          : RefreshIndicator(
              onRefresh: () => ref.read(dashboardProvider.notifier).refresh(),
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AccountNetworthCard(
                      netWorth: state.netWorth,
                      totalAssets: state.totalAssets,
                      totalLiabilities: state.totalLiabilities,
                      activeAccountCount: state.activeAccountCount,
                      sparklineData: state.netWorthTrend,
                    ).animate().fade(duration: 400.ms).slideY(begin: 0.05, end: 0),
                    const SizedBox(height: 20),
                    const DashboardQuickActions()
                        .animate()
                        .fade(duration: 400.ms, delay: 100.ms)
                        .slideY(begin: 0.05, end: 0),
                    const SizedBox(height: 20),
                    const DashboardAnalyticsCarousel()
                        .animate()
                        .fade(duration: 400.ms, delay: 200.ms)
                        .slideY(begin: 0.05, end: 0),
                    const SizedBox(height: 20),
                    const DashboardSpendingChart()
                        .animate()
                        .fade(duration: 400.ms, delay: 300.ms)
                        .slideY(begin: 0.05, end: 0),
                    const SizedBox(height: 20),
                    DashboardRecentTransactions(
                      transactions: state.recentTransactions,
                    ).animate().fade(duration: 400.ms, delay: 400.ms).slideY(begin: 0.05, end: 0),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }
}
