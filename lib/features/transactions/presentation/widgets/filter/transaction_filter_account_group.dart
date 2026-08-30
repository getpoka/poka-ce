import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_pill.dart';

/// A group of selectable pills for filtering by account.
class TransactionFilterAccountGroup extends HookWidget {
  const TransactionFilterAccountGroup({
    required this.accounts,
    required this.selectedIds,
    required this.onChanged,
    super.key,
  });

  final List<AccountModel> accounts;
  final Set<String> selectedIds;
  final ValueChanged<Set<String>> onChanged;

  @override
  Widget build(BuildContext context) {
    final activeParentId = useState<String?>(null);

    final topAccounts = accounts.where((a) => !a.isPocket).toList();
    final accountChildren = activeParentId.value != null
        ? accounts.where((a) => a.parentId == activeParentId.value).toList()
        : <AccountModel>[];

    if (topAccounts.isEmpty) return const SizedBox.shrink();

    return FLabel(
      layout: FLabelLayout.vertical,
      label: Text(t.transactions.account),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Parent pills
          PokaPillScrollRow(
            children: topAccounts.map((account) {
              final isSelected = selectedIds.contains(account.id);
              final isExpanded = activeParentId.value == account.id;
              final color = Color(
                int.parse(
                  account.color?.replaceFirst('#', '0xFF') ?? '0xFF94A3B8',
                ),
              );
              return PokaPill(
                icon: IconUtil.getIcon(account.icon),
                label: account.name,
                color: color,
                isSelected: isSelected || isExpanded,
                onTap: () {
                  if (isExpanded) {
                    activeParentId.value = null;
                    final next = Set<String>.from(selectedIds)..remove(account.id);
                    accounts.where((a) => a.parentId == account.id).forEach((a) => next.remove(a.id));
                    onChanged(next);
                  } else {
                    final oldParent = activeParentId.value;
                    final next = Set<String>.from(selectedIds);
                    if (oldParent != null) {
                      next.remove(oldParent);
                      accounts.where((a) => a.parentId == oldParent).forEach((a) => next.remove(a.id));
                    }
                    next.add(account.id);
                    activeParentId.value = account.id;
                    onChanged(next);
                  }
                },
              );
            }).toList(),
          ),

          // Child pills (pockets)
          if (accountChildren.isNotEmpty) ...[
            const SizedBox(height: 6),
            PokaPillScrollRow(
              children: accountChildren.map((pocket) {
                final isSelected = selectedIds.contains(pocket.id);
                final color = Color(
                  int.parse(
                    pocket.color?.replaceFirst('#', '0xFF') ?? '0xFF94A3B8',
                  ),
                );
                return PokaPill(
                  icon: IconUtil.getIcon(pocket.icon),
                  label: pocket.name,
                  color: color,
                  isSelected: isSelected,
                  isChild: true,
                  onTap: () {
                    final next = Set<String>.from(selectedIds);
                    isSelected ? next.remove(pocket.id) : next.add(pocket.id);
                    onChanged(next);
                  },
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
