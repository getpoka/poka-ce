import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/transactions/domain/services/transaction_grouping_service.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/filter/transaction_filter_sheet.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/forms/transaction_form_sheet.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/list/transaction_list_summary_card.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/tile/transaction_tile.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/dialogs/poka_confirm_dialog.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/shared/widgets/poka_empty_view.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';
import 'package:poka_ce/theme/theme.dart';

/// Transaction list page — displays all transactions for a given date window
/// with a summary card, sticky date navigator, and advanced filter.
class TransactionListPage extends HookConsumerWidget {
  /// Creates a [TransactionListPage].
  const TransactionListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transactionListNotifierProvider);
    final notifier = ref.read(transactionListNotifierProvider.notifier);

    final isSearchVisible = useState(state.filter.searchQuery.isNotEmpty);
    final searchController = useTextEditingController(text: state.filter.searchQuery);
    final searchFocusNode = useFocusNode();

    useEffect(() {
      void listener() {
        if (state.filter.searchQuery != searchController.text) {
          notifier.applyFilter(state.filter.copyWith(searchQuery: searchController.text));
        }
      }

      searchController.addListener(listener);
      return () => searchController.removeListener(listener);
    }, [searchController, notifier, state.filter.searchQuery]);

    // Build lookup maps once so each tile doesn't re-subscribe.
    final categoriesById =
        ref
            .watch(categoriesStreamProvider)
            .value
            ?.fold<Map<String, CategoryModel>>(
              {},
              (map, c) => map..[c.id] = c,
            ) ??
        const {};

    final accountsById =
        ref
            .watch(accountsStreamProvider)
            .value
            ?.fold<Map<String, AccountModel>>(
              {},
              (map, a) => map..[a.id] = a,
            ) ??
        const {};

    return MediaQuery.removeViewInsets(
      context: context,
      removeBottom: true,
      child: FScaffold(
        header: FHeader(
          title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: isSearchVisible.value
                ? Align(
                    key: const ValueKey('search_field'),
                    alignment: Alignment.centerLeft,
                    child: FTextField(
                      hint: t.transactions.searchTransactions,
                      clearable: (value) => value.text.isNotEmpty,
                      focusNode: searchFocusNode,
                      control: FTextFieldControl.managed(
                        controller: searchController,
                      ),
                    ),
                  )
                : Align(
                    key: const ValueKey('title_text'),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      t.transactions.transactions,
                      style: context.theme.typography.titleScreen,
                    ),
                  ),
          ),
          suffixes: [
            // Search button
            GestureDetector(
              onTap: () {
                isSearchVisible.value = !isSearchVisible.value;
                if (!isSearchVisible.value) {
                  searchController.clear();
                  searchFocusNode.unfocus();
                } else {
                  searchFocusNode.requestFocus();
                }
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(
                  isSearchVisible.value ? FPhosphorIcons.x : FPhosphorIcons.magnifyingGlass,
                  size: 22,
                  color: isSearchVisible.value
                      ? context.theme.colors.mutedForeground
                      : (state.filter.searchQuery.isNotEmpty
                            ? context.theme.colors.primary
                            : context.theme.colors.foreground),
                ),
              ),
            ),
            // Filter button — shows a badge dot when a filter is active.
            GestureDetector(
              onTap: () async {
                final result = await TransactionFilterSheet.show(
                  context,
                  current: state.filter,
                );
                if (result != null) notifier.applyFilter(result);
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      FPhosphorIcons.funnelSimple,
                      size: 22,
                      color: state.filter.isActive ? context.theme.colors.primary : context.theme.colors.foreground,
                    ),
                    if (state.filter.isActive)
                      Positioned(
                        top: -3,
                        right: -3,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: context.theme.colors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: context.theme.colors.background,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
        child: state.isLoading && state.transactions.isEmpty && state.errorMessage == null
            ? const Center(child: FCircularProgress())
            : RefreshIndicator(
                onRefresh: notifier.refresh,
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    // ── Error Banner ──────────────────────────────────────────
                    if (state.errorMessage != null)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: FAlert(
                            title: Text(t.transactions.failedToLoad),
                            subtitle: Text(state.errorMessage!),
                            icon: const Icon(FPhosphorIcons.warningCircle),
                            variant: FAlertVariant.destructive,
                          ),
                        ),
                      ),

                    // ── 1. Summary card (scrolls with content) ────────────
                    SliverToBoxAdapter(
                      child: TransactionListSummaryCard(state: state),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 20)),

                    // ── 2. Sticky: view-mode chips + date navigator ────────
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _StickyNavDelegate(
                        theme: context.theme,
                        state: state,
                        onModeChanged: notifier.setViewMode,
                        onPrev: notifier.navigatePrev,
                        onNext: notifier.navigateNext,
                        onJump: notifier.jumpToDate,
                        onToday: notifier.goToToday,
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 20)),

                    // ── 3. Transaction groups OR empty state ──────────────
                    if (state.transactions.isEmpty && state.errorMessage == null)
                      SliverToBoxAdapter(
                        child: _EmptyPeriod(
                          state: state,
                          onToday: notifier.goToToday,
                        ),
                      )
                    else if (state.transactions.isNotEmpty)
                      _TransactionGroupSliver(
                        transactions: state.transactions,
                        categoriesById: categoriesById,
                        accountsById: accountsById,
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Summary card
// ─────────────────────────────────────────────────────────────────────────────

/// Hero card showing the period's net balance, income, and expense totals.
/// Uses the primary gradient background following the budget summary card pattern.

// ─────────────────────────────────────────────────────────────────────────────
// Sticky nav delegate — view-mode chips + date navigator
// ─────────────────────────────────────────────────────────────────────────────

/// Pinned sliver header containing view-mode chips and the date navigator.
///
/// Pins itself below the [PokaHeader] so the user can always navigate dates
/// while scrolling through the transaction list.
class _StickyNavDelegate extends SliverPersistentHeaderDelegate {
  _StickyNavDelegate({
    required this.theme,
    required this.state,
    required this.onModeChanged,
    required this.onPrev,
    required this.onNext,
    required this.onJump,
    required this.onToday,
  });

  final FThemeData theme;
  final TransactionListState state;
  final ValueChanged<TransactionViewMode> onModeChanged;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final ValueChanged<DateTime> onJump;
  final VoidCallback onToday;

  /// Fixed height for the sticky area (chip row + date navigator + padding).
  static const double _height = 96;

  @override
  double get minExtent => _height;

  @override
  double get maxExtent => _height;

  @override
  bool shouldRebuild(_StickyNavDelegate old) =>
      old.theme != theme ||
      old.state.viewMode != state.viewMode ||
      old.state.focusedDate != state.focusedDate ||
      old.state.isCurrentPeriod != state.isCurrentPeriod;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final theme = context.theme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.background,
        // Show a subtle border when content scrolls beneath this header.
        border: overlapsContent
            ? Border(
                bottom: BorderSide(
                  color: theme.colors.border,
                  width: theme.style.borderWidth,
                ),
              )
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── View mode chips (Day / Week / Month) ─────────────────
            Row(
              children: TransactionViewMode.values.map((mode) {
                final isSelected = state.viewMode == mode;
                final label = switch (mode) {
                  TransactionViewMode.day => 'Day',
                  TransactionViewMode.week => 'Week',
                  TransactionViewMode.month => 'Month',
                };
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onModeChanged(mode),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      decoration: BoxDecoration(
                        color: isSelected ? theme.colors.primary : theme.colors.muted,
                        borderRadius: theme.style.borderRadius.sm,
                      ),
                      child: Center(
                        child: Text(
                          label,
                          style: theme.typography.bodyPrimary.copyWith(
                            color: isSelected ? theme.colors.primaryForeground : theme.colors.mutedForeground,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),

            // ── Date navigator ────────────────────────────────────────
            Row(
              children: [
                // Previous period
                GestureDetector(
                  onTap: onPrev,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: Icon(
                      FPhosphorIcons.caretLeft,
                      size: 18,
                      color: theme.colors.foreground,
                    ),
                  ),
                ),

                // Period label — tappable to show a calendar popover
                Expanded(
                  child: FPopover(
                    builder: (context, popoverController, child) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: popoverController.toggle,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              state.periodLabel,
                              textAlign: TextAlign.center,
                              style: theme.typography.bodyPrimary.copyWith(
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.2,
                              ),
                            ),
                            // "Back to today" is only shown for week/month — in day
                            // mode the label itself ("Today" / "Yesterday") is enough.
                            if (!state.isCurrentPeriod && state.viewMode != TransactionViewMode.day) ...[
                              const SizedBox(height: 1),
                              GestureDetector(
                                onTap: onToday,
                                child: Text(
                                  t.transactions.backToToday,
                                  style: theme.typography.bodySecondary.copyWith(color: theme.colors.primary),
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                    popoverBuilder: (context, popoverController) {
                      return FCalendar.grid(
                        selectionControl: FDateSelectionControl.managedSingle(
                          initial: state.focusedDate,
                          onChange: (newDate) {
                            if (newDate != null) onJump(newDate);
                            popoverController.hide();
                          },
                        ),
                      );
                    },
                  ),
                ),

                // Next period (disabled at current period).
                GestureDetector(
                  onTap: state.isCurrentPeriod ? null : onNext,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: Icon(
                      FPhosphorIcons.caretRight,
                      size: 18,
                      color: state.isCurrentPeriod
                          ? theme.colors.mutedForeground.withValues(alpha: 0.35)
                          : theme.colors.foreground,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Grouped transaction sliver
// ─────────────────────────────────────────────────────────────────────────────

/// Renders transactions as grouped date sections inside a [SliverList].
class _TransactionGroupSliver extends ConsumerWidget {
  const _TransactionGroupSliver({
    required this.transactions,
    required this.categoriesById,
    required this.accountsById,
  });

  final List<TransactionModel> transactions;
  final Map<String, CategoryModel> categoriesById;
  final Map<String, AccountModel> accountsById;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = TransactionGroupingService.groupTransactions(transactions);

    return SliverList.builder(
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Date group header ───────────────────────────────────
              _DateHeader(
                dateStr: group.dateStr,
                income: group.totalIncome,
                expense: group.totalExpense,
              ).animate().fade(duration: 250.ms, delay: (index * 50).ms).slideY(begin: 0.05, end: 0),
              const SizedBox(height: 8),

              // ── Tiles ───────────────────────────────────────────────
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(group.transactions.length, (i) {
                  final tx = group.transactions[i];
                  final firstCatId = tx.items.isNotEmpty ? tx.items.first.categoryId : null;
                  final category = firstCatId != null ? categoriesById[firstCatId] : null;
                  final account = accountsById[tx.accountId];

                  final tile = RecentTransactionTile(
                    transaction: tx,
                    isBalanceVisible: true,
                    categoriesById: categoriesById,
                    category: category,
                    account: account,
                    isFirst: i == 0,
                    isLast: i == group.transactions.length - 1,
                    onEdit: () {
                      TransactionFormSheet.show(context, initialTransaction: tx);
                    },
                    onDelete: () async {
                      final confirmed = await showPokaConfirmDialog(
                        context,
                        title: t.transactions.deleteTransaction,
                        body: t.transactions.deleteTransactionWarning,
                      );
                      if (confirmed == true) {
                        await ref.read(transactionListNotifierProvider.notifier).deleteTransaction(tx.id);
                      }
                    },
                  );

                  final tileWidget = i < group.transactions.length - 1
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: tile,
                        )
                      : tile;

                  return tileWidget
                      .animate()
                      .fade(duration: 250.ms, delay: (80 + i * 40).ms)
                      .slideX(begin: 0.05, end: 0, duration: 250.ms, delay: (80 + i * 40).ms);
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Date group header
// ─────────────────────────────────────────────────────────────────────────────

/// Compact section header showing the date and daily income/expense totals.
class _DateHeader extends StatelessWidget {
  const _DateHeader({
    required this.dateStr,
    required this.income,
    required this.expense,
  });

  final String dateStr;
  final int income;
  final int expense;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final total = income - expense;
    final totalType = total >= 0 ? TransactionType.income : TransactionType.expense;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 2),
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            color: theme.colors.primary,
            borderRadius: theme.style.borderRadius.xs,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dateStr,
                style: theme.typography.titleItem,
              ),
              if (income > 0 || expense > 0) ...[
                const SizedBox(height: 2),
                Row(
                  children: [
                    if (income > 0) ...[
                      Text(
                        t.transactions.incoming,
                        style: theme.typography.labelBadge.copyWith(
                          color: theme.colors.app.income,
                        ),
                      ),
                      PokaAmountText(
                        amount: income,
                        type: TransactionType.income,
                        style: theme.typography.amountTile,
                      ),
                    ],
                    if (income > 0 && expense > 0) const SizedBox(width: 8),
                    if (expense > 0) ...[
                      Text(
                        t.transactions.out,
                        style: theme.typography.labelBadge.copyWith(
                          color: theme.colors.app.expense,
                        ),
                      ),
                      PokaAmountText(
                        amount: expense,
                        type: TransactionType.expense,
                        style: theme.typography.amountTile,
                      ),
                    ],
                    const Spacer(),
                    if (total != 0) ...[
                      Icon(
                        FPhosphorIcons.sigma,
                        size: 12,
                        color: theme.colors.mutedForeground,
                      ),
                      const SizedBox(width: 4),
                      PokaAmountText(
                        amount: total.abs(),
                        type: totalType,
                        style: theme.typography.amountTile,
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Empty period state
// ─────────────────────────────────────────────────────────────────────────────

/// Shown when no transactions match the current date window + filter.
class _EmptyPeriod extends StatelessWidget {
  const _EmptyPeriod({required this.state, required this.onToday});

  final TransactionListState state;
  final VoidCallback onToday;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PokaEmptyView(
        icon: FPhosphorIcons.receipt,
        title: t.transactions.noTransactions,
        subtitle: t.transactions.nothingRecordedFor(period: state.periodLabel.toLowerCase()),
        actionLabel: state.isCurrentPeriod ? null : t.transactions.goToToday,
        onAction: state.isCurrentPeriod ? null : onToday,
      ),
    );
  }
}
