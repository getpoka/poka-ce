/// Extension point for customising account balance display in selectors.
library;

import 'package:flutter/widgets.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_balance_builder_provider.g.dart';

/// Signature for a custom widget builder that renders an [AccountModel]'s
/// balance in a list or selector context.
///
/// Receives [context] and the fully-resolved [account] domain model.
typedef AccountBalanceBuilder = Widget Function(BuildContext context, AccountModel account);

/// Provides an optional [AccountBalanceBuilder] override for rendering account
/// balances inside selectors (e.g. `PokaPocketSelector`).
///
/// Returns `null` by default — callers fall back to `PokaAmountText` with the
/// app's base currency from Settings.
///
/// Downstream consumers (e.g. Poka PE) can override this provider via
/// `ProviderScope(overrides: [...])` to inject per-account, currency-aware
/// balance rendering without modifying CE source files.
@riverpod
AccountBalanceBuilder? accountBalanceBuilder(Ref ref) => null;
