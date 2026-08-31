import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/router/router.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/account_transaction_list.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/cards/account_hero_card.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/forms/account_form_sheet.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_empty_view.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';
import 'package:poka_ce/theme/theme.dart';

// ─────────────────────────────────────────────────────────────────────────────

class PocketDetailPage extends HookConsumerWidget {
  const PocketDetailPage({
    required this.pocket,
    super.key,
  });

  final AccountModel pocket;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final pocketColor = pocket.color?.toColor() ?? theme.colors.primary;
    final pocketIcon = IconUtil.getIcon(pocket.icon);
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
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
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
                ],
              ),
            ),
          ),
          if (pocketTransactions.isEmpty)
            SliverToBoxAdapter(
              child: PokaEmptyView(
                icon: FPhosphorIcons.receipt,
                title: t.accounts.noTransactionsYet,
                hasBorder: true,
              ).animate().fade(duration: 300.ms, delay: 240.ms).slideY(begin: 0.05, end: 0),
            )
          else
            SliverToBoxAdapter(
              child: AccountTransactionList(
                accountId: pocket.id,
                transactions: pocketTransactions,
              ).animate().fade(duration: 300.ms, delay: 240.ms).slideY(begin: 0.05, end: 0),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared: grouped transaction list for account/pocket detail pages
