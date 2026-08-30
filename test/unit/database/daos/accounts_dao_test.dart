import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(connection: NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('AccountsDao', () {
    test('getAllAccounts returns seeded account initially', () async {
      final accounts = await db.accountsDao.getAllAccounts();
      // Should contain the default seeded cash account if seedEssentials is true
      expect(accounts.length, greaterThanOrEqualTo(1));
    });

    test('insertAccount and getAllAccounts', () async {
      await db.accountsDao.insertAccount(
        AccountsCompanion.insert(
          id: const Value('a1'),
          name: 'Wallet',
          type: AccountType.assets,
          balance: const Value(1000),
        ),
      );
      final all = await db.accountsDao.getAllAccounts();
      expect(all.length, greaterThanOrEqualTo(2)); // Cash + a1
      final a1 = all.firstWhere((a) => a.id == 'a1');
      expect(a1.balance, 1000);
      expect(a1.isActive, true);
    });

    test('getActiveAccounts filters inactive', () async {
      await db.accountsDao.insertAccount(
        AccountsCompanion.insert(
          id: const Value('a1'),
          name: 'Active',
          type: AccountType.assets,
        ),
      );
      await db.accountsDao.insertAccount(
        AccountsCompanion.insert(
          id: const Value('a2'),
          name: 'Inactive',
          type: AccountType.assets,
        ),
      );
      await db.accountsDao.deactivateAccount('a2');
      final active = await db.accountsDao.getActiveAccounts();
      expect(active.length, greaterThanOrEqualTo(2)); // Cash + a1
      expect(active.any((a) => a.id == 'a1'), isTrue);
    });

    test('getAccount returns correct or null', () async {
      await db.accountsDao.insertAccount(
        AccountsCompanion.insert(
          id: const Value('a1'),
          name: 'Wallet',
          type: AccountType.assets,
        ),
      );
      final found = await db.accountsDao.getAccount('a1');
      expect(found, isNotNull);
      expect(found!.name, 'Wallet');
      final notFound = await db.accountsDao.getAccount('nonexistent');
      expect(notFound, isNull);
    });

    test('updateAccount modifies fields', () async {
      await db.accountsDao.insertAccount(
        AccountsCompanion.insert(
          id: const Value('a1'),
          name: 'Old',
          type: AccountType.assets,
          balance: const Value(0),
        ),
      );
      final updated = await db.accountsDao.updateAccount(
        const AccountsCompanion(
          id: Value('a1'),
          name: Value('New'),
          balance: Value(500),
        ),
      );
      expect(updated, true);
      final acc = await db.accountsDao.getAccount('a1');
      expect(acc!.name, 'New');
      expect(acc.balance, 500);
    });

    test('deactivateAccount sets isActive false', () async {
      await db.accountsDao.insertAccount(
        AccountsCompanion.insert(
          id: const Value('a1'),
          name: 'Wallet',
          type: AccountType.assets,
        ),
      );
      await db.accountsDao.deactivateAccount('a1');
      final acc = await db.accountsDao.getAccount('a1');
      expect(acc!.isActive, false);
    });

    test('setAccountCategories replaces existing', () async {
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(
              id: const Value('acc1'),
              name: 'Wallet',
              type: AccountType.assets,
            ),
          );
      await db
          .into(db.categories)
          .insert(
            CategoriesCompanion.insert(
              id: const Value('cat1'),
              name: 'Food',
              type: CategoryType.expense,
            ),
          );
      await db
          .into(db.categories)
          .insert(
            CategoriesCompanion.insert(
              id: const Value('cat2'),
              name: 'Transport',
              type: CategoryType.expense,
            ),
          );
      await db
          .into(db.categories)
          .insert(
            CategoriesCompanion.insert(
              id: const Value('cat3'),
              name: 'Salary',
              type: CategoryType.income,
            ),
          );

      await db.accountsDao.setAccountCategories('acc1', ['cat1', 'cat2']);
      var rows = await db.select(db.accountCategories).get();
      expect(rows.length, 2);
      expect(rows.map((e) => e.categoryId).toSet(), {'cat1', 'cat2'});

      // Replace with single
      await db.accountsDao.setAccountCategories('acc1', ['cat3']);
      rows = await db.select(db.accountCategories).get();
      expect(rows.length, 1);
      expect(rows.first.categoryId, 'cat3');
    });

    test('setAccountCategories with empty clears all', () async {
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(
              id: const Value('acc1'),
              name: 'Wallet',
              type: AccountType.assets,
            ),
          );
      await db
          .into(db.categories)
          .insert(
            CategoriesCompanion.insert(
              id: const Value('cat1'),
              name: 'Food',
              type: CategoryType.expense,
            ),
          );
      await db.accountsDao.setAccountCategories('acc1', ['cat1']);
      expect((await db.select(db.accountCategories).get()).length, 1);
      await db.accountsDao.setAccountCategories('acc1', []);
      expect((await db.select(db.accountCategories).get()).length, 0);
    });

    test('balance default is 0 when not provided', () async {
      await db.accountsDao.insertAccount(
        AccountsCompanion.insert(
          id: const Value('a1'),
          name: 'Wallet',
          type: AccountType.assets,
        ),
      );
      final acc = await db.accountsDao.getAccount('a1');
      expect(acc!.balance, 0);
    });

    test('parent pocket cascade delete via FK', () async {
      await db.accountsDao.insertAccount(
        AccountsCompanion.insert(
          id: const Value('parent'),
          name: 'Parent',
          type: AccountType.assets,
        ),
      );
      await db.accountsDao.insertAccount(
        AccountsCompanion.insert(
          id: const Value('child'),
          name: 'Child',
          type: AccountType.assets,
          parentId: const Value('parent'),
        ),
      );
      await (db.delete(db.accounts)..where((t) => t.id.equals('parent'))).go();
      final child = await db.accountsDao.getAccount('child');
      expect(child, isNull);
    });
  });
}
