/// Extension point for the Recurring Form Sheet builder.
library;

import 'package:flutter/widgets.dart';
import 'package:poka_ce/features/recurring/domain/recurring_model.dart';
import 'package:poka_ce/features/recurring/presentation/widgets/recurring_form_sheet.dart' show RecurringFormSheet;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recurring_form_sheet_builder_provider.g.dart';

/// Signature for a function that shows the recurring transaction creation / edit form sheet.
///
/// Mirrors the signature of [RecurringFormSheet.show] so that callers can
/// invoke the form without importing the concrete widget class.
typedef RecurringFormSheetBuilder = Future<void> Function(
  BuildContext context, {
  RecurringTransactionModel? initialRecurring,
});

/// Provides an optional [RecurringFormSheetBuilder] override for the recurring form.
///
/// Returns `null` by default — callers fall back to the default [RecurringFormSheet.show].
/// Can be overridden in the root ProviderScope to inject a custom form sheet.
@riverpod
RecurringFormSheetBuilder? recurringFormSheetBuilder(Ref ref) => null;
