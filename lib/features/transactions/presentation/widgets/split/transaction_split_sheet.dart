import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/transactions/domain/split_item.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/split/transaction_split_item_form_sheet.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/split/transaction_split_item_list.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';
import 'package:poka_ce/theme/theme.dart';

/// Bottom-up split transaction sheet.
///
/// User adds sub-items freely; the total is the sum of all items.
/// Minimum 2 items are required to confirm and return to the main form.
class TransactionSplitSheet extends ConsumerStatefulWidget {
  const TransactionSplitSheet({
    required this.transactionType,
    this.initialSplits,
    super.key,
  });

  final TransactionType transactionType;
  final List<SplitItem>? initialSplits;

  /// Shows the split sheet and resolves to the updated list of [SplitItem],
  /// or null when the user dismisses without saving.
  static Future<List<SplitItem>?> show(
    BuildContext context, {
    required TransactionType transactionType,
    List<SplitItem>? initialSplits,
  }) {
    return showPokaSheet<List<SplitItem>>(
      context: context,
      persistent: false,
      isScrollControlled: true,
      builder: (_) => TransactionSplitSheet(
        transactionType: transactionType,
        initialSplits: initialSplits,
      ),
    );
  }

  @override
  ConsumerState<TransactionSplitSheet> createState() => _TransactionSplitSheetState();
}

class _TransactionSplitSheetState extends ConsumerState<TransactionSplitSheet> {
  final List<SplitItem> _splits = [];

  /// Total = Σ of all split item amounts.
  int get _totalAmount => _splits.fold(0, (sum, item) => sum + item.amount);

  @override
  void initState() {
    super.initState();
    if (widget.initialSplits != null) {
      _splits.addAll(widget.initialSplits!);
    }
  }

  Future<void> _addItem() async {
    final item = await TransactionSplitItemFormSheet.show(
      context,
      transactionType: widget.transactionType,
    );
    if (item != null && mounted) {
      setState(() => _splits.add(item));
    }
  }

  Future<void> _editItem(int index) async {
    final item = await TransactionSplitItemFormSheet.show(
      context,
      transactionType: widget.transactionType,
      initialItem: _splits[index],
    );
    if (item != null && mounted) {
      setState(() => _splits[index] = item);
    }
  }

  void _removeItem(int index) => setState(() => _splits.removeAt(index));

  void _saveAndClose() => Navigator.of(context).pop(_splits);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;
    final typography = theme.typography;
    final canSave = _splits.length >= 2;

    return PokaSheet(
      title: t.transactions.splitTransaction,
      isScrollable: false,
      showCloseButton: false,
      trailing: _splits.isNotEmpty
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.08),
                borderRadius: theme.style.borderRadius.sm,
                border: Border.all(color: colors.primary.withValues(alpha: 0.2)),
              ),
              child: PokaAmountText(
                amount: _totalAmount,
                type: widget.transactionType,
                style: typography.bodySecondary.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colors.primary,
                ),
              ),
            )
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Subtitle (number of items) ──────────────────────────────
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              t.transactions.itemsCount(count: _splits.length),
              textAlign: TextAlign.center,
              style: typography.bodyPrimary.copyWith(color: colors.mutedForeground),
            ),
          ),

          const FDivider(),

          // ── Body: empty state or item list ───────────────────────────
          Flexible(
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: theme.style.pagePadding.top,
                    ),
                    child: _splits.isEmpty
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: theme.style.app.xl),
                              child: Column(
                                children: [
                                  Icon(
                                    FPhosphorIcons.arrowsSplit,
                                    size: 32,
                                    color: colors.mutedForeground,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    t.transactions.noItemsYet,
                                    style: typography.bodyPrimary.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: colors.foreground,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    t.transactions.tapAddItemToBeginSplittingntheTransaction,
                                    textAlign: TextAlign.center,
                                    style: typography.bodyPrimary.copyWith(color: colors.mutedForeground),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : TransactionSplitItemList(
                            splits: _splits,
                            transactionType: widget.transactionType,
                            onRemove: _removeItem,
                            onEdit: _editItem,
                          ),
                  ),
                ),

                // ── Action buttons ────────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: theme.style.app.md,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FButton(
                          onPress: _addItem,
                          variant: FButtonVariant.outline,
                          child: Text(t.transactions.addItem),
                        ),
                        if (_splits.isNotEmpty) ...[
                          const SizedBox(height: 10),
                          // Minimum 2 items hint
                          if (_splits.length == 1)
                            Padding(
                              padding: EdgeInsets.only(bottom: theme.style.app.sm),
                              child: Text(
                                t.transactions.addAtLeastOneMoreItemToSave,
                                textAlign: TextAlign.center,
                                style: typography.bodySecondary.copyWith(color: colors.mutedForeground),
                              ),
                            ),
                          FButton(
                            onPress: canSave ? _saveAndClose : null,
                            child: Text(t.transactions.done),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
