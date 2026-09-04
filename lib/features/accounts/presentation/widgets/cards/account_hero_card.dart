import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/shared/widgets/poka_hero_card.dart';
import 'package:poka_ce/theme/theme.dart';

// ─────────────────────────────────────────────────────────────────────────────

class AccountHeroCard extends ConsumerWidget {
  const AccountHeroCard({
    required this.account,
    required this.balance,
    required this.accentColor,
    required this.accountIcon,
    required this.label,
    super.key,
    this.pocketCount,
    this.transactionCount,
  });

  final AccountModel account;
  final int balance;
  final Color accentColor;
  final IconData accountIcon;
  final String label;
  final int? pocketCount;
  final int? transactionCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final isVisible = ref.watch(balanceVisibilityProvider);

    return PokaHeroCard(
      cardColor: accentColor,
      pills: [
        // Icon pill
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(accountIcon, color: Colors.white, size: 14),
        ),
        const SizedBox(width: 8),
        // Type badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            account.type.name.toUpperCase(),
            style: theme.typography.labelBadge.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ),
      ],
      trailing: GestureDetector(
        onTap: () => ref.read(balanceVisibilityProvider.notifier).toggle(),
        child: Icon(
          isVisible ? FPhosphorIcons.eye : FPhosphorIcons.eyeClosed,
          color: Colors.white.withValues(alpha: 0.8),
          size: 20,
        ),
      ),
      title: account.name,
      amount: PokaAmountText(
        amount: balance,
        type: balance >= 0 ? TransactionType.income : TransactionType.expense,
        isObscured: !isVisible,
        style: theme.typography.amountSection.copyWith(
          color: Colors.white,
        ),
      ),
      leftSubAmount: PokaHeroCardSubAmount(
        label: t.accounts.pockets,
        icon: FPhosphorIcons.wallet,
        customAmountWidget: Text(
          pocketCount != null && account.type != AccountType.goal ? '${pocketCount!}' : '—',
          style: theme.typography.bodyPrimary.copyWith(
            color: theme.colors.primaryForeground,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      rightSubAmount: PokaHeroCardSubAmount(
        label: t.accounts.transactions,
        icon: FPhosphorIcons.receipt,
        customAmountWidget: Text(
          transactionCount != null ? '${transactionCount!}' : '—',
          style: theme.typography.bodyPrimary.copyWith(
            color: theme.colors.primaryForeground,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
