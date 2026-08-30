import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  setUp(() => db = AppDatabase(connection: NativeDatabase.memory()));
  tearDown(() async => db.close());

  group('DebtsDao', () {
    test('getAllDebts empty initially', () async {
      expect(await db.debtsDao.getAllDebts(), isEmpty);
    });

    test('insert and getDebt', () async {
      await db.debtsDao.insertDebt(
        DebtsCompanion.insert(
          id: const Value('d1'),
          personName: 'Alice',
          type: DebtType.debt,
          amount: 100000,
          remainingAmount: 100000,
          status: DebtStatus.active,
        ),
      );
      final d = await db.debtsDao.getDebt('d1');
      expect(d, isNotNull);
      expect(d!.personName, 'Alice');
      expect(d.type, DebtType.debt);
      expect(d.status, DebtStatus.active);
    });

    test('getDebt returns null for unknown', () async {
      expect(await db.debtsDao.getDebt('none'), isNull);
    });

    test('getActiveDebts filters paid', () async {
      await db.debtsDao.insertDebt(
        DebtsCompanion.insert(
          id: const Value('d1'),
          personName: 'A',
          type: DebtType.debt,
          amount: 100,
          remainingAmount: 100,
          status: DebtStatus.active,
        ),
      );
      await db.debtsDao.insertDebt(
        DebtsCompanion.insert(
          id: const Value('d2'),
          personName: 'B',
          type: DebtType.loan,
          amount: 200,
          remainingAmount: 0,
          status: DebtStatus.paid,
        ),
      );
      final active = await db.debtsDao.getActiveDebts();
      expect(active.length, 1);
      expect(active.first.id, 'd1');
    });

    test('updateDebt modifies fields', () async {
      await db.debtsDao.insertDebt(
        DebtsCompanion.insert(
          id: const Value('d1'),
          personName: 'Old',
          type: DebtType.debt,
          amount: 100,
          remainingAmount: 100,
          status: DebtStatus.active,
        ),
      );
      await (db.update(db.debts)..where((t) => t.id.equals('d1'))).write(
        const DebtsCompanion(personName: Value('New'), remainingAmount: Value(50)),
      );
      final d = await db.debtsDao.getDebt('d1');
      expect(d!.personName, 'New');
      expect(d.remainingAmount, 50);
    });

    test('deleteDebt removes', () async {
      await db.debtsDao.insertDebt(
        DebtsCompanion.insert(
          id: const Value('d1'),
          personName: 'X',
          type: DebtType.loan,
          amount: 500,
          remainingAmount: 500,
          status: DebtStatus.active,
        ),
      );
      await db.debtsDao.deleteDebt('d1');
      expect(await db.debtsDao.getDebt('d1'), isNull);
    });

    test('getAllDebts returns all statuses', () async {
      await db.debtsDao.insertDebt(
        DebtsCompanion.insert(
          id: const Value('d1'),
          personName: 'A',
          type: DebtType.debt,
          amount: 100,
          remainingAmount: 100,
          status: DebtStatus.active,
        ),
      );
      await db.debtsDao.insertDebt(
        DebtsCompanion.insert(
          id: const Value('d2'),
          personName: 'B',
          type: DebtType.debt,
          amount: 200,
          remainingAmount: 0,
          status: DebtStatus.paid,
        ),
      );
      expect((await db.debtsDao.getAllDebts()).length, 2);
    });

    test('loan vs debt type stored lowercase', () async {
      await db.debtsDao.insertDebt(
        DebtsCompanion.insert(
          id: const Value('d1'),
          personName: 'Lender',
          type: DebtType.loan,
          amount: 1000,
          remainingAmount: 1000,
          status: DebtStatus.active,
        ),
      );
      final raw = await db
          .customSelect('SELECT type FROM debts WHERE id = ?', variables: [Variable.withString('d1')])
          .getSingle();
      expect(raw.data['type'], 'loan');
      final rawStatus = await db
          .customSelect('SELECT status FROM debts WHERE id = ?', variables: [Variable.withString('d1')])
          .getSingle();
      expect(rawStatus.data['status'], 'active');
    });

    test('with dueDate and note', () async {
      final due = DateTime.utc(2026, 12, 31);
      await db.debtsDao.insertDebt(
        DebtsCompanion.insert(
          id: const Value('d1'),
          personName: 'Bob',
          type: DebtType.debt,
          amount: 500000,
          remainingAmount: 300000,
          status: DebtStatus.active,
          dueDate: Value(due),
          note: const Value('urgent'),
        ),
      );
      final d = await db.debtsDao.getDebt('d1');
      expect(d!.dueDate!.toUtc(), due.toUtc());
      expect(d.note, 'urgent');
    });
  });
}
