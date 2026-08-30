import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/filter/transaction_filter_account_group.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/filter/transaction_filter_category_group.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/filter/transaction_type_chip.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';
import 'package:poka_ce/theme/theme.dart';

/// Bottom sheet for advanced transaction filtering.
///
/// Supports multi-select for transaction types, accounts, and categories.
/// Account and category use the same scrollable pill row as in the transaction
/// form sheet to save vertical space.
/// Returns the chosen [TransactionFilter] via [Navigator.pop].
class TransactionFilterSheet extends HookConsumerWidget {
  /// Creates a [TransactionFilterSheet].
  const TransactionFilterSheet({required this.current, super.key});

  /// The filter currently applied on the list page; used to pre-populate selections.
  final TransactionFilter current;

  /// Shows the filter sheet and awaits the user's selection.
  ///
  /// Returns the new [TransactionFilter], or `null` if dismissed.
  static Future<TransactionFilter?> show(
    BuildContext context, {
    required TransactionFilter current,
  }) => showPokaSheet<TransactionFilter>(
    context: context,
    fitContent: true,
    persistent: false,
    builder: (ctx) => TransactionFilterSheet(current: current),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    // Local mutable selections — seeded from the current filter.
    final selectedTypes = useState<Set<TransactionType>>(
      Set.from(current.types),
    );
    final selectedAccountIds = useState<Set<String>>(
      Set.from(current.accountIds),
    );
    final selectedCategoryIds = useState<Set<String>>(
      Set.from(current.categoryIds),
    );

    final accounts = ref.watch(accountsStreamProvider).value ?? [];
    final categories = ref.watch(categoriesStreamProvider).value ?? [];

    final hasAnySelection =
        selectedTypes.value.isNotEmpty || selectedAccountIds.value.isNotEmpty || selectedCategoryIds.value.isNotEmpty;

    return PokaSheet(
      title: t.transactions.filter,
      // Reset all on the LEFT so it doesn't compete with the close button.
      leading: hasAnySelection
          ? GestureDetector(
              onTap: () {
                selectedTypes.value = {};
                selectedAccountIds.value = {};
                selectedCategoryIds.value = {};
              },
              child: Text(
                t.transactions.reset,
                style: theme.typography.bodyPrimary.copyWith(
                  color: theme.colors.destructive,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Transaction type ──────────────────────────────────────────────
          FLabel(
            layout: FLabelLayout.vertical,
            label: Text(t.transactions.transactionType),
            child: Row(
              children: TransactionType.values.map((type) {
                final isSelected = selectedTypes.value.contains(type);
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: type != TransactionType.values.last ? 8 : 0,
                    ),
                    child: TransactionTypeChip(
                      type: type,
                      isSelected: isSelected,
                      onTap: () {
                        final next = Set<TransactionType>.from(selectedTypes.value);
                        isSelected ? next.remove(type) : next.add(type);
                        selectedTypes.value = next;
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // ── Account ───────────────────────────────────────────────────────
          if (accounts.isNotEmpty) ...[
            const SizedBox(height: 20),
            TransactionFilterAccountGroup(
              accounts: accounts,
              selectedIds: selectedAccountIds.value,
              onChanged: (ids) => selectedAccountIds.value = ids,
            ),
          ],

          // ── Category ──────────────────────────────────────────────────────
          if (categories.isNotEmpty) ...[
            const SizedBox(height: 20),
            TransactionFilterCategoryGroup(
              categories: categories,
              selectedIds: selectedCategoryIds.value,
              onChanged: (ids) => selectedCategoryIds.value = ids,
            ),
          ],

          // ── Apply button ──────────────────────────────────────────────────
          const SizedBox(height: 20),
          FButton(
            onPress: () => Navigator.of(context).pop(
              TransactionFilter(
                types: Set.from(selectedTypes.value),
                accountIds: Set.from(selectedAccountIds.value),
                categoryIds: Set.from(selectedCategoryIds.value),
              ),
            ),
            child: Text(t.transactions.applyFilter),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
