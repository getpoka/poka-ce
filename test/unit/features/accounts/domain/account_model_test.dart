import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('AccountModel', () {
    final now = DateTimeUtils.nowUtc();

    test('isPocket is true when parentId is not null', () {
      final pocket = AccountModel(
        id: 'p1',
        name: 'Pocket 1',
        type: AccountType.assets,
        balance: 100,
        parentId: 'a1',
        createdAt: now,
        updatedAt: now,
      );
      expect(pocket.isPocket, isTrue);
    });

    test('isPocket is false when parentId is null', () {
      final account = AccountModel(
        id: 'a1',
        name: 'Account 1',
        type: AccountType.assets,
        balance: 100,
        createdAt: now,
        updatedAt: now,
      );
      expect(account.isPocket, isFalse);
    });

    group('effectiveRestrictedCategoryIds', () {
      final parentAccount = AccountModel(
        id: 'a1',
        name: 'Account 1',
        type: AccountType.assets,
        balance: 100,
        restrictedCategoryIds: ['c1', 'c2'],
        createdAt: now,
        updatedAt: now,
      );

      test('returns own restrictedCategoryIds if not a pocket', () {
        final account = AccountModel(
          id: 'a2',
          name: 'Account 2',
          type: AccountType.assets,
          balance: 100,
          restrictedCategoryIds: ['c3'],
          createdAt: now,
          updatedAt: now,
        );

        final effective = account.effectiveRestrictedCategoryIds(parentAccount);
        expect(effective, ['c3']);
      });

      test('returns inherited categories from parent if own is empty and is a pocket', () {
        final pocket = AccountModel(
          id: 'p1',
          name: 'Pocket 1',
          type: AccountType.assets,
          balance: 100,
          parentId: 'a1',
          restrictedCategoryIds: [],
          createdAt: now,
          updatedAt: now,
        );

        final effective = pocket.effectiveRestrictedCategoryIds(parentAccount);
        expect(effective, ['c1', 'c2']);
      });

      test('returns own categories if own is not empty and is a pocket', () {
        final pocket = AccountModel(
          id: 'p1',
          name: 'Pocket 1',
          type: AccountType.assets,
          balance: 100,
          parentId: 'a1',
          restrictedCategoryIds: ['c4'],
          createdAt: now,
          updatedAt: now,
        );

        final effective = pocket.effectiveRestrictedCategoryIds(parentAccount);
        expect(effective, ['c4']);
      });

      test('returns empty if both own and parent are empty and is a pocket', () {
        final emptyParent = AccountModel(
          id: 'a1',
          name: 'Account 1',
          type: AccountType.assets,
          balance: 100,
          restrictedCategoryIds: [],
          createdAt: now,
          updatedAt: now,
        );
        final pocket = AccountModel(
          id: 'p1',
          name: 'Pocket 1',
          type: AccountType.assets,
          balance: 100,
          parentId: 'a1',
          restrictedCategoryIds: [],
          createdAt: now,
          updatedAt: now,
        );

        final effective = pocket.effectiveRestrictedCategoryIds(emptyParent);
        expect(effective, isEmpty);
      });
    });
  });
}
