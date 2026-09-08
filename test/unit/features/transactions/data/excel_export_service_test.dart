import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/domain/i_account_repository.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/domain/i_category_repository.dart';
import 'package:poka_ce/features/transactions/data/excel_export_service.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';

class MockTransactionRepository extends Mock implements ITransactionRepository {}

class MockAccountRepository extends Mock implements IAccountRepository {}

class MockCategoryRepository extends Mock implements ICategoryRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const pathProviderChannel = MethodChannel('plugins.flutter.io/path_provider');

  setUpAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      pathProviderChannel,
      (call) async {
        final tempPath = Directory.systemTemp.path;
        return switch (call.method) {
          'getTemporaryDirectory' => tempPath,
          'getApplicationDocumentsDirectory' => tempPath,
          'getApplicationSupportDirectory' => tempPath,
          _ => null,
        };
      },
    );
  });

  late MockTransactionRepository mockTxRepo;
  late MockAccountRepository mockAccRepo;
  late MockCategoryRepository mockCatRepo;
  late ExcelExportService service;

  setUp(() {
    mockTxRepo = MockTransactionRepository();
    mockAccRepo = MockAccountRepository();
    mockCatRepo = MockCategoryRepository();

    service = ExcelExportService(
      transactionRepository: mockTxRepo,
      accountRepository: mockAccRepo,
      categoryRepository: mockCatRepo,
    );
  });

  group('ExcelExportService', () {
    test('exports transactions, accounts, and categories to valid .xlsx file', () async {
      final now = DateTime(2026, 9, 8, 14, 30);

      final accounts = [
        AccountModel(
          id: 'acc1',
          name: 'Main Wallet',
          type: AccountType.assets,
          balance: 150000,
          initialBalance: 100000,
          createdAt: now,
          updatedAt: now,
        ),
      ];

      final categories = [
        CategoryModel(
          id: 'cat1',
          name: 'Food & Dining',
          type: CategoryType.expense,
          createdAt: now,
          updatedAt: now,
        ),
      ];

      final transactions = [
        TransactionModel(
          id: 'tx1',
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 25000,
          transactionDate: now,
          note: 'Lunch at Cafe',
          createdAt: now,
          updatedAt: now,
          items: [
            TransactionItemModel(
              id: 'item1',
              transactionId: 'tx1',
              categoryId: 'cat1',
              allocation: TransactionAllocation.need,
              amount: 25000,
              note: 'Nasi Goreng',
              createdAt: now,
              updatedAt: now,
            ),
          ],
        ),
        TransactionModel(
          id: 'tx2',
          accountId: 'acc1',
          type: TransactionType.income,
          amount: 75000,
          transactionDate: now,
          note: 'Freelance payment',
          createdAt: now,
          updatedAt: now,
          items: [],
        ),
      ];

      when(() => mockTxRepo.getTransactions()).thenAnswer(
        (_) async => Success(transactions),
      );
      when(() => mockAccRepo.getAccounts()).thenAnswer(
        (_) async => Success(accounts),
      );
      when(() => mockCatRepo.getCategories()).thenAnswer(
        (_) async => Success(categories),
      );

      final result = await service.exportToFile();

      expect(result, isA<Success<File, Failure>>());
      final file = (result as Success<File, Failure>).value;
      expect(file.existsSync(), isTrue);

      final bytes = file.readAsBytesSync();
      final excel = Excel.decodeBytes(bytes);

      // Verify Sheets
      expect(excel.sheets.containsKey('Transactions'), isTrue);
      expect(excel.sheets.containsKey('Accounts'), isTrue);
      expect(excel.sheets.containsKey('Categories'), isTrue);
      expect(excel.sheets.containsKey('Sheet1'), isFalse);

      // Verify Transactions Sheet Rows
      final txSheet = excel['Transactions'];
      expect(txSheet.maxRows, 3); // 1 header + 1 split item + 1 plain transaction

      // Verify Accounts Sheet Rows
      final accSheet = excel['Accounts'];
      expect(accSheet.maxRows, 2); // 1 header + 1 account

      // Verify Categories Sheet Rows
      final catSheet = excel['Categories'];
      expect(catSheet.maxRows, 2); // 1 header + 1 category

      // Clean up temp file
      if (file.existsSync()) {
        file.deleteSync();
      }
    });

    test('returns ErrorResult when transaction repository fails', () async {
      when(() => mockTxRepo.getTransactions()).thenAnswer(
        (_) async => const ErrorResult(DatabaseFailure('DB error')),
      );
      when(() => mockAccRepo.getAccounts()).thenAnswer(
        (_) async => const Success([]),
      );
      when(() => mockCatRepo.getCategories()).thenAnswer(
        (_) async => const Success([]),
      );

      final result = await service.exportToFile();

      expect(result, isA<ErrorResult<File, Failure>>());
      final failure = (result as ErrorResult<File, Failure>).error;
      expect(failure, isA<DatabaseFailure>());
    });

    test('cleanupOldExports deletes the exports directory and stale files', () async {
      final tempDir = Directory.systemTemp;
      final exportDir = Directory('${tempDir.path}/exports');
      if (!exportDir.existsSync()) {
        exportDir.createSync(recursive: true);
      }
      final dummyFile = File('${exportDir.path}/poka-export-old.xlsx');
      dummyFile.writeAsStringSync('dummy');
      expect(dummyFile.existsSync(), isTrue);

      await service.cleanupOldExports();

      expect(exportDir.existsSync(), isFalse);
    });

    test('exportToFile purges previous export files before creating a new one', () async {
      when(() => mockTxRepo.getTransactions()).thenAnswer(
        (_) async => const Success([]),
      );
      when(() => mockAccRepo.getAccounts()).thenAnswer(
        (_) async => const Success([]),
      );
      when(() => mockCatRepo.getCategories()).thenAnswer(
        (_) async => const Success([]),
      );

      final tempDir = Directory.systemTemp;
      final exportDir = Directory('${tempDir.path}/exports');
      if (!exportDir.existsSync()) {
        exportDir.createSync(recursive: true);
      }
      final staleFile = File('${exportDir.path}/poka-export-20200101-000000.xlsx');
      staleFile.writeAsStringSync('stale data');
      expect(staleFile.existsSync(), isTrue);

      final result = await service.exportToFile();
      expect(result, isA<Success<File, Failure>>());
      final newFile = (result as Success<File, Failure>).value;

      expect(staleFile.existsSync(), isFalse);
      expect(newFile.existsSync(), isTrue);

      // Clean up after test
      await service.cleanupOldExports();
    });
  });
}
