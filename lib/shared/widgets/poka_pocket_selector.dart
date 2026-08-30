import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';
import 'package:poka_ce/theme/theme.dart';

/// PokaPocketSelector is a custom sheet for selecting a wallet or pocket.
/// It uses a split-tap UX where tapping the chevron expands the pockets,
/// while tapping the row selects the item and closes the sheet.
class PokaPocketSelector extends HookWidget {
  /// Creates a PokaPocketSelector.
  const PokaPocketSelector({
    required this.accounts,
    this.selectedId,
    super.key,
  });

  /// The list of accounts to choose from.
  final List<AccountModel> accounts;
  final String? selectedId;

  /// Utility to show this selector as a sheet.
  static Future<AccountModel?> show(
    BuildContext context, {
    required List<AccountModel> accounts,
    String title = 'Select Wallet',
    String? selectedId,
  }) {
    return showPokaSheet<AccountModel>(
      context: context,
      builder: (context) => PokaSheet(
        title: title,
        child: PokaPocketSelector(accounts: accounts, selectedId: selectedId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (accounts.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Text(
            t.shared.noWalletsFoundPleaseCreateOneFirst,
            style: context.theme.typography.body.lg,
          ),
        ),
      );
    }

    // Group accounts into parents and children (pockets)
    final parents = accounts.where((a) => !a.isPocket).toList();
    final childrenMap = <String, List<AccountModel>>{};
    for (final a in accounts) {
      if (a.isPocket && a.parentId != null) {
        childrenMap.putIfAbsent(a.parentId!, () => []).add(a);
      }
    }

    final expandedStates = useState<Set<String>>({});

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.6,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: parents.length,
        itemBuilder: (context, index) {
          final parent = parents[index];
          final children = childrenMap[parent.id] ?? [];
          final isExpanded = expandedStates.value.contains(parent.id);

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Parent Row
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: context.theme.colors.border),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => Navigator.of(context).pop(parent),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Row(
                            children: [
                              PokaIcon(
                                icon: IconUtil.getIcon(parent.icon),
                                color: parent.color?.toColor() ?? context.theme.colors.primary,
                                size: PokaIconSize.small,
                                useThemeBorderColor: true,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      parent.name,
                                      style: context.theme.typography.titleItem,
                                    ),
                                    Text(
                                      parent.type.name.toUpperCase(),
                                      style: context.theme.typography.caption.copyWith(
                                        color: context.theme.colors.mutedForeground,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          t.shared.balance,
                                          style: context.theme.typography.caption.copyWith(
                                            color: context.theme.colors.mutedForeground,
                                          ),
                                        ),
                                        Flexible(
                                          child: PokaAmountText(
                                            amount: parent.balance,
                                            type: TransactionType.transfer,
                                            style: context.theme.typography.caption.copyWith(
                                              color: context.theme.colors.mutedForeground,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              if (parent.id == selectedId)
                                Icon(FPhosphorIcons.check, color: context.theme.colors.primary, size: 18),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (children.isNotEmpty)
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          final current = Set<String>.from(expandedStates.value);
                          if (isExpanded) {
                            current.remove(parent.id);
                          } else {
                            current.add(parent.id);
                          }
                          expandedStates.value = current;
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Icon(
                            isExpanded ? FPhosphorIcons.caretUp : FPhosphorIcons.caretDown,
                            color: context.theme.colors.mutedForeground,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Children Rows (Pockets)
              if (isExpanded)
                ...children.map((child) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Navigator.of(context).pop(child),
                    child: Container(
                      padding: const EdgeInsets.only(left: 48, right: 16, top: 12, bottom: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: context.theme.colors.border,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          PokaIcon(
                            icon: IconUtil.getIcon(child.icon),
                            color: child.color?.toColor() ?? context.theme.colors.primary,
                            size: PokaIconSize.small,
                            useThemeBorderColor: true,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  child.name,
                                  style: context.theme.typography.titleItem,
                                ),
                                Text(
                                  child.type.name.toUpperCase(),
                                  style: context.theme.typography.caption.copyWith(
                                    color: context.theme.colors.mutedForeground,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      t.shared.balance,
                                      style: context.theme.typography.caption.copyWith(
                                        color: context.theme.colors.mutedForeground,
                                      ),
                                    ),
                                    Flexible(
                                      child: PokaAmountText(
                                        amount: child.balance,
                                        type: TransactionType.transfer,
                                        style: context.theme.typography.caption.copyWith(
                                          color: context.theme.colors.mutedForeground,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (child.id == selectedId)
                            Icon(FPhosphorIcons.check, color: context.theme.colors.primary, size: 18),
                        ],
                      ),
                    ),
                  );
                }),
            ],
          );
        },
      ),
    );
  }
}
