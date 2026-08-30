import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUp(() => db = AppDatabase(connection: NativeDatabase.memory()));
  tearDown(() async => db.close());

  group('Accounts table', () {
    test('client defaults generate uuid, zero balance and active state', () async {
      final id = await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(name: 'Test Cash', type: AccountType.assets));

      final row = await (db.select(db.accounts)..where((t) => t.name.equals('Test Cash'))).getSingle();
      expect(row.id.length, 36);
      expect(row.balance, 0);
      expect(row.isActive, isTrue);
      expect(row.icon, isNull);
      expect(row.color, isNull);
      expect(row.parentId, isNull);
    });

    test('copyWith, equality, hashCode and toString', () async {
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('a1'), name: 'Cash', type: AccountType.assets));
      final row = await (db.select(db.accounts)..where((t) => t.id.equals('a1'))).getSingle();

      final changed = row.copyWith(name: 'Bank');
      expect(changed.name, 'Bank');
      expect(changed.id, row.id);
      expect(changed == row, isFalse);

      final same = row.copyWith();
      expect(same, row);
      expect(same.hashCode, row.hashCode);
      expect(row.toString(), contains('Account'));
    });

    test('json round trip preserves enum converter and fields', () async {
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(
              id: const Value('a2'),
              name: 'Bank',
              type: AccountType.liability,
              icon: const Value('wallet'),
              color: const Value('#FF0000'),
              balance: const Value(1500),
            ),
          );
      final row = await (db.select(db.accounts)..where((t) => t.id.equals('a2'))).getSingle();

      final restored = Account.fromJson(row.toJson());
      expect(restored, row);
      expect(restored.type, AccountType.liability);
    });

    test('update mutates balance and delete removes the row', () async {
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('a3'), name: 'Wallet', type: AccountType.assets));

      await (db.update(
        db.accounts,
      )..where((a) => a.id.equals('a3'))).write(const AccountsCompanion(balance: Value(900)));
      var row = await (db.select(db.accounts)..where((t) => t.id.equals('a3'))).getSingle();
      expect(row.balance, 900);

      await (db.delete(db.accounts)..where((a) => a.id.equals('a3'))).go();
      expect(await (db.select(db.accounts)..where((t) => t.id.equals('a3'))).get(), isEmpty);
    });

    test('pocket references parent account', () async {
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('parent'), name: 'Main', type: AccountType.assets));
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(
              id: const Value('pocket'),
              name: 'Food',
              type: AccountType.goal,
              parentId: const Value('parent'),
            ),
          );

      final pocket = await (db.select(db.accounts)..where((a) => a.id.equals('pocket'))).getSingle();
      expect(pocket.parentId, 'parent');
    });
  });

  group('AccountCategories table', () {
    test('composite primary key stores restriction pairs', () async {
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('acc'), name: 'Main', type: AccountType.assets));
      await db
          .into(db.categories)
          .insert(CategoriesCompanion.insert(id: const Value('cat'), name: 'Food', type: CategoryType.expense));

      await db
          .into(db.accountCategories)
          .insert(
            AccountCategoriesCompanion.insert(accountId: 'acc', categoryId: 'cat'),
          );
      final row = await db.select(db.accountCategories).getSingle();

      expect(row.accountId, 'acc');
      expect(row.categoryId, 'cat');

      final restored = AccountCategory.fromJson(row.toJson());
      expect(restored, row);
      expect(row.copyWith(categoryId: 'other').categoryId, 'other');
      expect(row.hashCode, isNotNull);

      await (db.delete(db.accountCategories)..where((r) => r.accountId.equals('acc'))).go();
      expect(await db.select(db.accountCategories).get(), isEmpty);
    });
  });
}
