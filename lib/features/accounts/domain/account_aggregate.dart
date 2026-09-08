import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/i18n/strings.g.dart';

part 'account_aggregate.freezed.dart';

/// An aggregate root that encapsulates a main account and all of its pockets.
@freezed
abstract class AccountAggregate with _$AccountAggregate {
  const factory AccountAggregate({
    required AccountModel account,
    @Default([]) List<AccountModel> pockets,
  }) = _AccountAggregate;
  const AccountAggregate._();

  /// Total balance = main account balance + sum of all pockets balance.
  int get totalBalance {
    return account.balance + pockets.fold(0, (sum, pocket) => sum + pocket.balance);
  }

  /// Calculates the proportional ratio of this account's total balance relative to [totalAssets].
  ///
  /// Clamped between `0.0` and `1.0`. Returns `0.0` if [totalAssets] is zero or negative.
  double calculateRatio(double totalAssets) {
    if (totalAssets <= 0) return 0;
    return (totalBalance / totalAssets).clamp(0, 1);
  }

  /// Formats the asset proportion as a human-readable percentage label (e.g. "45% of assets").
  String formatRatioLabel(double totalAssets) {
    final ratio = calculateRatio(totalAssets);
    return t.accounts.percentOfAssets(percent: (ratio * 100).toStringAsFixed(0));
  }
}
