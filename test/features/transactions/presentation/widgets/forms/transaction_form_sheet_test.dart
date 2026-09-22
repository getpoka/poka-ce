import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/forms/transaction_account_resolver.dart';

/// Unit tests for [resolveToTransactableAccount].
///
/// Verifies that the resolver correctly redirects root accounts to their
/// Main Pocket and leaves pockets unchanged.
void main() {
  final now = DateTime(2024);

  AccountModel _root({String id = 'root-1', String name = 'Wallet'}) => AccountModel(
        id: id,
        name: name,
        type: AccountType.assets,
        balance: 0,
        createdAt: now,
        updatedAt: now,
      );

  AccountModel _pocket({
    required String id,
    required String parentId,
    bool isDefault = false,
  }) =>
      AccountModel(
        id: id,
        name: isDefault ? 'Main' : 'Pocket',
        type: AccountType.assets,
        balance: 0,
        parentId: parentId,
        isDefault: isDefault,
        createdAt: now,
        updatedAt: now,
      );

  group('resolveToTransactableAccount', () {
    test('returns pocket unchanged when candidate is already a pocket', () {
      final root = _root();
      final main = _pocket(id: 'main-1', parentId: root.id, isDefault: true);
      final accounts = [root, main];

      final result = resolveToTransactableAccount(main, accounts);

      expect(result.id, equals(main.id));
    });

    test('redirects root account to its Main Pocket', () {
      final root = _root();
      final main = _pocket(id: 'main-1', parentId: root.id, isDefault: true);
      final other = _pocket(id: 'pocket-2', parentId: root.id);
      final accounts = [root, main, other];

      final result = resolveToTransactableAccount(root, accounts);

      expect(result.id, equals(main.id));
    });

    test('falls back to first pocket when no default pocket exists', () {
      final root = _root();
      final pocket1 = _pocket(id: 'pocket-1', parentId: root.id);
      final pocket2 = _pocket(id: 'pocket-2', parentId: root.id);
      final accounts = [root, pocket1, pocket2];

      final result = resolveToTransactableAccount(root, accounts);

      expect(result.id, equals(pocket1.id));
    });

    test('returns root itself when it has no pockets', () {
      final root = _root();
      final accounts = [root];

      final result = resolveToTransactableAccount(root, accounts);

      expect(result.id, equals(root.id));
    });

    test('ignores pockets of other root accounts when resolving', () {
      final root1 = _root(id: 'root-1');
      final root2 = _root(id: 'root-2', name: 'Savings');
      // root2 has a default pocket; root1 has none.
      final main2 = _pocket(id: 'main-2', parentId: root2.id, isDefault: true);
      final accounts = [root1, root2, main2];

      final result = resolveToTransactableAccount(root1, accounts);

      // Should return root1 itself — not main2 which belongs to root2.
      expect(result.id, equals(root1.id));
    });
  });
}
