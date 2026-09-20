import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/features/goals/presentation/widgets/forms/fields/goal_auto_pocket_banner.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    LocaleSettings.setLocale(AppLocale.en);
  });

  testWidgets('renders auto pocket banner with info icon and explanation copy', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => FTheme(data: lightTheme, child: child!),
        home: const Scaffold(body: GoalAutoPocketBanner()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byIcon(FPhosphorIcons.info), findsOneWidget);
    expect(find.text(t.goals.aDedicatedPocketAccountWillBeCreatedAutomaticallyToTrackThisGoal), findsOneWidget);
  });
}
