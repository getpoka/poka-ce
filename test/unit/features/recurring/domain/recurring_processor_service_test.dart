import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/recurring/domain/i_recurring_repository.dart';
import 'package:poka_ce/features/recurring/domain/recurring_model.dart';
import 'package:poka_ce/features/recurring/domain/recurring_processor_service.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';

class MockRecurringRepository extends Mock implements IRecurringRepository {}

class MockTransactionRepository extends Mock implements ITransactionRepository {}

class FakeTransactionModel extends Fake implements TransactionModel {}

class FakeRecurringTransactionModel extends Fake implements RecurringTransactionModel {}

void main() {
  late MockRecurringRepository recurringRepo;
  late MockTransactionRepository transactionRepo;
  late RecurringProcessorService service;

  setUpAll(() {
    registerFallbackValue(FakeTransactionModel());
    registerFallbackValue(FakeRecurringTransactionModel());
  });

  setUp(() {
    recurringRepo = MockRecurringRepository();
    transactionRepo = MockTransactionRepository();
    service = RecurringProcessorService(
      recurringRepository: recurringRepo,
      transactionRepository: transactionRepo,
    );
  });

  final testDate = DateTime.utc(2023, 10, 10);
  final testRecurring = RecurringTransactionModel(
    id: 'r1',
    accountId: 'a1',
    categoryId: 'c1',
    type: TransactionType.expense,
    amount: 100,
    period: RecurringPeriod.monthly,
    nextDate: testDate,
    createdAt: testDate,
    updatedAt: testDate,
  );

  group('RecurringProcessorService', () {
    test('run returns ErrorResult when getDueRecurringTransactions fails', () async {
      when(() => recurringRepo.getDueRecurringTransactions(any()))
          .thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));

      final result = await service.run(testDate);

      expect(result, isA<ErrorResult>());
      expect((result as ErrorResult).error.message, 'fail');
    });

    test('run returns 0 when no recurring transactions are due', () async {
      when(() => recurringRepo.getDueRecurringTransactions(any())).thenAnswer((_) async => const Success([]));

      final result = await service.run(testDate);

      expect(result, isA<Success<int, Failure>>());
      expect((result as Success).value, 0);
    });

    test('run processes due transactions and advances nextDate', () async {
      when(() => recurringRepo.getDueRecurringTransactions(any())).thenAnswer((_) async => Success([testRecurring]));
      when(() => transactionRepo.createTransaction(any())).thenAnswer((_) async => const Success(null));
      when(() => recurringRepo.updateRecurring(any())).thenAnswer((_) async => const Success(null));

      final result = await service.run(testDate);

      expect(result, isA<Success>());
      expect((result as Success).value, 1);

      verify(() => transactionRepo.createTransaction(any())).called(1);
      final captured = verify(() => recurringRepo.updateRecurring(captureAny())).captured;
      final updatedRecurring = captured.first as RecurringTransactionModel;

      // Check if nextDate advanced by a month
      expect(updatedRecurring.nextDate, DateTime.utc(2023, 11, 10));
    });

    test('run handles transaction creation failure', () async {
      when(() => recurringRepo.getDueRecurringTransactions(any())).thenAnswer((_) async => Success([testRecurring]));
      when(() => transactionRepo.createTransaction(any()))
          .thenAnswer((_) async => const ErrorResult(DatabaseFailure('tx_fail')));

      final result = await service.run(testDate);

      expect(result, isA<Success>());
      expect((result as Success).value, 0); // 0 successful

      verify(() => transactionRepo.createTransaction(any())).called(1);
      verifyNever(() => recurringRepo.updateRecurring(any()));
    });

    test('run handles update recurring failure but still counts as success', () async {
      when(() => recurringRepo.getDueRecurringTransactions(any())).thenAnswer((_) async => Success([testRecurring]));
      when(() => transactionRepo.createTransaction(any())).thenAnswer((_) async => const Success(null));
      when(() => recurringRepo.updateRecurring(any()))
          .thenAnswer((_) async => const ErrorResult(DatabaseFailure('update_fail')));

      final result = await service.run(testDate);

      expect(result, isA<Success>());
      expect((result as Success).value, 1); // still considered 1 because tx created

      verify(() => transactionRepo.createTransaction(any())).called(1);
      verify(() => recurringRepo.updateRecurring(any())).called(1);
    });

    group('Period Advancements', () {
      test('Daily advancement', () async {
        final daily = testRecurring.copyWith(period: RecurringPeriod.daily);
        when(() => recurringRepo.getDueRecurringTransactions(any())).thenAnswer((_) async => Success([daily]));
        when(() => transactionRepo.createTransaction(any())).thenAnswer((_) async => const Success(null));
        when(() => recurringRepo.updateRecurring(any())).thenAnswer((_) async => const Success(null));

        await service.run(testDate);

        final captured = verify(() => recurringRepo.updateRecurring(captureAny())).captured;
        expect((captured.first as RecurringTransactionModel).nextDate, testDate.add(const Duration(days: 1)));
      });

      test('Weekly advancement', () async {
        final weekly = testRecurring.copyWith(period: RecurringPeriod.weekly);
        when(() => recurringRepo.getDueRecurringTransactions(any())).thenAnswer((_) async => Success([weekly]));
        when(() => transactionRepo.createTransaction(any())).thenAnswer((_) async => const Success(null));
        when(() => recurringRepo.updateRecurring(any())).thenAnswer((_) async => const Success(null));

        await service.run(testDate);

        final captured = verify(() => recurringRepo.updateRecurring(captureAny())).captured;
        expect((captured.first as RecurringTransactionModel).nextDate, testDate.add(const Duration(days: 7)));
      });

      test('Yearly advancement', () async {
        final yearly = testRecurring.copyWith(period: RecurringPeriod.yearly);
        when(() => recurringRepo.getDueRecurringTransactions(any())).thenAnswer((_) async => Success([yearly]));
        when(() => transactionRepo.createTransaction(any())).thenAnswer((_) async => const Success(null));
        when(() => recurringRepo.updateRecurring(any())).thenAnswer((_) async => const Success(null));

        await service.run(testDate);

        final captured = verify(() => recurringRepo.updateRecurring(captureAny())).captured;
        expect((captured.first as RecurringTransactionModel).nextDate, DateTime.utc(2024, 10, 10));
      });
    });
  });
}
