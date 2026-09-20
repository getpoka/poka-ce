import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/goals/domain/goal_model.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_form_notifier.dart';
import 'package:poka_ce/features/goals/presentation/widgets/goal_date_picker_tile.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/shared/widgets/poka_toast.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';
import 'package:poka_ce/theme/theme.dart';

/// Bottom sheet for creating or editing a savings goal.
/// When creating, the system automatically generates a linked Pocket account under the chosen root account.
class GoalFormSheet extends HookConsumerWidget {
  const new({
    super.key,
    this.initialGoal,
    this.initialName,
    this.initialTargetAmount,
    this.initialTargetDate,
    this.initialParentAccountId,
  });

  final GoalModel? initialGoal;
  final String? initialName;
  final int? initialTargetAmount;
  final DateTime? initialTargetDate;
  final String? initialParentAccountId;

  /// Shows the sheet and returns when the user dismisses or saves.
  static Future<void> show(
    BuildContext context, {
    GoalModel? initialGoal,
    String? initialName,
    int? initialTargetAmount,
    DateTime? initialTargetDate,
    String? initialParentAccountId,
  }) {
    return showPokaSheet(
      context: context,
      builder: (context) => GoalFormSheet(
        initialGoal: initialGoal,
        initialName: initialName,
        initialTargetAmount: initialTargetAmount,
        initialTargetDate: initialTargetDate,
        initialParentAccountId: initialParentAccountId,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(goalFormProvider.notifier);
    final state = ref.watch(goalFormProvider);
    final regularAccounts =
        ref.watch(regularAccountListProvider).value?.aggregates.map((a) => a.account).toList() ?? [];

    // Initialise the notifier once with the given goal.
    useEffect(() {
      Future.microtask(
        () => notifier.init(
          initialGoal,
          initialName: initialName,
          initialTargetAmount: initialTargetAmount,
          initialTargetDate: initialTargetDate,
          initialParentAccountId: initialParentAccountId,
        ),
      );
      return null;
    }, [initialGoal, initialName, initialTargetAmount, initialTargetDate, initialParentAccountId]);

    // Auto-select first account if not set
    useEffect(() {
      if (initialGoal == null && state.parentAccountId == null && regularAccounts.isNotEmpty) {
        Future.microtask(() => notifier.setParentAccountId(initialParentAccountId ?? regularAccounts.first.id));
      }
      return null;
    }, [regularAccounts, state.parentAccountId, initialGoal, initialParentAccountId]);

    final selectedAccount = regularAccounts.where((a) => a.id == state.parentAccountId).firstOrNull;

    final nameController = useTextEditingController(text: initialGoal?.name ?? initialName ?? state.name);
    final amountController = useTextEditingController(
      text: initialGoal != null && initialGoal!.targetAmount > 0
          ? initialGoal!.targetAmount.toString()
          : (initialTargetAmount != null && initialTargetAmount! > 0
                ? initialTargetAmount.toString()
                : (state.targetAmount > 0 ? state.targetAmount.toString() : '')),
    );

    // Sync controllers → notifier.
    useEffect(() {
      void onName() {
        if (state.name != nameController.text) notifier.setName(nameController.text);
      }

      void onAmount() {
        final val = int.tryParse(amountController.text) ?? 0;
        if (state.targetAmount != val) notifier.setTargetAmount(val);
      }

      nameController.addListener(onName);
      amountController.addListener(onAmount);
      return () {
        nameController.removeListener(onName);
        amountController.removeListener(onAmount);
      };
    }, [nameController, amountController]);

    // React to save success and errors.
    ref.listen(goalFormProvider, (prev, next) {
      if (next.isSuccess && (prev?.isSuccess != true)) {
        Navigator.of(context).pop();
      }
      if (next.error != null && next.error != prev?.error) {
        showPokaToast(context: context, title: Text(next.error!), variant: FToastVariant.destructive);
      }
    });

    final isEditing = initialGoal != null;
    final formKey = useMemoized(GlobalKey<FormState>.new);

    return PokaSheet(
      title: isEditing ? t.goals.editGoal : t.goals.newGoal,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Goal name ────────────────────────────────────────────
            FTextFormField(
              control: FTextFieldControl.managed(controller: nameController),
              label: Text(t.goals.goalName),
              hint: t.goals.egEmergencyFundNewLaptop,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => value == null || value.trim().isEmpty ? t.goals.nameCannotBeEmpty : null,
            ),
            const SizedBox(height: 12),

            // ── Target amount ────────────────────────────────────────────
            FTextFormField(
              control: FTextFieldControl.managed(controller: amountController),
              label: Text(t.goals.targetAmount),
              hint: '0',
              keyboardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                final amount = int.tryParse(value ?? '');
                if (amount == null || amount <= 0) return t.goals.targetAmountGreaterThanZero;
                return null;
              },
            ),
            const SizedBox(height: 12),

            // ── Target date (optional) ───────────────────────────────────────
            GoalDatePickerTile(
              date: state.targetDate,
              onChanged: notifier.setTargetDate,
              onClear: () => notifier.setTargetDate(null),
            ),
            const SizedBox(height: 12),

            // ── Target Account Selector ───────────────────────────────────────
            if (!isEditing) ...[
              FLabel(
                layout: FLabelLayout.vertical,
                label: Text(t.goals.saveInAccount),
                child: GestureDetector(
                  onTap: () {
                    showPokaSheet<void>(
                      context: context,
                      builder: (ctx) => PokaSheet(
                        title: t.goals.selectAccount,
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: regularAccounts.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 8),
                          itemBuilder: (ctx, index) {
                            final acc = regularAccounts[index];
                            final isSel = acc.id == state.parentAccountId;
                            return GestureDetector(
                              onTap: () {
                                notifier.setParentAccountId(acc.id);
                                Navigator.of(ctx).pop();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                decoration: BoxDecoration(
                                  color: isSel
                                      ? context.theme.colors.primary.withValues(alpha: 0.1)
                                      : context.theme.colors.card,
                                  borderRadius: context.theme.style.borderRadius.md,
                                  border: Border.all(
                                    color: isSel ? context.theme.colors.primary : context.theme.colors.border,
                                    width: isSel ? 1.5 : 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    PokaIcon(
                                      icon: IconUtil.getIcon(acc.icon),
                                      color: acc.color?.toColor() ?? context.theme.colors.primary,
                                      size: PokaIconSize.small,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        acc.name,
                                        style: context.theme.typography.bodyPrimary.copyWith(
                                          fontWeight: isSel ? FontWeight.w600 : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    if (isSel)
                                      Icon(FPhosphorIcons.checkCircle, size: 18, color: context.theme.colors.primary),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: context.theme.colors.card,
                      borderRadius: context.theme.style.borderRadius.md,
                      border: Border.all(color: context.theme.colors.border),
                    ),
                    child: Row(
                      children: [
                        if (selectedAccount != null) ...[
                          PokaIcon(
                            icon: IconUtil.getIcon(selectedAccount.icon),
                            color: selectedAccount.color?.toColor() ?? context.theme.colors.primary,
                            size: PokaIconSize.small,
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: Text(selectedAccount.name, style: context.theme.typography.bodyPrimary)),
                        ] else ...[
                          Icon(FPhosphorIcons.wallet, size: 20, color: context.theme.colors.mutedForeground),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              t.goals.selectAccount,
                              style: context.theme.typography.bodySecondary.copyWith(
                                color: context.theme.colors.mutedForeground,
                              ),
                            ),
                          ),
                        ],
                        Icon(FPhosphorIcons.caretDown, size: 16, color: context.theme.colors.mutedForeground),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ] else if (selectedAccount != null) ...[
              FLabel(
                layout: FLabelLayout.vertical,
                label: Text(t.goals.saveInAccount),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: context.theme.colors.muted,
                    borderRadius: context.theme.style.borderRadius.md,
                    border: Border.all(color: context.theme.colors.border),
                  ),
                  child: Row(
                    children: [
                      PokaIcon(
                        icon: IconUtil.getIcon(selectedAccount.icon),
                        color: selectedAccount.color?.toColor() ?? context.theme.colors.primary,
                        size: PokaIconSize.small,
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Text(selectedAccount.name, style: context.theme.typography.bodyPrimary)),
                      Icon(FPhosphorIcons.lock, size: 16, color: context.theme.colors.mutedForeground),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],

            // ── Info note about auto pocket ──────────────────────────────────
            if (!isEditing)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.theme.colors.muted,
                  borderRadius: context.theme.style.borderRadius.sm,
                ),
                child: Row(
                  children: [
                    Icon(FPhosphorIcons.info, size: 16, color: context.theme.colors.mutedForeground),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        t.goals.aDedicatedPocketAccountWillBeCreatedAutomaticallyToTrackThisGoal,
                        style: context.theme.typography.bodySecondary.copyWith(
                          color: context.theme.colors.mutedForeground,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 20),

            // ── Save button ──────────────────────────────────────────────
            if (state.isSaving)
              const Center(child: FCircularProgress())
            else
              FButton(
                onPress: () {
                  if (formKey.currentState!.validate()) {
                    notifier.save();
                  }
                },
                child: Text(isEditing ? t.goals.saveChanges : t.goals.createGoal),
              ),
          ],
        ),
      ),
    );
  }
}
