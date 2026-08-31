import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';
import 'package:poka_ce/features/debts/presentation/controllers/debt_detail_notifier.dart';
import 'package:poka_ce/features/debts/presentation/controllers/debt_list_notifier.dart';
import 'package:poka_ce/features/debts/presentation/widgets/cards/debt_card.dart';
import 'package:poka_ce/features/debts/presentation/widgets/forms/debt_form_sheet.dart';
import 'package:poka_ce/features/debts/presentation/widgets/forms/debt_repayment_sheet.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/tile/transaction_tile.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_empty_view.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';
import 'package:poka_ce/theme/theme.dart';

class DebtDetailPage extends ConsumerWidget {
  const DebtDetailPage({
    required this.id,
    this.debt,
    super.key,
  });

  final String id;
  final DebtModel? debt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debtListAsync = ref.watch(debtListProvider);
    final activeDebt = debtListAsync.asData?.value.where((d) => d.id == id).firstOrNull ?? debt;

    if (activeDebt == null) {
      return FScaffold(
        header: PokaHeader(title: t.debts.debtDetails, showBack: true),
        child: const Center(child: FCircularProgress()),
      );
    }

    final categoriesById =
        ref
            .watch(categoryListProvider)
            .asData
            ?.value
            .fold<Map<String, CategoryModel>>(
              <String, CategoryModel>{},
              (map, c) => map..[c.id] = c,
            ) ??
        <String, CategoryModel>{};

    final accountsById =
        ref
            .watch(accountListProvider)
            .asData
            ?.value
            .accounts
            .fold<Map<String, AccountModel>>(
              <String, AccountModel>{},
              (map, a) => map..[a.id] = a,
            ) ??
        <String, AccountModel>{};

    final transactionsAsync = ref.watch(debtTransactionsProvider(activeDebt));
    final isPayable = activeDebt.type == DebtType.debt;

    return FScaffold(
      header: PokaHeader(
        title: '${isPayable ? "Debt" : "Loan"} Details',
        showBack: true,
        suffixes: [
          FHeaderAction(
            icon: const Icon(FPhosphorIcons.pencilSimple, size: 20),
            onPress: () => DebtFormSheet.show(context, initialDebt: activeDebt),
          ),
          if (activeDebt.status == DebtStatus.active)
            FHeaderAction(
              icon: const Icon(FPhosphorIcons.handshake, size: 20),
              onPress: () async {
                await ref.read(debtDetailProvider.notifier).writeOffDebt(context, activeDebt);
              },
            ),
          FHeaderAction(
            icon: Icon(FPhosphorIcons.trash, size: 20, color: context.theme.colors.destructive),
            onPress: () async {
              final deleted = await ref.read(debtDetailProvider.notifier).deleteDebt(context, activeDebt);
              if (deleted && context.mounted) {
                context.pop();
              }
            },
          ),
        ],
      ),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: DebtCard(debt: activeDebt, isInteractive: false),
          ),
          if (activeDebt.status == DebtStatus.active)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: FButton(
                  onPress: () => DebtRepaymentSheet.show(context, activeDebt),
                  child: Text(t.debts.addRepayment),
                ),
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(
            child: PokaSectionLabel(title: t.debts.repaymentHistory),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          transactionsAsync.when(
            data: (transactions) {
              if (transactions.isEmpty) {
                return SliverToBoxAdapter(
                  child: PokaEmptyViewCentered(
                    icon: FPhosphorIcons.receipt,
                    title: t.debts.noHistoryFoundForThis(type: isPayable ? t.debts.payable : t.debts.receivable),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final transaction = transactions[index];
                    final firstCatId = transaction.items.isNotEmpty ? transaction.items.first.categoryId : null;
                    final category = firstCatId != null ? categoriesById[firstCatId] : null;
                    final account = accountsById[transaction.accountId];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: RecentTransactionTile(
                        transaction: transaction,
                        isBalanceVisible: true,
                        categoriesById: categoriesById,
                        category: category,
                        account: account,
                      ),
                    );
                  },
                  childCount: transactions.length,
                ),
              );
            },
            error: (err, _) => SliverToBoxAdapter(child: Text(err.toString())),
            loading: () => const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(child: FCircularProgress()),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}
