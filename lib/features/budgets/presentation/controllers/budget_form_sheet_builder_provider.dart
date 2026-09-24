/// Extension point for the Budget Form Sheet builder.
library;

import 'package:flutter/widgets.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:poka_ce/features/budgets/presentation/widgets/forms/budget_form_sheet.dart' show BudgetFormSheet;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'budget_form_sheet_builder_provider.g.dart';

/// Signature for a function that shows the budget creation / edit form sheet.
///
/// Mirrors the signature of [BudgetFormSheet.show] so that callers can
/// invoke the form without importing the concrete widget class.
typedef BudgetFormSheetBuilder = Future<void> Function(
  BuildContext context, {
  BudgetModel? initialBudget,
  String? initialName,
  int? initialAmount,
  BudgetPeriod? initialPeriod,
});

/// Provides an optional [BudgetFormSheetBuilder] override for the budget form.
///
/// In CE, returns `null` — callers fall back to the default BudgetFormSheet.show.
/// Poka PE overrides this in the root ProviderScope to inject
/// PeBudgetFormSheet.show, which adds a currency selector.
@riverpod
BudgetFormSheetBuilder? budgetFormSheetBuilder(Ref ref) => null;
