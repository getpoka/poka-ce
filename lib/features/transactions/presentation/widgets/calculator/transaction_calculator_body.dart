import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/widgets/pickers/category_selector_shelf.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/calculator/transaction_amount_display.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/calculator/transaction_calculator_numpad.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/forms/components/transaction_create_meta_bar.dart';

class TransactionCalculatorBody extends StatelessWidget {
  const TransactionCalculatorBody({
    required this.amountExpression,
    required this.historyExpression,
    required this.note,
    required this.type,
    required this.typeColor,
    required this.allocation,
    required this.categories,
    required this.selectedCategoryId,
    required this.isLoading,
    required this.onPickNote,
    required this.onAllocationChanged,
    required this.onCategorySelected,
    required this.onKeyPressed,
    required this.onDone,
    this.showSplitButton = false,
    this.showCategoryShelf = true,
    this.currencyCode,
    this.onSplitPressed,
    super.key,
  });

  final String amountExpression;
  final String? historyExpression;
  final String note;
  final TransactionType type;
  final Color typeColor;
  final TransactionAllocation? allocation;
  final List<CategoryModel> categories;
  final String? selectedCategoryId;
  final bool isLoading;
  final bool showSplitButton;
  final bool showCategoryShelf;
  final String? currencyCode;
  final VoidCallback? onSplitPressed;
  final VoidCallback onPickNote;
  final ValueChanged<TransactionAllocation?> onAllocationChanged;
  final ValueChanged<CategoryModel?> onCategorySelected;
  final ValueChanged<String> onKeyPressed;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 14),
              TransactionAmountDisplay(
                amountExpression: amountExpression,
                historyExpression: historyExpression,
                currencyCode: currencyCode,
              ),
              TransactionCreateMetaBar(
                note: note,
                type: type,
                typeColor: typeColor,
                allocation: allocation,
                onAllocationChanged: onAllocationChanged,
                onPickNote: onPickNote,
              ),
            ],
          ),
        ),
        if (showCategoryShelf)
          CategorySelectorShelf(
            categories: categories,
            selectedCategoryId: selectedCategoryId,
            onCategorySelected: onCategorySelected,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 6),
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: FCircularProgress()),
                )
              else
                TransactionCalculatorNumpad(
                  typeColor: typeColor,
                  value: amountExpression,
                  showSplitButton: showSplitButton,
                  onSplitPressed: onSplitPressed,
                  onKeyPressed: onKeyPressed,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
