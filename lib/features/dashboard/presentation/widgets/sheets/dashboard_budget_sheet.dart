import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/extensions/num_extension.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/daily_budget_notifier.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';

class DashboardBudgetSheet extends HookConsumerWidget {
  const new({required this.currentBudget, super.key});

  final double currentBudget;

  static void show(BuildContext context, {required double currentBudget}) {
    showPokaSheet<void>(
      context: context,
      builder: (context) => DashboardBudgetSheet(currentBudget: currentBudget),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final precision = ref.watch(settingsProvider).settings?.baseCurrency?.precision ?? 0;
    final controller = useTextEditingController(
      text: currentBudget > 0 ? currentBudget.toMajorExpression(precision: precision) : '',
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
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FButton(
              onPress: () {
                final amount = controller.text.toMinorUnits(precision: precision);
                if (amount > 0) {
                  ref.read(dailyBudgetProvider.notifier).setBudget(amount.toDouble());
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
