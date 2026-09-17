/// Extension point for the Goal Form Sheet builder.
library;

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' show ProviderScope;
import 'package:hooks_riverpod/hooks_riverpod.dart' show ProviderScope;
import 'package:poka_ce/features/goals/domain/goal_model.dart';
import 'package:poka_ce/features/goals/presentation/widgets/goal_form_sheet.dart' show GoalFormSheet;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'goal_form_sheet_builder_provider.g.dart';

/// Signature for a function that shows the goal creation / edit form sheet.
///
/// Mirrors the signature of [GoalFormSheet.show] so that callers can
/// invoke the form without importing the concrete widget class.
typedef GoalFormSheetBuilder = Future<void> Function(
  BuildContext context, {
  GoalModel? initialGoal,
  String? initialName,
  int? initialTargetAmount,
  DateTime? initialTargetDate,
});

/// Provides an optional [GoalFormSheetBuilder] override for the goal form.
///
/// In CE, returns `null` — callers fall back to the default GoalFormSheet.show.
/// Poka PE overrides this in the root ProviderScope to inject
/// PeGoalFormSheet.show, which adds a currency selector for the
/// automatically-generated goal pocket account.
@riverpod
GoalFormSheetBuilder? goalFormSheetBuilder(Ref ref) => null;
