import 'package:poka_ce/database/database.dart' as db;
import 'package:poka_ce/features/accounts/domain/account_model.dart';

/// Mapper to convert data between Domain and Data layer for Account.
class AccountMapper {
  const AccountMapper._();

  /// Maps Drift Account object to Domain AccountModel.
  static AccountModel fromDb(db.Account account, List<String> restrictedCategoryIds) {
    return AccountModel(
      id: account.id,
      name: account.name,
      type: account.type,
      balance: account.balance,
      initialBalance: account.initialBalance,
      icon: account.icon,
      color: account.color,
      parentId: account.parentId,
      isActive: account.isActive,
      sort: account.sort,
      restrictedCategoryIds: restrictedCategoryIds,
      createdAt: account.createdAt,
      updatedAt: account.updatedAt,
    );
  }
}
