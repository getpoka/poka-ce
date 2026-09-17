import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/features/goals/domain/goal_model.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_form_sheet_builder_provider.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  test('goalFormSheetBuilderProvider returns null by default in CE', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final builder = container.read(goalFormSheetBuilderProvider);
    expect(builder, isNull);
  });

  test('goalFormSheetBuilderProvider can be overridden', () {
    var wasCalled = false;
    Future<void> customBuilder(
      BuildContext context, {
      GoalModel? initialGoal,
      String? initialName,
      int? initialTargetAmount,
      DateTime? initialTargetDate,
    }) async {
      wasCalled = true;
    }

    final container = ProviderContainer(overrides: [goalFormSheetBuilderProvider.overrideWith((ref) => customBuilder)]);
    addTearDown(container.dispose);

    final builder = container.read(goalFormSheetBuilderProvider);
    expect(builder, isNotNull);
    builder!(MockBuildContext());
    expect(wasCalled, isTrue);
  });
}
