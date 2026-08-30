import 'package:drift/drift.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/core/utils/logger.dart';
import 'package:poka_ce/database/daos/accounts_dao.dart';
import 'package:poka_ce/database/database.dart' as db;
import 'package:poka_ce/features/accounts/data/account_mapper.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/domain/i_account_repository.dart';

/// Implementation of [IAccountRepository] mapping Drift DAO to Freezed Domain Models.
class AccountRepositoryImpl implements IAccountRepository {
  AccountRepositoryImpl(this._dao);
  final AccountsDao _dao;

  @override
  Future<Result<List<AccountModel>, Failure>> getAccounts() async {
    try {
      final accounts = await _dao.getAllAccounts();
      final categoriesMap = await _dao.getAllAccountCategoriesMap();
      final models = accounts.map((a) => AccountMapper.fromDb(a, categoriesMap[a.id] ?? [])).toList();
      return Success(models);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'AccountRepositoryImpl.getAccounts');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Stream<Result<List<AccountModel>, Failure>> watchAccounts() async* {
    try {
      await for (final accounts in _dao.watchAllAccounts()) {
        final categoriesMap = await _dao.getAllAccountCategoriesMap();
        final models = accounts.map((a) => AccountMapper.fromDb(a, categoriesMap[a.id] ?? [])).toList();
        yield Success(models);
      }
    } on Exception catch (e, st) {
      talker.handle(e, st, 'AccountRepositoryImpl.watchAccounts');
      yield ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<AccountModel, Failure>> getAccountById(String id) async {
    try {
      final account = await _dao.getAccount(id);
      if (account == null) {
        return const ErrorResult(DatabaseFailure('Account not found'));
      }
      final categories = await _dao.getAccountCategories(id);
      return Success(AccountMapper.fromDb(account, categories));
    } on Exception catch (e, st) {
      talker.handle(e, st, 'AccountRepositoryImpl.getAccountById');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> createAccount(AccountModel model) async {
    try {
      await _dao.insertAccount(
        db.AccountsCompanion.insert(
          id: Value(model.id),
          name: model.name,
          type: model.type,
          balance: Value(model.balance),
          icon: Value(model.icon),
          color: Value(model.color),
          parentId: Value(model.parentId),
          isActive: Value(model.isActive),
          sort: Value(model.sort),
          createdAt: Value(model.createdAt.toUtc()),
          updatedAt: Value(model.updatedAt.toUtc()),
        ),
      );

      if (model.restrictedCategoryIds.isNotEmpty) {
        await _dao.setAccountCategories(model.id, model.restrictedCategoryIds);
      }
      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'AccountRepositoryImpl.createAccount');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> updateAccount(AccountModel model) async {
    try {
      await _dao.updateAccount(
        db.AccountsCompanion(
          id: Value(model.id),
          name: Value(model.name),
          type: Value(model.type),
          balance: Value(model.balance),
          icon: Value(model.icon),
          color: Value(model.color),
          parentId: Value(model.parentId),
          isActive: Value(model.isActive),
          sort: Value(model.sort),
          updatedAt: Value(DateTimeUtils.nowUtc()),
        ),
      );

      if (model.restrictedCategoryIds.isNotEmpty) {
        await _dao.setAccountCategories(model.id, model.restrictedCategoryIds);
      }
      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'AccountRepositoryImpl.updateAccount');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> deactivateAccount(String id) async {
    try {
      await _dao.deactivateAccount(id);
      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'AccountRepositoryImpl.deactivateAccount');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> deleteAccount(String id) async {
    try {
      await _dao.deleteAccount(id);
      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'AccountRepositoryImpl.deleteAccount');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> reorderAccounts(int oldIndex, int newIndex, {String? parentId}) async {
    try {
      final accounts = await _dao.getAllAccounts();
      final filteredAccounts = accounts.where((a) {
        if (parentId != null) {
          return a.parentId == parentId;
        }
        return a.parentId == null;
      }).toList()..sort((a, b) => a.sort.compareTo(b.sort));

      var targetIndex = newIndex;
      if (oldIndex < targetIndex) {
        targetIndex -= 1;
      }
      final account = filteredAccounts.removeAt(oldIndex);
      filteredAccounts.insert(targetIndex, account);

      final updatedAccounts = <db.Account>[];
      for (var i = 0; i < filteredAccounts.length; i++) {
        updatedAccounts.add(filteredAccounts[i].copyWith(sort: i));
      }

      await _dao.updateAccountsSort(updatedAccounts);
      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'AccountRepositoryImpl.reorderAccounts');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }
}
