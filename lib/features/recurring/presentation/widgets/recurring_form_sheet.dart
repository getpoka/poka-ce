/// Bottom sheet for creating or editing a recurring transaction.
///
/// Per PLANS.md §6: recurring transactions are blueprints — they store the
/// schedule and generate real transactions automatically on due dates.
library;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/recurring/domain/recurring_model.dart';
import 'package:poka_ce/features/recurring/presentation/controllers/recurring_form_notifier.dart';
import 'package:poka_ce/features/recurring/presentation/controllers/recurring_list_notifier.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/forms/components/transaction_create_meta_bar.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/forms/components/transaction_type_switcher.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_category_selector.dart';
import 'package:poka_ce/shared/widgets/poka_form_label.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/shared/widgets/poka_pocket_selector.dart';
import 'package:poka_ce/shared/widgets/poka_switch.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';
import 'package:poka_ce/theme/theme.dart';

/// Bottom sheet for creating or editing a [RecurringTransactionModel].
class RecurringFormSheet extends HookConsumerWidget {
  const RecurringFormSheet({
    super.key,
    this.initialRecurring,
  });

  final RecurringTransactionModel? initialRecurring;

  /// Shows the sheet from any [BuildContext].
  static Future<void> show(
    BuildContext context, {
    RecurringTransactionModel? initialRecurring,
  }) {
    return showPokaSheet(
      context: context,
      builder: (context) => RecurringFormSheet(initialRecurring: initialRecurring),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(recurringFormProvider.notifier);
    final state = ref.watch(recurringFormProvider);

    final isEditing = initialRecurring != null;

    // Initialise notifier once when the sheet opens.
    useEffect(() {
      Future.microtask(() => notifier.init(initialRecurring));
      return null;
    }, [initialRecurring]);

    // Text controllers tied to notifier state.
    final noteController = useTextEditingController(text: initialRecurring?.note ?? state.note ?? '');

    useEffect(() {
      void onNote() {
        if (state.note != noteController.text) notifier.setNote(noteController.text);
      }

      noteController.addListener(onNote);
      return () => noteController.removeListener(onNote);
    }, [noteController]);

    // React to save success and errors.
    ref.listen<RecurringFormState>(recurringFormProvider, (prev, next) {
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

    final accounts = ref.watch(dashboardProvider).accounts;
    final categories = ref.watch(categoryListProvider).value ?? <CategoryModel>[];

    final selectedAccount = accounts.where((a) => a.id == state.accountId).firstOrNull;
    final selectedDestAccount = accounts.where((a) => a.id == state.destinationAccountId).firstOrNull;
    final selectedCategory = categories.where((c) => c.id == state.categoryId).firstOrNull;

    final isTransfer = state.type == TransactionType.transfer;
    final formKey = useMemoized(GlobalKey<FormState>.new);

    return PokaSheet(
      title: isEditing ? 'Edit Recurring' : 'New Recurring',
      trailing: isEditing
          ? GestureDetector(
              onTap: () async {
                await ref.read(recurringListProvider.notifier).deleteRecurring(initialRecurring!.id);
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
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Type selector ─────────────────────────────────────────────
            TransactionTypeSwitcher(
              selectedType: state.type,
              onChanged: notifier.setType,
            ),
            const SizedBox(height: 12),

            // ── Amount ─────────────────────────────────────────────
            _AmountTile(
              amount: state.amount,
              onChanged: notifier.setAmount,
            ),
            const SizedBox(height: 12),

            // ── Period ────────────────────────────────────────────────────
            _PeriodSelector(
              selected: state.period,
              onChanged: notifier.setPeriod,
            ),
            const SizedBox(height: 12),

            // ── Start date ────────────────────────────────────────────
            _DatePickerTile(
              date: state.nextDate,
              onChanged: notifier.setNextDate,
            ),
            const SizedBox(height: 12),

            // ── Account + Category / Destination ───────────────────────────
            FormField<String>(
              key: ValueKey(state.accountId),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              initialValue: state.accountId.isEmpty ? null : state.accountId,
              validator: (value) => (value == null || value.isEmpty) ? 'Must select an account' : null,
              builder: (fieldState) => FLabel(
                layout: FLabelLayout.vertical,
                label: Text(t.recurring.transactionDetails),
                error: fieldState.hasError ? Text(fieldState.errorText!) : null,
                child: FCard(
                  child: Column(
                    children: [
                      _ScopeTile(
                        key: const Key('recurring-account-selector'),
                        icon: FPhosphorIcons.wallet,
                        customIcon: selectedAccount != null
                            ? PokaIcon(
                                icon: IconUtil.getIcon(selectedAccount.icon),
                                color: selectedAccount.color?.toColor() ?? context.theme.colors.mutedForeground,
                                size: PokaIconSize.small,
                                useThemeBorderColor: true,
                              )
                            : null,
                        label: isTransfer ? 'Source Account' : 'Account',
                        value: selectedAccount?.name ?? 'Select account',
                        hasValue: selectedAccount != null,
                        onTap: () async {
                          final acc = await PokaPocketSelector.show(
                            context,
                            accounts: accounts,
                          );
                          if (acc != null) {
                            notifier.setAccountId(acc.id);
                            fieldState.didChange(acc.id);
                          }
                        },
                      ),
                      if (isTransfer) ...[
                        Divider(height: 1, color: context.theme.colors.border),
                        _ScopeTile(
                          icon: FPhosphorIcons.arrowRight,
                          customIcon: selectedDestAccount != null
                              ? PokaIcon(
                                  icon: IconUtil.getIcon(selectedDestAccount.icon),
                                  color: selectedDestAccount.color?.toColor() ?? context.theme.colors.mutedForeground,
                                  size: PokaIconSize.small,
                                  useThemeBorderColor: true,
                                )
                              : null,
                          label: t.recurring.destinationAccount,
                          value: selectedDestAccount?.name ?? 'Select destination',
                          hasValue: selectedDestAccount != null,
                          onTap: () async {
                            final acc = await PokaPocketSelector.show(
                              context,
                              accounts: accounts,
                            );
                            if (acc != null) {
                              notifier.setDestinationAccountId(acc.id);
                            }
                          },
                        ),
                      ] else ...[
                        Divider(height: 1, color: context.theme.colors.border),
                        _ScopeTile(
                          key: const Key('recurring-category-selector'),
                          icon: FPhosphorIcons.tag,
                          customIcon: selectedCategory != null
                              ? PokaIcon(
                                  icon: IconUtil.getIcon(selectedCategory.icon),
                                  color: selectedCategory.color?.toColor() ?? context.theme.colors.mutedForeground,
                                  size: PokaIconSize.small,
                                  useThemeBorderColor: true,
                                )
                              : null,
                          label: t.recurring.category,
                          value: selectedCategory?.name ?? 'Select category (optional)',
                          hasValue: selectedCategory != null,
                          onClear: () => notifier.setCategoryId(null),
                          onTap: () async {
                            final filtered = _filteredCategories(
                              categories,
                              state.type,
                            );
                            final cat = await PokaCategorySelector.show(
                              context,
                              categories: filtered,
                            );
                            if (cat != null) notifier.setCategoryId(cat.id);
                          },
                        ),
                        if (state.type == TransactionType.expense) ...[
                          Divider(height: 1, color: context.theme.colors.border),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            child: Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: context.theme.colors.muted,
                                    borderRadius: context.theme.style.borderRadius.sm,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      FPhosphorIcons.chartPie,
                                      size: 18,
                                      color: context.theme.colors.mutedForeground,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        t.recurring.allocation,
                                        style: context.theme.typography.bodySecondary.copyWith(
                                          color: context.theme.colors.mutedForeground,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      TransactionAllocationSelector(
                                        allocation: state.allocation,
                                        onChanged: notifier.setAllocation,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ── Note ─────────────────────────────────────────────
            FTextFormField(
              control: FTextFieldControl.managed(controller: noteController),
              label: const PokaFormLabel('Note', isOptional: true),
              hint: t.recurring.egNetflixSubscription,
              maxLines: 2,
            ),
            const SizedBox(height: 12),

            // ── Active toggle ─────────────────────────────────────────────
            _ActiveToggle(
              isActive: state.isActive,
              onChanged: (v) => notifier.setIsActive(isActive: v),
            ),

            // ── Info banner ───────────────────────────────────────────────
            const SizedBox(height: 12),
            _InfoBanner(),

            const SizedBox(height: 20),

            // ── Save button ───────────────────────────────────────────────
            if (state.isSaving)
              const Center(child: FCircularProgress())
            else
              FButton(
                onPress: () {
                  if (formKey.currentState!.validate()) {
                    notifier.save();
                  }
                },
                child: Text(isEditing ? 'Save Changes' : 'Create Recurring'),
              ),
          ],
        ),
      ),
    );
  }

  List<CategoryModel> _filteredCategories(
    List<CategoryModel> categories,
    TransactionType type,
  ) {
    if (type == TransactionType.income) {
      return categories.where((c) => c.type == CategoryType.income).toList();
    }
    return categories.where((c) => c.type == CategoryType.expense).toList();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Amount tile — tappable row that opens a simple number input dialog
// ─────────────────────────────────────────────────────────────────────────────

class _AmountTile extends HookWidget {
  const _AmountTile({required this.amount, required this.onChanged});

  final int amount;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(
      text: amount > 0 ? amount.toString() : '',
    );

    useEffect(() {
      final newText = amount > 0 ? amount.toString() : '';
      if (controller.text != newText && newText.isNotEmpty) {
        Future.microtask(() => controller.text = newText);
      }
      return null;
    }, [amount]);

    useEffect(() {
      void listener() {
        final parsed = int.tryParse(controller.text) ?? 0;
        onChanged(parsed);
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    return FTextFormField(
      control: FTextFieldControl.managed(controller: controller),
      label: Text(t.recurring.amount),
      hint: '0',
      keyboardType: TextInputType.number,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        final amount = int.tryParse(value ?? '');
        if (amount == null || amount <= 0) return 'Amount must be greater than 0';
        return null;
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Period selector — segmented row of labeled chips
// ─────────────────────────────────────────────────────────────────────────────

class _PeriodSelector extends StatelessWidget {
  const _PeriodSelector({required this.selected, required this.onChanged});

  final RecurringPeriod selected;
  final ValueChanged<RecurringPeriod> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FLabel(
      layout: FLabelLayout.vertical,
      label: Text(t.recurring.frequency),
      child: Row(
        children: RecurringPeriod.values.map((period) {
          final isSelected = period == selected;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(period),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                margin: const EdgeInsets.symmetric(horizontal: 2),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? theme.colors.primary.withValues(alpha: 0.1) : Colors.transparent,
                  borderRadius: theme.style.borderRadius.sm,
                  border: Border.all(
                    color: isSelected ? theme.colors.primary : theme.colors.border,
                  ),
                ),
                child: Text(
                  _label(period),
                  textAlign: TextAlign.center,
                  style: theme.typography.bodySecondary.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isSelected ? theme.colors.primary : theme.colors.mutedForeground,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _label(RecurringPeriod period) => switch (period) {
    RecurringPeriod.daily => 'Daily',
    RecurringPeriod.weekly => 'Weekly',
    RecurringPeriod.monthly => 'Monthly',
    RecurringPeriod.yearly => 'Yearly',
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// Date picker tile — uses FPopover + FCalendar
// ─────────────────────────────────────────────────────────────────────────────

class _DatePickerTile extends HookWidget {
  const _DatePickerTile({required this.date, required this.onChanged});

  final DateTime? date;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final text = date != null ? DateFormat.yMMMd().format(date!) : '';
    final controller = useTextEditingController(text: text);

    useEffect(() {
      if (controller.text != text) {
        Future.microtask(() {
          if (context.mounted) controller.text = text;
        });
      }
      return null;
    }, [text]);

    return FPopover(
      builder: (context, popoverController, child) {
        return FTextFormField(
          control: FTextFieldControl.managed(controller: controller),
          label: Text(t.recurring.startDate),
          hint: t.recurring.selectFirstDueDate,
          readOnly: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) => (value == null || value.isEmpty) ? 'Must select a start date' : null,
          onTap: () {
            FocusScope.of(context).unfocus();
            popoverController.toggle();
          },
          prefixBuilder: (context, style, variants) => FTextField.prefixIconBuilder(
            context,
            style,
            variants,
            const Icon(FPhosphorIcons.calendarBlank, size: 18),
          ),
          suffixBuilder: (context, style, variants) => Padding(
            padding: const EdgeInsetsDirectional.only(end: 12, start: 4),
            child: IconTheme(
              data: style.iconStyle.resolve(variants),
              child: const Icon(FPhosphorIcons.caretDown, size: 16),
            ),
          ),
        );
      },
      popoverBuilder: (context, popoverController) {
        return FCalendar.grid(
          selectionControl: FDateSelectionControl.managedSingle(
            initial: date,
            onChange: (newDate) {
              if (newDate != null) onChanged(newDate);
              popoverController.hide();
            },
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Scope tile row — account / category selector row inside an FCard
// ─────────────────────────────────────────────────────────────────────────────

class _ScopeTile extends StatelessWidget {
  const _ScopeTile({
    required this.label,
    required this.value,
    required this.hasValue,
    required this.onTap,
    super.key,
    this.icon,
    this.customIcon,
    this.onClear,
  });

  final IconData? icon;
  final Widget? customIcon;
  final String label;
  final String value;
  final bool hasValue;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            customIcon ??
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: theme.colors.muted,
                    borderRadius: theme.style.borderRadius.sm,
                  ),
                  child: Center(
                    child: Icon(icon, size: 18, color: theme.colors.mutedForeground),
                  ),
                ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: theme.typography.bodySecondary.copyWith(
                      color: theme.colors.mutedForeground,
                    ),
                  ),
                  Text(
                    value,
                    style: theme.typography.bodyPrimary.copyWith(
                      fontWeight: FontWeight.w500,
                      color: hasValue ? theme.colors.foreground : theme.colors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
            if (hasValue && onClear != null)
              GestureDetector(
                onTap: onClear,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: Icon(FPhosphorIcons.x, size: 16, color: theme.colors.mutedForeground),
                ),
              )
            else
              Icon(
                FPhosphorIcons.caretRight,
                size: 14,
                color: theme.colors.mutedForeground,
              ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Active toggle row
// ─────────────────────────────────────────────────────────────────────────────

class _ActiveToggle extends StatelessWidget {
  const _ActiveToggle({required this.isActive, required this.onChanged});

  final bool isActive;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return FCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: theme.colors.muted,
                borderRadius: theme.style.borderRadius.sm,
              ),
              child: Center(
                child: Icon(
                  FPhosphorIcons.repeat,
                  size: 18,
                  color: theme.colors.mutedForeground,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.recurring.active,
                    style: theme.typography.bodyPrimary.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    isActive ? 'Will auto-generate transactions' : 'Paused — no transactions will be generated',
                    style: theme.typography.bodySecondary.copyWith(
                      color: theme.colors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
            PokaSwitch(value: isActive, onChange: onChanged),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Info banner
// ─────────────────────────────────────────────────────────────────────────────

class _InfoBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colors.muted,
        borderRadius: theme.style.borderRadius.sm,
      ),
      child: Row(
        children: [
          Icon(
            FPhosphorIcons.info,
            size: 14,
            color: theme.colors.mutedForeground,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              t.recurring.eachTimeTheAppOpensOverdueRecurringTransactionsAre,
              style: theme.typography.bodySecondary.copyWith(
                color: theme.colors.mutedForeground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
