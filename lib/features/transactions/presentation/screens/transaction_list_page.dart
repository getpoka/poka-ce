import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/filter/transaction_filter_sheet.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/list/transaction_empty_period.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/list/transaction_group_sliver.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/list/transaction_list_sticky_nav.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/list/transaction_list_summary_card.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

/// Transaction list page — displays all transactions for a given date window
/// with a summary card, sticky date navigator, and advanced filter.
class TransactionListPage extends HookConsumerWidget {
  /// Creates a [TransactionListPage].
  const new({super.key});

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

    // Build lookup maps once so each tile does not re-subscribe.
    final categoriesById =
        ref.watch(categoriesStreamProvider).value?.fold<Map<String, CategoryModel>>({}, (map, c) => map..[c.id] = c) ??
        const {};

    final accountsById =
        ref.watch(accountsStreamProvider).value?.fold<Map<String, AccountModel>>({}, (map, a) => map..[a.id] = a) ??
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
                      control: FTextFieldControl.managed(controller: searchController),
                    ),
                  )
                : Align(
                    key: const ValueKey('title_text'),
                    alignment: Alignment.centerLeft,
                    child: Text(t.transactions.transactions, style: context.theme.typography.titleScreen),
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
            // Filter button
            GestureDetector(
              onTap: () async {
                final result = await TransactionFilterSheet.show(context, current: state.filter);
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
                            border: Border.all(color: context.theme.colors.background, width: 1.5),
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
                    SliverToBoxAdapter(child: TransactionListSummaryCard(state: state)),
                    const SliverToBoxAdapter(child: SizedBox(height: 20)),

                    // ── 2. Sticky: view-mode chips + date navigator ────────
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: TransactionListStickyNav(
                        state: state,
                        theme: context.theme,
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
                        child: TransactionEmptyPeriod(state: state, onToday: notifier.goToToday),
                      )
                    else if (state.transactions.isNotEmpty)
                      TransactionGroupSliver(
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
