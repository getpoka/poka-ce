import 'package:flutter/material.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/theme/theme.dart';

class AccountTile extends StatelessWidget with FTileMixin {
  const AccountTile({
    required this.account,
    this.pocketCount = 0,
    super.key,
  });

  final AccountModel account;
  final int pocketCount;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    Color accountColor;
    try {
      accountColor = account.color?.toColor() ?? theme.colors.primary;
    } on Object catch (_) {
      accountColor = theme.colors.primary;
    }

    return FInheritedItemData.merge(
      index: 1, // Force FTile to not render first item borders
      last: false, // Force FTile to not render last item borders
      child: DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: theme.colors.border,
            ),
          ),
        ),
        child: FTile(
          prefix: PokaIcon(
            icon: IconUtil.getIcon(account.icon),
            color: accountColor,
          ),
          title: Text(
            account.name,
            style: theme.typography.body.lg.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: pocketCount > 0
              ? Text(
                  '$pocketCount pocket${pocketCount > 1 ? 's' : ''}',
                  style: theme.typography.bodyPrimary.copyWith(
                    color: theme.colors.mutedForeground,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
