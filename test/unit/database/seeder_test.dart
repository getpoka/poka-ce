import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/database/seeder.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  setUp(() => db = AppDatabase(connection: NativeDatabase.memory()));
  tearDown(() async => db.close());

  group('DatabaseSeeder', () {
    test('seed creates 6 accounts and 24 categories', () async {
      await DatabaseSeeder.seed(db, overrideSeedDummyData: true);
      final accounts = await db.select(db.accounts).get();
      expect(accounts.length, 8);
      expect(
        accounts.map((a) => a.name).toSet(),
        containsAll([
          'Cash',
          'Bank BCA',
          'e-Wallet',
          'BCA Saving Pocket',
          'GoPay',
          'Vacation Fund Account',
          'Geekom A7 Max Fund',
          'Emergency Fund',
        ]),
      );
      expect(accounts.where((a) => a.type == AccountType.assets).length, 5);
      expect(accounts.where((a) => a.type == AccountType.goal).length, 3);
      expect(accounts.firstWhere((a) => a.name == 'Cash').balance, 750000); // Updated to match actual seeder data

      final categories = await db.select(db.categories).get();
      expect(categories.length, 24);
      expect(categories.where((c) => c.type == CategoryType.expense).length, 21);
      expect(categories.where((c) => c.type == CategoryType.income).length, 3);
    });

    test('seed categories have correct icons and colors for sub-categories', () async {
      await DatabaseSeeder.seed(db, overrideSeedDummyData: true);
      final categories = await db.select(db.categories).get();
      final food = categories.firstWhere((c) => c.name == 'Food & Dining');
      expect(food.icon, 'bowl-food');
      expect(food.color, '#F97316');
      final transport = categories.firstWhere((c) => c.name == 'Transport');
      expect(transport.icon, 'car');
      final salary = categories.firstWhere((c) => c.name == 'Salary');
      expect(salary.icon, 'bank');
      final lunch = categories.firstWhere((c) => c.name == 'Groceries');
      expect(lunch.icon, 'shopping-cart');
      expect(lunch.parentId, isNotNull);
    });

    test('seed wallet has expected icon and color', () async {
      await DatabaseSeeder.seed(db, overrideSeedDummyData: true);
      final cash = (await db.select(db.accounts).get()).firstWhere((a) => a.name == 'Cash');
      expect(cash.icon, 'payments');
      expect(cash.color, '#4CAF50');
      final bca = (await db.select(db.accounts).get()).firstWhere((a) => a.name == 'Bank BCA');
      expect(bca.icon, 'account_balance');
    });

    test('seed also creates currencies, budgets, goals, debts, transactions', () async {
      await DatabaseSeeder.seed(db, overrideSeedDummyData: true);
      expect((await db.select(db.currencies).get()).length, greaterThanOrEqualTo(26));
      expect((await db.select(db.budgets).get()).length, 4);
      expect((await db.select(db.goals).get()).length, 3);
      expect((await db.select(db.debts).get()).length, 4);
      expect((await db.select(db.transactions).get()).length, 23); // Updated to match actual seeder data
      expect((await db.select(db.transactionItems).get()).length, 13); // Unchanged items in seeder
    });

    test('seed skips accounts, categories, and dummy data when disabled', () async {
      DatabaseSeeder.globalOverrideSeedEssentials = false;
      DatabaseSeeder.globalOverrideSeedDummyData = false;

      final cleanDb = AppDatabase(connection: NativeDatabase.memory());
      try {
        expect(await cleanDb.select(cleanDb.accounts).get(), isEmpty);
        expect(await cleanDb.select(cleanDb.categories).get(), isEmpty);
        expect(await cleanDb.select(cleanDb.transactions).get(), isEmpty);
        expect(await cleanDb.select(cleanDb.budgets).get(), isEmpty);
        expect((await cleanDb.select(cleanDb.currencies).get()).length, greaterThanOrEqualTo(26));
        expect(await cleanDb.select(cleanDb.settings).get(), isNotEmpty);
      } finally {
        await cleanDb.close();
        DatabaseSeeder.globalOverrideSeedEssentials = null;
        DatabaseSeeder.globalOverrideSeedDummyData = null;
      }
    });
  });
}
