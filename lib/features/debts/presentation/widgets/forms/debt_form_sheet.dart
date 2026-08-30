import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';
import 'package:poka_ce/features/debts/presentation/controllers/debt_form_notifier.dart';
import 'package:poka_ce/features/debts/presentation/controllers/debt_list_notifier.dart';
import 'package:poka_ce/features/debts/presentation/widgets/forms/debt_date_picker.dart';
import 'package:poka_ce/features/debts/presentation/widgets/forms/debt_type_selector.dart';
import 'package:poka_ce/features/debts/presentation/widgets/tiles/debt_scope_tile.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_category_selector.dart';
import 'package:poka_ce/shared/widgets/poka_form_label.dart';
import 'package:poka_ce/shared/widgets/poka_pocket_selector.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';
import 'package:poka_ce/theme/theme.dart';

class DebtFormSheet extends HookConsumerWidget {
  const DebtFormSheet({super.key, this.initialDebt});

  final DebtModel? initialDebt;

  static Future<void> show(BuildContext context, {DebtModel? initialDebt}) {
    return showPokaSheet(
      context: context,
      builder: (context) => DebtFormSheet(initialDebt: initialDebt),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(debtFormProvider.notifier);
    final state = ref.watch(debtFormProvider);

    useEffect(() {
      Future.microtask(() => notifier.init(initialDebt));
      return null;
    }, [initialDebt]);

    final personController = useTextEditingController(text: initialDebt?.personName ?? state.personName);
    final amountController = useTextEditingController(
      text: initialDebt != null && initialDebt!.amount > 0
          ? initialDebt!.amount.toString()
          : (state.amount > 0 ? state.amount.toString() : ''),
    );
    final noteController = useTextEditingController(text: initialDebt?.note ?? state.note ?? '');

    useEffect(() {
      void onPerson() {
        if (state.personName != personController.text) notifier.setPersonName(personController.text);
      }

      void onAmount() {
        final val = int.tryParse(amountController.text) ?? 0;
        if (state.amount != val) notifier.setAmount(val);
      }

      void onNote() {
        if (state.note != noteController.text) notifier.setNote(noteController.text);
      }

      personController.addListener(onPerson);
      amountController.addListener(onAmount);
      noteController.addListener(onNote);
      return () {
        personController.removeListener(onPerson);
        amountController.removeListener(onAmount);
        noteController.removeListener(onNote);
      };
    }, [personController, amountController, noteController]);

    ref.listen(debtFormProvider, (prev, next) {
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

    final categories = ref.watch(categoryListProvider).value ?? <CategoryModel>[];
    final accounts = ref.watch(dashboardProvider).accounts;

    final selectedCategory = categories.where((c) => c.id == state.categoryId).firstOrNull;
    final selectedAccount = accounts.where((a) => a.id == state.accountId).firstOrNull;

    final isEditing = initialDebt != null;

    return PokaSheet(
      title: isEditing ? 'Edit Record' : 'New Record',
      trailing: isEditing
          ? GestureDetector(
              onTap: () async {
                await ref.read(debtListProvider.notifier).deleteDebt(initialDebt!.id);
                if (context.mounted) Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  FPhosphorIcons.trash,
                  size: 18,
                  color: context.theme.colors.destructive,
                ),
              ),
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DebtTypeSelector(
            selected: state.type,
            onChanged: isEditing ? null : notifier.setType,
          ),
          const SizedBox(height: 12),
          FTextField(
            control: FTextFieldControl.managed(controller: personController),
            label: Text(t.debts.personName),
            hint: t.debts.egJohnDoe,
          ),
          const SizedBox(height: 12),
          FTextField(
            control: FTextFieldControl.managed(controller: amountController),
            label: Text(t.debts.principalAmount),
            hint: '0',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          if (!isEditing) ...[
            FLabel(
              layout: FLabelLayout.vertical,
              label: Text(t.debts.transactionBinding),
              child: FCard(
                child: Column(
                  children: [
                    DebtScopeTile(
                      key: const Key('debt-category-selector'),
                      icon: FPhosphorIcons.tag,
                      label: t.debts.category,
                      value: selectedCategory?.name ?? 'Select category',
                      hasValue: selectedCategory != null,
                      onTap: () async {
                        final cat = await PokaCategorySelector.show(context, categories: categories);
                        if (cat != null) notifier.setCategoryId(cat.id);
                      },
                    ),
                    Divider(height: 1, color: context.theme.colors.border),
                    DebtScopeTile(
                      key: const Key('debt-account-selector'),
                      icon: FPhosphorIcons.wallet,
                      label: t.debts.account,
                      value: selectedAccount?.name ?? 'Select account',
                      hasValue: selectedAccount != null,
                      onTap: () async {
                        final acc = await PokaPocketSelector.show(context, accounts: accounts);
                        if (acc != null) notifier.setAccountId(acc.id);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: context.theme.colors.muted,
                borderRadius: context.theme.style.borderRadius.sm,
              ),
              child: Row(
                children: [
                  Icon(FPhosphorIcons.info, size: 14, color: context.theme.colors.mutedForeground),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      state.type == DebtType.debt
                          ? 'Recording this debt adds money to the account (income transaction).'
                          : 'Recording this loan removes money from the account (expense transaction).',
                      style: context.theme.typography.bodySecondary.copyWith(
                        color: context.theme.colors.mutedForeground,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
          DebtDatePicker(
            date: state.dueDate,
            onChanged: notifier.setDueDate,
            onClear: () => notifier.setDueDate(null),
          ),
          const SizedBox(height: 12),
          FTextField(
            control: FTextFieldControl.managed(controller: noteController),
            label: const PokaFormLabel('Note', isOptional: true),
            hint: t.debts.egDinnerLastFriday,
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          if (state.isSaving)
            const Center(child: FCircularProgress())
          else
            FButton(
              onPress: notifier.save,
              child: Text(isEditing ? 'Save Changes' : 'Create Record'),
            ),
        ],
      ),
    );
  }
}
