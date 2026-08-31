import 'package:flutter/material.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/cards/account_networth_card.dart';

class AccountListHeader extends StatelessWidget {
  const AccountListHeader({
    required this.metrics,
    super.key,
  });

  final AccountMetricsData metrics;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
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
