import 'package:poka_ce/features/accounts/domain/account_model.dart';

/// Returns the transactable account for [candidate].
///
/// If [candidate] is a root account (not a pocket), this redirects to its
/// default Main Pocket so that transactions are never recorded directly on
/// the root. Falls back to the first pocket of the root, then to [candidate]
/// itself if no pockets exist.
AccountModel resolveToTransactableAccount(AccountModel candidate, List<AccountModel> accounts) {
  if (candidate.isPocket) return candidate;
  // Prefer the marked-default (Main) pocket, otherwise the first pocket.
  final pocket =
      accounts.where((a) => a.parentId == candidate.id && a.isMainPocket).firstOrNull ??
      accounts.where((a) => a.parentId == candidate.id).firstOrNull;
  return pocket ?? candidate;
}
