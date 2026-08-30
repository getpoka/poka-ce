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

  group('RecurringTransactions table', () {
    test('insert with defaults, nullable refs and copyWith', () async {
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('acc'), name: 'Main', type: AccountType.assets));
      await db
          .into(db.recurringTransactions)
          .insert(
            RecurringTransactionsCompanion.insert(
              id: const Value('r1'),
              accountId: 'acc',
              destinationAccountId: const Value(null),
              categoryId: const Value(null),
              type: TransactionType.expense,
              amount: 250000,
              note: const Value(null),
              period: RecurringPeriod.monthly,
              nextDate: DateTime(2026, 9, 1),
            ),
          );
      final row = await db.select(db.recurringTransactions).getSingle();

      expect(row.destinationAccountId, isNull);
      expect(row.categoryId, isNull);
      expect(row.isActive, isTrue);
      expect(row.period, RecurringPeriod.monthly);
      expect(row.type, TransactionType.expense);

      final changed = row.copyWith(amount: 300000);
      expect(changed.amount, 300000);
      expect(changed == row, isFalse);
      expect(row.copyWith(), row);
      expect(row.hashCode, isNotNull);
      expect(row.toString(), contains('RecurringTransaction'));
    });

    test('json round trip preserves enums and optional relations', () async {
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('src'), name: 'Source', type: AccountType.assets));
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('dst'), name: 'Dest', type: AccountType.assets));
      await db
          .into(db.recurringTransactions)
          .insert(
            RecurringTransactionsCompanion.insert(
              id: const Value('r2'),
              accountId: 'src',
              destinationAccountId: const Value('dst'),
              type: TransactionType.transfer,
              amount: 1000000,
              note: const Value('tabungan'),
              period: RecurringPeriod.weekly,
              nextDate: DateTime(2026, 8, 30),
            ),
          );
      final row = await db.select(db.recurringTransactions).getSingle();

      final restored = RecurringTransaction.fromJson(row.toJson());
      expect(restored, row);
      expect(restored.type, TransactionType.transfer);
      expect(restored.period, RecurringPeriod.weekly);

      await (db.update(
        db.recurringTransactions,
      )..where((r) => r.id.equals('r2'))).write(const RecurringTransactionsCompanion(isActive: Value(false)));
      final updated = await db.select(db.recurringTransactions).getSingle();
      expect(updated.isActive, isFalse);
    });
  });
}
