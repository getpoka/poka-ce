import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';
import 'package:poka_ce/features/debts/domain/i_debt_repository.dart';
import 'package:poka_ce/features/debts/presentation/controllers/debt_form_notifier.dart';

class MockDebtRepository extends Mock implements IDebtRepository {}

class FakeDebtModel extends Fake implements DebtModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockDebtRepository mockRepo;
  setUpAll(() => registerFallbackValue(FakeDebtModel()));
  setUp(() {
    mockRepo = MockDebtRepository();
    when(() => mockRepo.getDebts()).thenAnswer((_) async => const Success([]));
    when(() => mockRepo.createDebt(any(), any(), any())).thenAnswer((_) async => const Success(null));
    when(() => mockRepo.updateDebt(any())).thenAnswer((_) async => const Success(null));
  });

  ProviderContainer createContainer() {
    final c = ProviderContainer(overrides: [debtRepositoryProvider.overrideWithValue(mockRepo)]);
    c.listen(debtFormProvider, (_, __) {});
    addTearDown(c.dispose);
    return c;
  }

  DebtModel sample() => DebtModel(
    id: 'd1',
    personName: 'Alice',
    type: DebtType.debt,
    amount: 1000,
    remainingAmount: 1000,
    status: DebtStatus.active,
    createdAt: DateTime.utc(2024, 1, 1),
    updatedAt: DateTime.utc(2024, 1, 1),
  );

  group('DebtFormNotifier', () {
    test('init null', () {
      final container = createContainer();
      final n = container.read(debtFormProvider.notifier);
      n.setPersonName('tmp');
      n.init(null);
      expect(container.read(debtFormProvider).personName, '');
    });

    test('init with model', () {
      final container = createContainer();
      final n = container.read(debtFormProvider.notifier);
      n.init(sample());
      expect(container.read(debtFormProvider).personName, 'Alice');
    });

    test('setters', () {
      final container = createContainer();
      final n = container.read(debtFormProvider.notifier);
      n.setPersonName('Bob');
      n.setType(DebtType.loan);
      n.setAmount(500);
      n.setStatus(DebtStatus.paid);
      n.setDueDate(DateTime.utc(2025, 1, 1));
      n.setNote('note');
      final s = container.read(debtFormProvider);
      expect(s.personName, 'Bob');
      expect(s.type, DebtType.loan);
      expect(s.amount, 500);
      expect(s.status, DebtStatus.paid);
      expect(s.dueDate, DateTime.utc(2025, 1, 1));
      expect(s.note, 'note');
    });

    test('validation empty personName', () async {
      final container = createContainer();
      final n = container.read(debtFormProvider.notifier);
      n.setPersonName('   ');
      n.setAmount(100);
      await n.save();
      expect(container.read(debtFormProvider).error, 'Person name cannot be empty');
    });

    test('validation amount <=0', () async {
      final container = createContainer();
      final n = container.read(debtFormProvider.notifier);
      n.setPersonName('Alice');
      n.setAmount(0);
      await n.save();
      expect(container.read(debtFormProvider).error, 'Amount must be greater than 0');
    });

    test('save create success', () async {
      when(() => mockRepo.createDebt(any(), any(), any())).thenAnswer((_) async => const Success(null));
      final container = createContainer();
      final n = container.read(debtFormProvider.notifier);
      n.setPersonName('New');
      n.setAmount(1000);
      n.setAccountId('a1');
      n.setCategoryId('c1');
      await n.save();
      await Future.delayed(const Duration(milliseconds: 50));
      expect(container.read(debtFormProvider).isSuccess, true);
      verify(() => mockRepo.createDebt(any(), any(), any())).called(1);
    });

    test('save create failure', () async {
      when(() => mockRepo.createDebt(any(), any(), any()))
          .thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      final container = createContainer();
      final n = container.read(debtFormProvider.notifier);
      n.setPersonName('New');
      n.setAmount(1000);
      n.setAccountId('a1');
      n.setCategoryId('c1');
      await n.save();
      expect(container.read(debtFormProvider).error, 'fail');
    });

    test('save update success', () async {
      when(() => mockRepo.updateDebt(any())).thenAnswer((_) async => const Success(null));
      final container = createContainer();
      final n = container.read(debtFormProvider.notifier);
      n.init(sample());
      n.setPersonName('Updated');
      await n.save();
      await Future.delayed(const Duration(milliseconds: 50));
      expect(container.read(debtFormProvider).isSuccess, true);
      verify(() => mockRepo.updateDebt(any())).called(1);
    });

    test('save update failure', () async {
      when(() => mockRepo.updateDebt(any())).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      final container = createContainer();
      final n = container.read(debtFormProvider.notifier);
      n.init(sample());
      n.setPersonName('Updated');
      await n.save();
      expect(container.read(debtFormProvider).error, 'fail');
    });

    test('copyWith', () {
      const s = DebtFormState(personName: 'a', amount: 1);
      final c = s.copyWith(personName: 'b');
      expect(c.personName, 'b');
    });
  });
}
