import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/pickers/account_selector_shelf.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_form_notifier.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/calculator/transaction_amount_display.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/calculator/transaction_calculator_body.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/forms/components/transaction_date_nav.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/forms/components/transaction_transfer_selector.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/forms/components/transaction_type_switcher.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/split/transaction_split_sheet.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/split/transaction_split_summary_card.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';
import 'package:poka_ce/theme/theme.dart';

/// Bottom sheet for creating a new transaction (simple or split) or editing an existing one.
class TransactionFormSheet extends HookConsumerWidget {
  const TransactionFormSheet({
    super.key,
    this.initialType,
    this.initialTransaction,
    this.initialAmount,
    this.initialNote,
    this.initialAccountId,
    this.initialDestinationAccountId,
    this.initialCategoryId,
    this.initialDate,
  });

  final TransactionType? initialType;
  final TransactionModel? initialTransaction;
  final String? initialAmount;
  final String? initialNote;
  final String? initialAccountId;
  final String? initialDestinationAccountId;
  final String? initialCategoryId;
  final DateTime? initialDate;

  static Future<bool?> show(
    BuildContext context, {
    TransactionType? initialType,
    TransactionModel? initialTransaction,
    String? initialAmount,
    String? initialNote,
    String? initialAccountId,
    String? initialDestinationAccountId,
    String? initialCategoryId,
    DateTime? initialDate,
  }) {
    return showPokaSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (context) => PokaSheet(
        title: initialTransaction != null ? 'Edit Transaction' : 'New Transaction',
        padding: EdgeInsets.zero,
        child: TransactionFormSheet(
          initialType: initialType,
          initialTransaction: initialTransaction,
          initialAmount: initialAmount,
          initialNote: initialNote,
          initialAccountId: initialAccountId,
          initialDestinationAccountId: initialDestinationAccountId,
          initialCategoryId: initialCategoryId,
          initialDate: initialDate,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    final args = TransactionFormArgs(
      initialType: initialType,
      initialTransaction: initialTransaction,
      initialAmount: initialAmount,
      initialNote: initialNote,
      initialAccountId: initialAccountId,
      initialDestinationAccountId: initialDestinationAccountId,
      initialCategoryId: initialCategoryId,
      initialDate: initialDate,
    );

    final provider = transactionFormProvider(args);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

    final accounts = ref.watch(dashboardProvider).accounts;
    final categories = ref.watch(categoryListProvider).value ?? <CategoryModel>[];
    final settings = ref.watch(settingsProvider).settings;
    final currencyCode = settings?.baseCurrency?.symbol;

    useEffect(() {
      if (accounts.isNotEmpty) {
        if (state.accountId == null) {
          if (initialTransaction != null) {
            final acc = accounts.where((a) => a.id == initialTransaction!.accountId).firstOrNull;
            if (acc != null) Future.microtask(() => notifier.setAccount(acc.id));
          } else if (initialAccountId != null) {
            final acc = accounts.where((a) => a.id == initialAccountId).firstOrNull ?? accounts.first;
            Future.microtask(() => notifier.setAccount(acc.id));
          } else {
            Future.microtask(() => notifier.setAccount(accounts.first.id));
          }
        }
        if (state.destinationAccountId == null) {
          if (initialTransaction != null && initialTransaction!.destinationAccountId != null) {
            final acc = accounts.where((a) => a.id == initialTransaction!.destinationAccountId).firstOrNull;
            if (acc != null) Future.microtask(() => notifier.setDestinationAccount(acc.id));
          } else if (accounts.length > 1) {
            Future.microtask(() => notifier.setDestinationAccount(accounts[1].id));
          }
        }
      }
      return null;
    }, [accounts]);

    ref.listen<TransactionFormState>(provider, (prev, next) {
      if (next.isSuccess && (prev?.isSuccess != true)) {
        ref.read(dashboardProvider.notifier).refresh();
        ref.read(transactionListNotifierProvider.notifier).refresh();
        Navigator.of(context).pop(true);
      } else if (next.error != null && next.error != prev?.error) {
        showFToast(
          context: context,
          title: Text(next.error.toString()),
          variant: FToastVariant.destructive,
        );
      }
    });

    final isSplit = state.splitItems != null;
    final typeColor = state.type == TransactionType.income
        ? theme.colors.app.income
        : (state.type == TransactionType.expense ? theme.colors.app.expense : theme.colors.app.transfer);

    Future<void> openSplitSheet() async {
      final result = await TransactionSplitSheet.show(
        context,
        transactionType: state.type,
        initialSplits: state.splitItems,
      );
      if (result != null) {
        notifier.setSplitItems(result);
      }
    }

    Future<void> showNoteEditor() async {
      final controller = TextEditingController(text: state.note);
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
                            notifier.setNote(controller.text.trim());
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

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TransactionTypeSwitcher(
                selectedType: state.type,
                onChanged: notifier.setType,
              ),
              const SizedBox(height: 10),
              TransactionDateNav(
                selectedDate: state.date,
                onStepDate: (step) => notifier.setDate(state.date.add(Duration(days: step))),
                onDateChanged: notifier.setDate,
                onTimeChanged: notifier.setDate,
              ),
              const SizedBox(height: 10),
              if (state.type == TransactionType.transfer)
                TransactionTransferSelector(
                  accounts: accounts,
                  fromAccount: accounts.where((a) => a.id == state.accountId).firstOrNull,
                  toAccount: accounts.where((a) => a.id == state.destinationAccountId).firstOrNull,
                  onPickFromAccount: (acc) => notifier.setAccount(acc.id),
                  onPickToAccount: (acc) => notifier.setDestinationAccount(acc.id),
                  onSwapAccounts: notifier.swapAccounts,
                ),
            ],
          ),
        ),
        if (state.type != TransactionType.transfer)
          AccountSelectorShelf(
            accounts: accounts,
            selectedAccountId: state.accountId,
            onAccountSelected: (acc) => notifier.setAccount(acc.id),
          ),
        if (isSplit)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 14),
                TransactionAmountDisplay(
                  amountExpression: state.amountExpression,
                  historyExpression: state.historyExpression,
                  currencyCode: currencyCode,
                ),
                TransactionSplitSummaryCard(
                  splits: state.splitItems!,
                  transactionType: state.type,
                  onEdit: openSplitSheet,
                  onClear: () => notifier.setSplitItems(null),
                ),
                const SizedBox(height: 18),
                if (state.isLoading)
                  const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(child: FCircularProgress()),
                  )
                else
                  FButton(
                    onPress: () {
                      HapticFeedback.mediumImpact();
                      notifier.save();
                    },
                    child: Text(t.transactions.saveSplitTransaction),
                  ),
                const SizedBox(height: 18),
              ],
            ),
          )
        else
          TransactionCalculatorBody(
            amountExpression: state.amountExpression,
            historyExpression: state.historyExpression,
            note: state.note,
            type: state.type,
            typeColor: typeColor,
            allocation: state.allocation,
            currencyCode: currencyCode,
            categories: categories.where((c) {
              if (!c.isActive) return false;
              if (state.type == TransactionType.income) return c.type == CategoryType.income;
              if (state.type == TransactionType.expense) return c.type == CategoryType.expense;
              return false;
            }).toList(),
            selectedCategoryId: state.categoryId,
            isLoading: state.isLoading,
            showSplitButton: state.type == TransactionType.expense,
            showCategoryShelf: state.type != TransactionType.transfer,
            onSplitPressed: openSplitSheet,
            onPickNote: showNoteEditor,
            onAllocationChanged: notifier.setAllocation,
            onCategorySelected: (cat) => notifier.setCategory(cat?.id),
            onKeyPressed: (key) {
              if (key == 'OK') {
                HapticFeedback.mediumImpact();
                notifier.save();
              } else {
                notifier.onKeyPressed(key);
              }
            },
            onDone: () {}, // Handled by OK inside onKeyPressed now
          ),
      ],
    );
  }
}
