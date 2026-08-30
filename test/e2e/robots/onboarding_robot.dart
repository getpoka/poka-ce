import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'robot_base.dart';

import 'package:poka_ce/features/onboarding/presentation/screens/onboarding_page.dart';
import 'package:poka_ce/features/settings/presentation/widgets/currency_search_list.dart';

class OnboardingRobot extends RobotBase {
  const OnboardingRobot(super.tester);

  void verifyOnboardingPageShown() {
    expect(find.byType(OnboardingPage), findsOneWidget);
    expect(find.byType(CurrencySearchList), findsOneWidget);
  }

  void verifyOnboardingPageHidden() {
    expect(find.byType(OnboardingPage), findsNothing);
  }

  Future<void> selectCurrency(String currencyCode) async {
    final currencyItem = find.text(currencyCode);
    final scrollable = find.byType(Scrollable).last;

    await tester.dragUntilVisible(
      currencyItem,
      scrollable,
      const Offset(0, -300),
      maxIteration: 50,
    );
    await settle();

    await tester.tap(currencyItem.last);
    await settle();
  }

  Future<void> tapContinue() async {
    final continueButton = find.text('Continue with selected currency').first;
    await tester.tap(continueButton);
    await settle();
  }
}
