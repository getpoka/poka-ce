import 'dart:io';
import 'dart:ui';

import 'package:excel/excel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/logger.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/domain/i_account_repository.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/domain/i_category_repository.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:share_plus/share_plus.dart';

/// Provider for [ExcelExportService].
final excelExportServiceProvider = Provider<ExcelExportService>((ref) {
  final txRepo = ref.watch(transactionRepositoryProvider);
  final accRepo = ref.watch(accountRepositoryProvider);
  final catRepo = ref.watch(categoryRepositoryProvider);
  return ExcelExportService(
    transactionRepository: txRepo,
    accountRepository: accRepo,
    categoryRepository: catRepo,
  );
});

/// Service responsible for exporting transactions, accounts, and categories
/// to a formatted multi-sheet Excel (.xlsx) file and sharing it natively.
class ExcelExportService {
  /// Creates an [ExcelExportService].
  const ExcelExportService({
    required this._transactionRepository,
    required this._accountRepository,
    required this._categoryRepository,
  });

  final ITransactionRepository _transactionRepository;
  final IAccountRepository _accountRepository;
  final ICategoryRepository _categoryRepository;

  /// Generates the Excel workbook and writes it to a temporary file.
  Future<Result<File, Failure>> exportToFile() async {
    try {
      final txResult = await _transactionRepository.getTransactions();
      if (txResult is ErrorResult<List<TransactionModel>, Failure>) {
        return ErrorResult<File, Failure>(txResult.error);
      }
      final transactions = (txResult as Success<List<TransactionModel>, Failure>).value;

      final accResult = await _accountRepository.getAccounts();
      if (accResult is ErrorResult<List<AccountModel>, Failure>) {
        return ErrorResult<File, Failure>(accResult.error);
      }
      final accounts = (accResult as Success<List<AccountModel>, Failure>).value;

      final catResult = await _categoryRepository.getCategories();
      if (catResult is ErrorResult<List<CategoryModel>, Failure>) {
        return ErrorResult<File, Failure>(catResult.error);
      }
      final categories = (catResult as Success<List<CategoryModel>, Failure>).value;

      final accountsMap = <String, AccountModel>{
        for (final acc in accounts) acc.id: acc,
      };

      final categoriesMap = <String, CategoryModel>{
        for (final cat in categories) cat.id: cat,
      };

      final excel = Excel.createExcel();

      // 1. Sheet: Transactions
      final txSheet = excel['Transactions']
        ..appendRow([
          TextCellValue('ID'),
          TextCellValue('Date'),
          TextCellValue('Type'),
          TextCellValue('Account'),
          TextCellValue('Destination Account'),
          TextCellValue('Category'),
          TextCellValue('Amount'),
          TextCellValue('Allocation'),
          TextCellValue('Note'),
        ]);

      final dateFormatter = DateFormat('yyyy-MM-dd HH:mm');
      for (final tx in transactions) {
        final dateStr = dateFormatter.format(tx.transactionDate);
        final accountName = accountsMap[tx.accountId]?.name ?? tx.accountId;
        final destName = tx.destinationAccountId != null
            ? (accountsMap[tx.destinationAccountId]?.name ?? tx.destinationAccountId!)
            : '';

        if (tx.items.isNotEmpty) {
          for (final item in tx.items) {
            final catName = categoriesMap[item.categoryId]?.name ?? '';
            final allocationStr = item.allocation?.name ?? '';
            final noteStr = item.note ?? tx.note ?? '';

            txSheet.appendRow([
              TextCellValue(tx.id),
              TextCellValue(dateStr),
              TextCellValue(tx.type.name),
              TextCellValue(accountName),
              TextCellValue(destName),
              TextCellValue(catName),
              IntCellValue(item.amount),
              TextCellValue(allocationStr),
              TextCellValue(noteStr),
            ]);
          }
        } else {
          txSheet.appendRow([
            TextCellValue(tx.id),
            TextCellValue(dateStr),
            TextCellValue(tx.type.name),
            TextCellValue(accountName),
            TextCellValue(destName),
            TextCellValue(''),
            IntCellValue(tx.amount),
            TextCellValue(''),
            TextCellValue(tx.note ?? ''),
          ]);
        }
      }

      // 2. Sheet: Accounts
      final accSheet = excel['Accounts']
        ..appendRow([
          TextCellValue('ID'),
          TextCellValue('Name'),
          TextCellValue('Type'),
          TextCellValue('Balance'),
          TextCellValue('Initial Balance'),
        ]);

      for (final acc in accounts) {
        accSheet.appendRow([
          TextCellValue(acc.id),
          TextCellValue(acc.name),
          TextCellValue(acc.type.name),
          IntCellValue(acc.balance),
          IntCellValue(acc.initialBalance),
        ]);
      }

      // 3. Sheet: Categories
      final catSheet = excel['Categories']
        ..appendRow([
          TextCellValue('ID'),
          TextCellValue('Name'),
          TextCellValue('Type'),
          TextCellValue('Parent Category'),
        ]);

      for (final cat in categories) {
        final parentName = cat.parentId != null ? (categoriesMap[cat.parentId]?.name ?? '') : '';
        catSheet.appendRow([
          TextCellValue(cat.id),
          TextCellValue(cat.name),
          TextCellValue(cat.type.name),
          TextCellValue(parentName),
        ]);
      }

      // Remove default empty Sheet1 if present
      if (excel.sheets.containsKey('Sheet1')) {
        excel.delete('Sheet1');
      }
      excel.setDefaultSheet('Transactions');

      final bytes = excel.encode();
      if (bytes == null) {
        return const ErrorResult<File, Failure>(UnexpectedFailure('Failed to encode Excel file'));
      }

      final tempDir = await getTemporaryDirectory();
      final fileFormatter = DateFormat('yyyyMMdd-HHmmss');
      final filePath = p.join(tempDir.path, 'poka-export-${fileFormatter.format(DateTime.now())}.xlsx');
      final file = File(filePath);
      await file.writeAsBytes(bytes);

      return Success<File, Failure>(file);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'ExcelExportService.exportToFile');
      return ErrorResult<File, Failure>(UnexpectedFailure(e.toString()));
    }
  }

  /// Exports data to an Excel file and presents the native sharing sheet.
  Future<Result<File, Failure>> exportAndShare({Rect? sharePositionOrigin}) async {
    final exportResult = await exportToFile();
    if (exportResult is ErrorResult<File, Failure>) {
      return exportResult;
    }
    final file = (exportResult as Success<File, Failure>).value;
    try {
      // We use Share.shareXFiles for cross-platform stability
      // ignore: deprecated_member_use
      await Share.shareXFiles(
        [XFile(file.path, mimeType: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')],
        sharePositionOrigin: sharePositionOrigin != null
            ? Rect.fromCenter(center: sharePositionOrigin.center, width: 1, height: 1)
            : null,
      );
      return Success<File, Failure>(file);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'ExcelExportService.exportAndShare');
      return ErrorResult<File, Failure>(UnexpectedFailure(e.toString()));
    }
  }
}
