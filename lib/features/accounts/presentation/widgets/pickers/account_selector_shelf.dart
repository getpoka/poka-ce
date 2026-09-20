import 'package:flutter/material.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_pill.dart';
import 'package:poka_ce/theme/theme.dart';

class AccountSelectorShelf extends StatelessWidget {
  const new({required this.accounts, required this.selectedAccountId, required this.onAccountSelected, super.key});

  final List<AccountModel> accounts;
  final String? selectedAccountId;
  final ValueChanged<AccountModel> onAccountSelected;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    if (accounts.isEmpty) {
      return SizedBox(
        height: 38,
        child: Center(child: Text(t.accounts.noAccountsFound1, style: theme.typography.bodyPrimary)),
      );
    }

    final parents = accounts.where((a) => !a.isPocket && a.type != AccountType.goal).toList();
    final selectedAcc = accounts.where((a) => a.id == selectedAccountId).firstOrNull;
    final activeParentId = selectedAcc?.isPocket == true ? selectedAcc!.parentId : selectedAcc?.id;
    final pockets = activeParentId != null
        ? accounts.where((a) => a.parentId == activeParentId).toList()
        : <AccountModel>[];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PokaPillScrollRow(
          children: parents.map((acc) {
            final isSel = activeParentId == acc.id;
            final accColor = Color(int.parse(acc.color?.replaceFirst('#', '0xFF') ?? '0xFF94A3B8'));
            return PokaPill(
              icon: IconUtil.getIcon(acc.icon),
              label: acc.name,
              color: accColor,
              isSelected: isSel,
              onTap: () {
                final parentPockets = accounts.where((a) => a.parentId == acc.id).toList();
                if (parentPockets.isNotEmpty) {
                  final defaultPocket = parentPockets.firstWhere((p) => p.isDefault, orElse: () => parentPockets.first);
                  onAccountSelected(defaultPocket);
                } else {
                  onAccountSelected(acc);
                }
              },
            );
          }).toList(),
        ),
        if (pockets.length > 1 || pockets.any((p) => !p.isDefault)) ...[
          const SizedBox(height: 6),
          PokaPillScrollRow(
            children: pockets.map((pocket) {
              final isSel = selectedAccountId == pocket.id;
              final pocketColor = Color(int.parse(pocket.color?.replaceFirst('#', '0xFF') ?? '0xFF94A3B8'));
              return PokaPill(
                icon: IconUtil.getIcon(pocket.icon),
                label: pocket.name,
                color: pocketColor,
                isSelected: isSel,
                isChild: true,
                onTap: () => onAccountSelected(pocket),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
