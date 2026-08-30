import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';

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
  int get totalBalance => account.balance + pockets.fold<int>(0, (sum, p) => sum + p.balance);
}
