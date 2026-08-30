import 'package:flutter/material.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';
import 'package:poka_ce/features/debts/presentation/widgets/cards/debt_card.dart';
import 'package:poka_ce/features/debts/presentation/widgets/cards/debt_summary_card.dart';
import 'package:poka_ce/features/debts/presentation/widgets/forms/debt_form_sheet.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_empty_view.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';
import 'package:poka_ce/theme/theme.dart';

class DebtListContent extends StatelessWidget {
  const DebtListContent({
    required this.debts,
    required this.isPayable,
    super.key,
  });

  final List<DebtModel> debts;
  final bool isPayable;

  @override
  Widget build(BuildContext context) {
    if (debts.isEmpty) {
      return Builder(
        builder: (context) => PokaEmptyView(
          icon: isPayable ? FPhosphorIcons.arrowUpRight : FPhosphorIcons.arrowDownLeft,
          title: isPayable ? t.debts.noDebtsRecorded : t.debts.noLoansRecorded,
          subtitle: isPayable
              ? t.debts.trackMoneyYouOweToOthersAndLogRepayments
              : t.debts.trackMoneyOthersOweYouAndLogCollections,
          actionLabel: t.debts.addRecord,
          actionKey: const Key('debt-add-button'),
          onAction: () => DebtFormSheet.show(context),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DebtSummaryCard(debts: debts, isPayable: isPayable),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PokaSectionLabel(
              title: isPayable ? 'Payable' : 'Receivable',
            ),
            Builder(
              builder: (context) => GestureDetector(
                key: const Key('debt-add-button'),
                onTap: () => DebtFormSheet.show(context),
                child: Row(
                  children: [
                    Icon(FPhosphorIcons.plus, size: 14, color: context.theme.colors.primary),
                    const SizedBox(width: 4),
                    Text(
                      t.debts.addRecord,
                      style: context.theme.typography.bodySecondary.copyWith(
                        color: context.theme.colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: debts.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (context, index) => DebtCard(debt: debts[index]),
          ),
        ),
      ],
    );
  }
}
