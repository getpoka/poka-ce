import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/router/router.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/account_transaction_list.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/cards/account_hero_card.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/forms/account_form_sheet.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';
import 'package:poka_ce/theme/theme.dart';

// ─────────────────────────────────────────────────────────────────────────────

class PocketDetailPage extends HookConsumerWidget {
  const PocketDetailPage({
    required this.pocket,
    required this.categoriesById,
    required this.accountsById,
    super.key,
  });

  final AccountModel pocket;
  final Map<String, CategoryModel> categoriesById;
  final Map<String, AccountModel> accountsById;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final pocketColor = pocket.color?.toColor() ?? theme.colors.primary;
    final pocketIcon = IconUtil.getIcon(pocket.icon);
    final isBalanceVisible = ref.watch(balanceVisibilityProvider);

    final pocketTransactions = ref.watch(accountTransactionsProvider({pocket.id}));

    return FScaffold(
      header: PokaHeader(
        title: pocket.name,
        showBack: true,
        suffixes: [
          FHeaderAction(
            icon: const Icon(FPhosphorIcons.pencilSimple, size: 20),
            onPress: () => AccountFormSheet.show(context, initialAccount: pocket),
          ),
        ],
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AccountHeroCard(
              account: pocket,
              balance: pocket.balance,
              accentColor: pocketColor,
              accountIcon: pocketIcon,
              label: t.accounts.balance,
              transactionCount: pocketTransactions.length,
            ).animate().fade(duration: 300.ms).slideY(begin: 0.05, end: 0),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PokaSectionLabel(
                  title: pocketTransactions.isEmpty
                      ? 'Recent Transactions'
                      : 'Recent Transactions (${pocketTransactions.length})',
                ),
                GestureDetector(
                  onTap: () {
                    ref
                        .read(transactionListNotifierProvider.notifier)
                        .applyFilter(TransactionFilter(accountIds: {pocket.id}));
                    const TransactionListRoute().go(context);
                    Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst);
                  },
                  child: Text(
                    t.accounts.seeAll,
                    style: theme.typography.bodySecondary.copyWith(
                      color: theme.colors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ).animate().fade(duration: 300.ms, delay: 180.ms).slideY(begin: 0.05, end: 0),
            const SizedBox(height: 8),

            // ── Transactions list ─────────────────────────────────────────
            if (pocketTransactions.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Column(
                    children: [
                      Icon(FPhosphorIcons.receipt, size: 36, color: theme.colors.mutedForeground)
                          .animate()
                          .fade(duration: 300.ms, delay: 240.ms)
                          .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1), curve: Curves.easeOutBack),
                      const SizedBox(height: 8),
                      Text(
                        t.accounts.noTransactionsYet,
                        style: theme.typography.body.md.copyWith(color: theme.colors.mutedForeground),
                      ).animate().fade(duration: 300.ms, delay: 280.ms).slideY(begin: 0.1, end: 0),
                    ],
                  ),
                ),
              )
            else
              AccountTransactionList(
                transactions: pocketTransactions,
                categoriesById: categoriesById,
                accountsById: accountsById,
                isBalanceVisible: isBalanceVisible,
              ).animate().fade(duration: 300.ms, delay: 240.ms).slideY(begin: 0.05, end: 0),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared: grouped transaction list for account/pocket detail pages
