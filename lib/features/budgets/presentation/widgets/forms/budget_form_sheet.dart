import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:poka_ce/features/budgets/presentation/controllers/budget_form_notifier.dart';
import 'package:poka_ce/features/budgets/presentation/widgets/pickers/date_picker_button.dart';
import 'package:poka_ce/features/budgets/presentation/widgets/pickers/period_selector.dart';
import 'package:poka_ce/features/budgets/presentation/widgets/tiles/scope_tile.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_category_selector.dart';
import 'package:poka_ce/shared/widgets/poka_form_label.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/shared/widgets/poka_pocket_selector.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';

class BudgetFormSheet extends HookConsumerWidget {
  const BudgetFormSheet({super.key, this.initialBudget});

  final BudgetModel? initialBudget;

  static Future<void> show(BuildContext context, {BudgetModel? initialBudget}) {
    return showPokaSheet(
      context: context,
      builder: (context) => BudgetFormSheet(initialBudget: initialBudget),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(budgetFormProvider.notifier);
    final state = ref.watch(budgetFormProvider);

    useEffect(() {
      Future.microtask(() => notifier.init(initialBudget));
      return null;
    }, [initialBudget]);

    final nameController = useTextEditingController(text: initialBudget?.name ?? state.name);
    final amountController = useTextEditingController(
      text: initialBudget != null && initialBudget!.amount > 0
          ? initialBudget!.amount.toString()
          : (state.amount > 0 ? state.amount.toString() : ''),
    );
    final resetDayController = useTextEditingController(
      text: initialBudget?.resetDay?.toString() ?? (state.resetDay != null ? state.resetDay.toString() : ''),
    );
    final alertThresholdController = useTextEditingController(
      text:
          initialBudget?.alertThreshold?.toString() ??
          (state.alertThreshold != null ? state.alertThreshold.toString() : ''),
    );

    useEffect(() {
      void onName() {
        if (state.name != nameController.text) notifier.setName(nameController.text);
      }

      void onAmount() {
        final val = int.tryParse(amountController.text) ?? 0;
        if (state.amount != val) notifier.setAmount(val);
      }

      void onResetDay() {
        final val = int.tryParse(resetDayController.text);
        if (state.resetDay != val) notifier.setResetDay(val);
      }

      void onAlertThreshold() {
        final val = int.tryParse(alertThresholdController.text);
        if (state.alertThreshold != val) notifier.setAlertThreshold(val);
      }

      nameController.addListener(onName);
      amountController.addListener(onAmount);
      resetDayController.addListener(onResetDay);
      alertThresholdController.addListener(onAlertThreshold);
      return () {
        nameController.removeListener(onName);
        amountController.removeListener(onAmount);
        resetDayController.removeListener(onResetDay);
        alertThresholdController.removeListener(onAlertThreshold);
      };
    }, [nameController, amountController, resetDayController, alertThresholdController]);

    ref.listen(budgetFormProvider, (prev, next) {
      if (next.isSuccess && (prev?.isSuccess != true)) {
        Navigator.of(context).pop();
      }
      if (next.error != null && next.error != prev?.error) {
        showFToast(
          context: context,
          title: Text(next.error!),
          variant: FToastVariant.destructive,
        );
      }
    });

    final allAccounts = ref.watch(regularAccountListProvider).value?.accounts ?? [];
    final budgetAccounts = allAccounts;
    final allCategories = ref.watch(categoryListProvider).value ?? <CategoryModel>[];
    final expenseCategories = allCategories.where((c) => c.type == CategoryType.expense).toList();

    final selectedAccount = allAccounts.where((a) => a.id == state.accountId).firstOrNull;
    final selectedCategory = allCategories.where((c) => c.id == state.categoryId).firstOrNull;

    final isEditing = initialBudget != null;
    final formKey = useMemoized(GlobalKey<FormState>.new);

    return PokaSheet(
      title: isEditing ? 'Edit Budget' : 'New Budget',
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FTextFormField(
              control: FTextFieldControl.managed(controller: nameController),
              label: Text(t.budgets.budgetName),
              hint: t.budgets.egGroceriesEntertainment,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => value == null || value.trim().isEmpty ? 'Name cannot be empty' : null,
            ),
            const SizedBox(height: 12),
            FTextFormField(
              control: FTextFieldControl.managed(controller: amountController),
              label: Text(t.budgets.spendingLimit),
              hint: '0',
              keyboardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                final amount = int.tryParse(value ?? '');
                if (amount == null || amount <= 0) return 'Amount must be greater than 0';
                return null;
              },
            ),
            const SizedBox(height: 12),
            FTextFormField(
              control: FTextFieldControl.managed(controller: alertThresholdController),
              label: const PokaFormLabel('Alert threshold (%)', isOptional: true),
              hint: t.budgets.eg80,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            FLabel(
              layout: FLabelLayout.vertical,
              label: Text(t.budgets.period),
              child: PeriodSelector(
                selected: state.period,
                onChanged: notifier.setPeriod,
              ),
            ),
            const SizedBox(height: 12),
            if (state.period == BudgetPeriod.monthly) ...[
              FTextFormField(
                control: FTextFieldControl.managed(controller: resetDayController),
                label: Text(t.budgets.resetDay),
                hint: '1',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
            ],
            if (state.period == BudgetPeriod.custom) ...[
              DatePickerButton(
                date: state.endDate,
                onChanged: notifier.setEndDate,
              ),
              const SizedBox(height: 12),
            ],
            FLabel(
              layout: FLabelLayout.vertical,
              label: const PokaFormLabel('Scope', isOptional: true),
              child: FCard(
                child: Column(
                  children: [
                    ScopeTile(
                      defaultIcon: FPhosphorIcons.tag,
                      prefixWidget: selectedCategory != null
                          ? PokaIcon(
                              icon: IconUtil.getIcon(selectedCategory.icon),
                              color: selectedCategory.color?.toColor() ?? context.theme.colors.primary,
                              size: PokaIconSize.small,
                              useThemeBorderColor: true,
                            )
                          : null,
                      label: t.budgets.category,
                      value: selectedCategory?.name ?? 'Any category',
                      hasValue: selectedCategory != null,
                      onClear: () => notifier.setCategoryId(null),
                      onTap: () async {
                        final cat = await PokaCategorySelector.show(context, categories: expenseCategories);
                        if (cat != null) {
                          notifier.setCategoryId(cat.id);
                        }
                      },
                    ),
                    Divider(height: 1, color: context.theme.colors.border),
                    ScopeTile(
                      defaultIcon: FPhosphorIcons.wallet,
                      prefixWidget: selectedAccount != null
                          ? PokaIcon(
                              icon: IconUtil.getIcon(selectedAccount.icon),
                              color: selectedAccount.color?.toColor() ?? context.theme.colors.primary,
                              size: PokaIconSize.small,
                              useThemeBorderColor: true,
                            )
                          : null,
                      label: t.budgets.account,
                      value: selectedAccount?.name ?? 'Any account',
                      hasValue: selectedAccount != null,
                      onClear: () => notifier.setAccountId(null),
                      onTap: () async {
                        final acc = await PokaPocketSelector.show(context, accounts: budgetAccounts);
                        if (acc != null) {
                          notifier.setAccountId(acc.id);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (state.isSaving)
              const Center(child: FCircularProgress())
            else
              FButton(
                onPress: () {
                  if (formKey.currentState!.validate()) {
                    notifier.save();
                  }
                },
                child: Text(isEditing ? 'Save Changes' : 'Create Budget'),
              ),
          ],
        ),
      ),
    );
  }
}
