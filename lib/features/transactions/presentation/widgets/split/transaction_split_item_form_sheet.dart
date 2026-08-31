import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/features/transactions/domain/split_item.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/calculator/transaction_calculator_body.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/split/transaction_split_sheet.dart'
    show TransactionSplitSheet;
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/utils/math_evaluator.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';
import 'package:poka_ce/theme/theme.dart';

/// Persistent bottom sheet that creates or edits a single split item.
///
/// Shown from [TransactionSplitSheet]. Pops with the resulting [SplitItem],
/// or null when the user cancels with the X button.
class TransactionSplitItemFormSheet extends ConsumerStatefulWidget {
  const TransactionSplitItemFormSheet({
    required this.transactionType,
    this.initialItem,
    super.key,
  });

  final TransactionType transactionType;

  /// Existing item to edit; null means a new item is being created.
  final SplitItem? initialItem;

  /// Shows the form sheet and resolves to the created/edited [SplitItem],
  /// or null when the user cancels.
  static Future<SplitItem?> show(
    BuildContext context, {
    required TransactionType transactionType,
    SplitItem? initialItem,
  }) {
    return showPokaSheet<SplitItem>(
      context: context,
      isScrollControlled: true,
      persistent: false,
      builder: (_) => TransactionSplitItemFormSheet(
        transactionType: transactionType,
        initialItem: initialItem,
      ),
    );
  }

  @override
  ConsumerState<TransactionSplitItemFormSheet> createState() => _TransactionSplitItemFormSheetState();
}

class _TransactionSplitItemFormSheetState extends ConsumerState<TransactionSplitItemFormSheet> {
  String? _currentId;
  String _amountExpr = '0';
  String? _historyExpr;
  String? _categoryId;
  String? _note;
  TransactionAllocation? _allocation;

  // Resolved parent/sub IDs for the category shelf
  String? _selectedParentId;
  String? _selectedSubId;

  @override
  void initState() {
    super.initState();
    final item = widget.initialItem;
    if (item == null) return;

    _currentId = item.id;
    _amountExpr = item.amount.toString();

    // Resolve whether the saved categoryId is a sub-category
    final allCats = ref.read(categoryListProvider).value ?? <CategoryModel>[];
    final savedCat = allCats.where((c) => c.id == item.categoryId).firstOrNull;
    if (savedCat?.parentId != null) {
      _selectedParentId = savedCat!.parentId;
      _selectedSubId = savedCat.id;
    } else {
      _selectedParentId = item.categoryId;
      _selectedSubId = null;
    }
    _categoryId = item.categoryId;
    _note = item.note;
    _allocation = item.allocation;
  }

  void _onCategorySelected(CategoryModel cat) {
    HapticFeedback.selectionClick();
    setState(() {
      if (_selectedParentId == cat.id) {
        // Deselect
        _selectedParentId = null;
        _selectedSubId = null;
        _categoryId = null;
      } else {
        _selectedParentId = cat.id;
        _selectedSubId = null;
        _categoryId = cat.id;
      }
    });
  }

  void _onSubcategorySelected(CategoryModel sub) {
    HapticFeedback.selectionClick();
    setState(() {
      if (_selectedSubId == sub.id) {
        _selectedSubId = null;
        _categoryId = _selectedParentId;
      } else {
        _selectedSubId = sub.id;
        _categoryId = sub.id;
      }
    });
  }

  void _confirm() {
    final amount = int.tryParse(_amountExpr) ?? 0;
    if (amount <= 0) return;

    // Resolve display name from category list
    final allCats = ref.read(categoryListProvider).value ?? <CategoryModel>[];
    final effectiveCat = allCats.where((c) => c.id == _categoryId).firstOrNull;

    Navigator.of(context).pop(
      SplitItem(
        id: _currentId,
        amount: amount,
        categoryId: _categoryId,
        categoryName: effectiveCat?.name,
        note: _note?.isNotEmpty == true ? _note : null,
        allocation: _allocation,
      ),
    );
  }

  Future<void> _showNoteEditor() async {
    final controller = TextEditingController(text: _note);
    await showFDialog<void>(
      context: context,
      builder: (ctx, style, animation) => FDialog(
        animation: animation,
        builder: (dialogCtx, dialogStyle) {
          final dialogTheme = ctx.theme;
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  t.transactions.addNote,
                  style: dialogTheme.typography.display.sm.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 14),
                FTextField(
                  focusNode: FocusNode()..requestFocus(),
                  control: FTextFieldControl.managed(controller: controller),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: FButton(
                        onPress: () => Navigator.of(ctx).pop(),
                        variant: FButtonVariant.outline,
                        child: Text(t.transactions.cancel),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FButton(
                        onPress: () {
                          setState(() => _note = controller.text.trim());
                          Navigator.of(ctx).pop();
                        },
                        child: Text(t.transactions.save),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isEditing = _currentId != null;

    final typeColor = widget.transactionType == TransactionType.income
        ? theme.colors.app.income
        : (widget.transactionType == TransactionType.expense ? theme.colors.app.expense : theme.colors.app.transfer);

    // Filter categories by type
    final allCategories = ref.watch(categoryListProvider).value ?? <CategoryModel>[];
    final filteredCategories = allCategories.where((c) {
      if (!c.isActive) return false;
      if (widget.transactionType == TransactionType.income) return c.type == CategoryType.income;
      if (widget.transactionType == TransactionType.expense) return c.type == CategoryType.expense;
      return false;
    }).toList();

    final settings = ref.watch(settingsProvider).settings;
    final currencyCode = settings?.baseCurrency?.symbol;

    return PokaSheet(
      title: isEditing ? 'Edit Item' : 'New Item',
      isScrollable: false,
      padding: EdgeInsets.zero,
      child: TransactionCalculatorBody(
        amountExpression: _amountExpr,
        historyExpression: _historyExpr,
        note: _note ?? '',
        type: widget.transactionType,
        typeColor: typeColor,
        allocation: _allocation,
        currencyCode: currencyCode,
        categories: filteredCategories,
        selectedCategoryId: _selectedSubId ?? _selectedParentId,
        isLoading: false, // Split items are saved locally, no async loading state
        onPickNote: _showNoteEditor,
        onAllocationChanged: (a) => setState(() => _allocation = a),
        onCategorySelected: (cat) {
          if (cat == null) {
            setState(() {
              _selectedParentId = null;
              _selectedSubId = null;
              _categoryId = null;
            });
          } else if (cat.parentId == null) {
            _onCategorySelected(cat);
          } else {
            _onSubcategorySelected(cat);
          }
        },
        onKeyPressed: (key) {
          if (key == 'OK') {
            _confirm();
            return;
          }
          if (key == '=') {
            final snapshot = _amountExpr;
            final result = MathEvaluator.evaluate(snapshot);
            if (result != null && result != snapshot) {
              setState(() {
                _amountExpr = result;
                _historyExpr = null;
              });
            }
            return;
          }

          final newExpr = MathEvaluator.handleKeyPress(_amountExpr, key);
          String? newHistory;
          if (newExpr != _amountExpr && MathEvaluator.hasUnresolvedOperator(newExpr)) {
            newHistory = MathEvaluator.evaluate(newExpr);
          }

          setState(() {
            _amountExpr = newExpr;
            _historyExpr = newHistory;
          });
        },
        onDone: () {}, // OK handled in onKeyPressed
      ),
    );
  }
}
