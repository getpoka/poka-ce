import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/goals/domain/goal_model.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_form_notifier.dart';
import 'package:poka_ce/features/goals/presentation/widgets/goal_date_picker_tile.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';
import 'package:poka_ce/theme/theme.dart';

/// Bottom sheet for creating or editing a savings goal.
/// When creating, the system automatically generates a linked Pocket account.
class GoalFormSheet extends HookConsumerWidget {
  const GoalFormSheet({
    super.key,
    this.initialGoal,
    this.initialName,
    this.initialTargetAmount,
    this.initialTargetDate,
  });

  final GoalModel? initialGoal;
  final String? initialName;
  final int? initialTargetAmount;
  final DateTime? initialTargetDate;

  /// Shows the sheet and returns when the user dismisses or saves.
  static Future<void> show(
    BuildContext context, {
    GoalModel? initialGoal,
    String? initialName,
    int? initialTargetAmount,
    DateTime? initialTargetDate,
  }) {
    return showPokaSheet(
      context: context,
      builder: (context) => GoalFormSheet(
        initialGoal: initialGoal,
        initialName: initialName,
        initialTargetAmount: initialTargetAmount,
        initialTargetDate: initialTargetDate,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(goalFormProvider.notifier);
    final state = ref.watch(goalFormProvider);

    // Initialise the notifier once with the given goal.
    useEffect(() {
      Future.microtask(
        () => notifier.init(
          initialGoal,
          initialName: initialName,
          initialTargetAmount: initialTargetAmount,
          initialTargetDate: initialTargetDate,
        ),
      );
      return null;
    }, [initialGoal, initialName, initialTargetAmount, initialTargetDate]);

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
        showFToast(
          context: context,
          title: Text(next.error!),
          variant: FToastVariant.destructive,
        );
      }
    });

    final isEditing = initialGoal != null;
    final formKey = useMemoized(GlobalKey<FormState>.new);

    return PokaSheet(
      title: isEditing ? 'Edit Goal' : 'New Goal',
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
              validator: (value) => value == null || value.trim().isEmpty ? 'Name cannot be empty' : null,
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
                if (amount == null || amount <= 0) return 'Target amount must be greater than 0';
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
                    Icon(
                      FPhosphorIcons.info,
                      size: 16,
                      color: context.theme.colors.mutedForeground,
                    ),
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
                child: Text(isEditing ? 'Save Changes' : 'Create Goal'),
              ),
          ],
        ),
      ),
    );
  }
}
