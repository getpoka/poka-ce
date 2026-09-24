/// Extension point for the Debt Form Sheet builder.
library;

import 'package:flutter/widgets.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';
import 'package:poka_ce/features/debts/presentation/widgets/debt_form_sheet.dart' show DebtFormSheet;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debt_form_sheet_builder_provider.g.dart';

/// Signature for a function that shows the debt creation / edit form sheet.
///
/// Mirrors the signature of [DebtFormSheet.show] so that callers can
/// invoke the form without importing the concrete widget class.
typedef DebtFormSheetBuilder = Future<void> Function(
  BuildContext context, {
  DebtModel? initialDebt,
  String? initialPersonName,
  DebtType? initialType,
  int? initialAmount,
});

/// Provides an optional [DebtFormSheetBuilder] override for the debt form.
///
/// Returns `null` by default — callers fall back to the default [DebtFormSheet.show].
/// Can be overridden in the root ProviderScope to inject a custom form sheet.
@riverpod
DebtFormSheetBuilder? debtFormSheetBuilder(Ref ref) => null;
