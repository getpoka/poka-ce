import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/daily_budget_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';

class DashboardBudgetSheet extends HookConsumerWidget {
  const DashboardBudgetSheet({
    required this.currentBudget,
    super.key,
  });

  final double currentBudget;

  static void show(BuildContext context, {required double currentBudget}) {
    showPokaSheet<void>(
      context: context,
      fitContent: true,
      builder: (context) => DashboardBudgetSheet(currentBudget: currentBudget),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(
      text: currentBudget > 0 ? currentBudget.toInt().toString() : '',
    );

    return PokaSheet(
      title: context.t.dashboard.setDailyBudget,
      isScrollable: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FTextField(
            control: FTextFieldControl.managed(controller: controller),
            label: Text(context.t.dashboard.amount),
            hint: context.t.dashboard.amountHint,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FButton(
              onPress: () {
                final amount = double.tryParse(controller.text);
                if (amount != null) {
                  ref.read(dailyBudgetProvider.notifier).setBudget(amount);
                }
                Navigator.of(context).pop();
              },
              child: Text(context.t.common.save),
            ),
          ),
        ],
      ),
    );
  }
}
