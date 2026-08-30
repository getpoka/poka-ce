import 'package:flutter/material.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/cards/account_networth_card.dart';
import 'package:poka_ce/theme/theme.dart';

class AccountListHeader extends StatelessWidget {
  const AccountListHeader({
    required this.metrics,
    super.key,
  });

  final AccountMetricsData metrics;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 20),
      child: Column(
        children: [
          AccountNetworthCard(
            netWorth: metrics.netWorth,
            totalAssets: metrics.totalAssets,
            totalLiabilities: metrics.totalLiabilities,
            activeAccountCount: metrics.activeAccountCount,
          ),
        ],
      ),
    );
  }
}
