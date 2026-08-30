import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/features/accounts/domain/account_aggregate.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('AccountAggregate', () {
    final now = DateTimeUtils.nowUtc();

    test('totalBalance sums account balance and all pocket balances', () {
      final mainAccount = AccountModel(
        id: 'a1',
        name: 'Account 1',
        type: AccountType.assets,
        balance: 5000,
        createdAt: now,
        updatedAt: now,
      );

      final pocket1 = AccountModel(
        id: 'p1',
        name: 'Pocket 1',
        type: AccountType.assets,
        balance: 1500,
        parentId: 'a1',
        createdAt: now,
        updatedAt: now,
      );

      final pocket2 = AccountModel(
        id: 'p2',
        name: 'Pocket 2',
        type: AccountType.assets,
        balance: 2000,
        parentId: 'a1',
        createdAt: now,
        updatedAt: now,
      );

      final aggregate = AccountAggregate(
        account: mainAccount,
        pockets: [pocket1, pocket2],
      );

      expect(aggregate.totalBalance, 8500); // 5000 + 1500 + 2000
    });

    test('totalBalance equals account balance when there are no pockets', () {
      final mainAccount = AccountModel(
        id: 'a1',
        name: 'Account 1',
        type: AccountType.assets,
        balance: 5000,
        createdAt: now,
        updatedAt: now,
      );

      final aggregate = AccountAggregate(
        account: mainAccount,
        pockets: [],
      );

      expect(aggregate.totalBalance, 5000);
    });
  });
}
