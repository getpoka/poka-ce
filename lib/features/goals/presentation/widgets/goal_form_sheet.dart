import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/goals/domain/goal_model.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_form_notifier.dart';
import 'package:poka_ce/features/goals/presentation/widgets/forms/fields/goal_account_picker_tile.dart';
import 'package:poka_ce/features/goals/presentation/widgets/forms/fields/goal_auto_pocket_banner.dart';
import 'package:poka_ce/features/goals/presentation/widgets/goal_date_picker_tile.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_toast.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';
import 'package:poka_ce/theme/theme.dart';

/// Bottom sheet for creating or editing a savings goal.
/// When creating, the system automatically generates a linked Pocket account under the chosen root account.
class GoalFormSheet extends HookConsumerWidget {
  /// Creates a [GoalFormSheet].
  const new({
    super.key,
    this.initialGoal,
    this.initialName,
    this.initialTargetAmount,
    this.initialTargetDate,
    this.initialParentAccountId,
  });

  /// The goal being edited, or null when creating a new goal.
  final GoalModel? initialGoal;

  /// Optional initial name for draft prefill.
  final String? initialName;

  /// Optional initial target amount for draft prefill.
  final int? initialTargetAmount;

  /// Optional initial target deadline date.
  final DateTime? initialTargetDate;

  /// Optional initial parent account identifier.
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
      persistent: true,
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

    // Initialize notifier state once with the provided arguments
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

    // Automatically pre-select first account when none is chosen in creation mode
    useEffect(() {
      if (initialGoal == null && state.parentAccountId == null && regularAccounts.isNotEmpty) {
        Future.microtask(() => notifier.setParentAccountId(initialParentAccountId ?? regularAccounts.first.id));
      }
      return null;
    }, [regularAccounts, state.parentAccountId, initialGoal, initialParentAccountId]);

    final nameController = useTextEditingController(text: initialGoal?.name ?? initialName ?? state.name);
    final amountController = useTextEditingController(
      text: initialGoal != null && initialGoal!.targetAmount > 0
          ? initialGoal!.targetAmount.toString()
          : (initialTargetAmount != null && initialTargetAmount! > 0
                ? initialTargetAmount.toString()
                : (state.targetAmount > 0 ? state.targetAmount.toString() : '')),
    );

    useEffect(() {
      void syncInputs() {
        if (state.name != nameController.text) notifier.setName(nameController.text);
        final val = int.tryParse(amountController.text) ?? 0;
        if (state.targetAmount != val) notifier.setTargetAmount(val);
      }

      nameController.addListener(syncInputs);
      amountController.addListener(syncInputs);
      return () {
        nameController.removeListener(syncInputs);
        amountController.removeListener(syncInputs);
      };
    }, [nameController, amountController]);

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
            FTextFormField(
              control: FTextFieldControl.managed(controller: nameController),
              label: Text(t.goals.goalName),
              hint: t.goals.egEmergencyFundNewLaptop,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => value == null || value.trim().isEmpty ? t.goals.nameCannotBeEmpty : null,
            ),
            const SizedBox(height: 12),
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
            GoalDatePickerTile(
              date: state.targetDate,
              onChanged: notifier.setTargetDate,
              onClear: () => notifier.setTargetDate(null),
            ),
            const SizedBox(height: 12),
            GoalAccountPickerTile(
              accounts: regularAccounts,
              selectedAccountId: state.parentAccountId,
              isEditing: isEditing,
              onAccountSelected: notifier.setParentAccountId,
            ),
            const SizedBox(height: 12),
            if (!isEditing) ...[
              const GoalAutoPocketBanner(),
              const SizedBox(height: 20),
            ] else
              const SizedBox(height: 8),
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
