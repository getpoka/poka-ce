import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/recurring/domain/i_recurring_repository.dart';
import 'package:poka_ce/features/recurring/domain/recurring_model.dart';
import 'package:poka_ce/features/recurring/presentation/controllers/recurring_form_notifier.dart';

class MockRecurringRepository extends Mock implements IRecurringRepository {}

class FakeRecurringModel extends Fake implements RecurringTransactionModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockRecurringRepository mockRepo;
  setUpAll(() => registerFallbackValue(FakeRecurringModel()));
  setUp(() {
    mockRepo = MockRecurringRepository();
    when(() => mockRepo.getRecurringTransactions()).thenAnswer((_) async => const Success([]));
    when(() => mockRepo.createRecurring(any())).thenAnswer((_) async => const Success(null));
    when(() => mockRepo.updateRecurring(any())).thenAnswer((_) async => const Success(null));
  });

  ProviderContainer createContainer() {
    final c = ProviderContainer(overrides: [recurringRepositoryProvider.overrideWithValue(mockRepo)]);
    addTearDown(c.dispose);
    return c;
  }

  RecurringTransactionModel sample() => RecurringTransactionModel(
    id: 'r1',
    accountId: 'a1',
    type: TransactionType.expense,
    amount: 1000,
    period: RecurringPeriod.monthly,
    nextDate: DateTime.utc(2024, 1, 1),
    createdAt: DateTime.utc(2024, 1, 1),
    updatedAt: DateTime.utc(2024, 1, 1),
  );

  group('RecurringFormNotifier', () {
    test('init null', () {
      final container = createContainer();
      container.listen(recurringFormProvider, (_, __) {});
      final n = container.read(recurringFormProvider.notifier);
      n.setAmount(999);
      n.init(null);
      expect(container.read(recurringFormProvider).amount, 0);
    });

    test('init with model', () {
      final container = createContainer();
      container.listen(recurringFormProvider, (_, __) {});
      final n = container.read(recurringFormProvider.notifier);
      n.init(sample());
      expect(container.read(recurringFormProvider).amount, 1000);
      expect(container.read(recurringFormProvider).accountId, 'a1');
    });

    test('setters', () {
      final container = createContainer();
      container.listen(recurringFormProvider, (_, __) {});
      final n = container.read(recurringFormProvider.notifier);
      n.setType(TransactionType.income);
      n.setAmount(2000);
      n.setPeriod(RecurringPeriod.yearly);
      n.setAccountId('a2');
      n.setDestinationAccountId('b1');
      n.setCategoryId('c1');
      n.setNote('note');
      n.setIsActive(isActive: false);
      n.setNextDate(DateTime.utc(2025, 5, 5));
      final s = container.read(recurringFormProvider);
      expect(s.type, TransactionType.income);
      expect(s.amount, 2000);
      expect(s.period, RecurringPeriod.yearly);
      expect(s.accountId, 'a2');
      expect(s.destinationAccountId, 'b1');
      expect(s.categoryId, 'c1');
      expect(s.note, 'note');
      expect(s.isActive, false);
      expect(s.nextDate, DateTime.utc(2025, 5, 5));
    });

    test('validation amount <=0', () async {
      final container = createContainer();
      container.listen(recurringFormProvider, (_, __) {});
      final n = container.read(recurringFormProvider.notifier);
      n.setAmount(0);
      n.setAccountId('a1');
      await n.save();
      expect(container.read(recurringFormProvider).error, 'Amount must be greater than 0');
    });

    test('validation empty accountId', () async {
      final container = createContainer();
      container.listen(recurringFormProvider, (_, __) {});
      final n = container.read(recurringFormProvider.notifier);
      n.setAmount(100);
      n.setAccountId('');
      await n.save();
      expect(container.read(recurringFormProvider).error, 'Must select an account');
    });

    test('save create success', () async {
      when(() => mockRepo.createRecurring(any())).thenAnswer((_) async => const Success(null));
      final container = createContainer();
      container.listen(recurringFormProvider, (_, __) {});
      final n = container.read(recurringFormProvider.notifier);
      n.setAmount(1000);
      n.setAccountId('a1');
      n.setNextDate(DateTime.utc(2024, 1, 1));
      await n.save();
      await Future.delayed(const Duration(milliseconds: 50));
      expect(container.read(recurringFormProvider).isSuccess, true);
      verify(() => mockRepo.createRecurring(any())).called(1);
    });

    test('save create failure', () async {
      when(() => mockRepo.createRecurring(any())).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      final container = createContainer();
      container.listen(recurringFormProvider, (_, __) {});
      final n = container.read(recurringFormProvider.notifier);
      n.setAmount(1000);
      n.setAccountId('a1');
      n.setNextDate(DateTime.utc(2024, 1, 1));
      await n.save();
      expect(container.read(recurringFormProvider).error, 'fail');
    });

    test('save update success', () async {
      when(() => mockRepo.updateRecurring(any())).thenAnswer((_) async => const Success(null));
      final container = createContainer();
      container.listen(recurringFormProvider, (_, __) {});
      final n = container.read(recurringFormProvider.notifier);
      n.init(sample());
      n.setAmount(2000);
      await n.save();
      await Future.delayed(const Duration(milliseconds: 50));
      expect(container.read(recurringFormProvider).isSuccess, true);
      verify(() => mockRepo.updateRecurring(any())).called(1);
    });

    test('save update failure', () async {
      when(() => mockRepo.updateRecurring(any())).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      final container = createContainer();
      container.listen(recurringFormProvider, (_, __) {});
      final n = container.read(recurringFormProvider.notifier);
      n.init(sample());
      n.setAmount(2000);
      await n.save();
      expect(container.read(recurringFormProvider).error, 'fail');
    });

    test('copyWith', () {
      const s = RecurringFormState(amount: 1, accountId: 'a');
      final c = s.copyWith(amount: 2);
      expect(c.amount, 2);
    });
  });
}
