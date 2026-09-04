import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poka_ce/core/extensions/num_extension.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_hero_card.dart';
import 'package:poka_ce/theme/theme.dart';

class AccountNetworthCard extends ConsumerWidget {
  const AccountNetworthCard({
    required this.netWorth,
    required this.totalAssets,
    required this.totalLiabilities,
    required this.activeAccountCount,
    super.key,
  });

  final double netWorth;
  final double totalAssets;
  final double totalLiabilities;
  final int activeAccountCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final isBalanceVisible = ref.watch(balanceVisibilityProvider);
    final settingsState = ref.watch(settingsProvider);
    final baseCurrency = settingsState.settings?.baseCurrency;
    final symbol = baseCurrency?.symbol ?? 'Rp';
    final precision = baseCurrency?.precision ?? 0;
    final localeFormat = settingsState.settings?.numberFormat ?? 'system';

    return PokaHeroCard(
      pills: [
        PokaHeroCardPill(
          icon: FPhosphorIcons.wallet,
          label: context.t.dashboard.netWorth,
        ),
        PokaHeroCardPill(
          icon: FPhosphorIcons.bank,
          label: context.t.dashboard.accountsCount(count: activeAccountCount),
        ),
      ],
      trailing: GestureDetector(
        onTap: () => ref.read(balanceVisibilityProvider.notifier).toggle(),
        child: Icon(
          isBalanceVisible ? FPhosphorIcons.eye : FPhosphorIcons.eyeClosed,
          color: theme.colors.primaryForeground.withValues(alpha: 0.8),
          size: 20,
        ),
      ),
      title: context.t.dashboard.netWorth,
      amount: Text(
        netWorth.toCurrencyFormat(
          symbol: symbol,
          precision: precision,
          locale: localeFormat,
          isVisible: isBalanceVisible,
        ),
        style: theme.typography.amountSection.copyWith(
          color: theme.colors.primaryForeground,
        ),
      ),
      // No progress bar
      leftSubAmount: PokaHeroCardSubAmount(
        label: context.t.dashboard.assets,
        icon: FPhosphorIcons.trendUp,
        customAmountWidget: Text(
          totalAssets.toCurrencyFormat(
            symbol: symbol,
            precision: precision,
            locale: localeFormat,
            isVisible: isBalanceVisible,
          ),
          style: theme.typography.amountCard.copyWith(
            color: theme.colors.primaryForeground,
          ),
        ),
      ),
      rightSubAmount: PokaHeroCardSubAmount(
        label: context.t.dashboard.liabilities,
        icon: FPhosphorIcons.trendDown,
        customAmountWidget: Text(
          totalLiabilities.toCurrencyFormat(
            symbol: symbol,
            precision: precision,
            locale: localeFormat,
            isVisible: isBalanceVisible,
          ),
          style: theme.typography.amountCard.copyWith(
            color: theme.colors.primaryForeground,
          ),
        ),
      ),
    );
  }
}
