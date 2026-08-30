import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/debts/presentation/controllers/debt_list_notifier.dart';
import 'package:poka_ce/features/debts/presentation/widgets/lists/debt_list_content.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';

class DebtListPage extends ConsumerWidget {
  const DebtListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debtsAsync = ref.watch(debtListProvider);

    return FScaffold(
      header: PokaHeader(
        title: t.debts.debtsLoans,
        showBack: true,
      ),
      child: debtsAsync.when(
        data: (allDebts) {
          final iOweList = allDebts.where((d) => d.type == DebtType.debt).toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
          final theyOweList = allDebts.where((d) => d.type == DebtType.loan).toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: FTabs(
                children: [
                  FTabEntry(
                    label: Text(t.debts.iOwe),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: DebtListContent(
                        debts: iOweList,
                        isPayable: true,
                      ).animate().fade(duration: 300.ms).slideY(begin: 0.05, end: 0),
                    ),
                  ),
                  FTabEntry(
                    label: Text(t.debts.theyOwe),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: DebtListContent(
                        debts: theyOweList,
                        isPayable: false,
                      ).animate().fade(duration: 300.ms).slideY(begin: 0.05, end: 0),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: FCircularProgress()),
        error: (error, _) => Center(
          child: Text(
            t.debts.failedToLoadDebts(error: error.toString()),
            style: context.theme.typography.body.md.copyWith(
              color: context.theme.colors.destructive,
            ),
          ),
        ),
      ),
    );
  }
}
