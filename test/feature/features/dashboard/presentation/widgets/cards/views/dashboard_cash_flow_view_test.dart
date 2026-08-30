import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/cards/views/dashboard_cash_flow_view.dart';
import 'package:poka_ce/theme/theme.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  Widget createWidget(DashboardState state) {
    return ProviderScope(
      overrides: [
        dashboardProvider.overrideWith(() => _FakeDashboardNotifier(state)),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: const Scaffold(
            body: SingleChildScrollView(child: DashboardCashFlowView()),
          ),
        ),
      ),
    );
  }

  group('DashboardCashFlowView', () {
    testWidgets('renders with zero income and expense shows 0% and Needs attention', (tester) async {
      await tester.pumpWidget(createWidget(const DashboardState(totalIncome: 0, totalExpense: 0)));
      await tester.pump();

      expect(find.text('0%'), findsOneWidget);
      expect(find.text('saved'), findsOneWidget);
      expect(find.text('Needs attention'), findsOneWidget);
      expect(find.text('Income'), findsOneWidget);
      expect(find.text('Expense'), findsOneWidget);
      // Income/expense values 0
      expect(find.text('0'), findsNWidgets(2));
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('shows On track when saved >=20%', (tester) async {
      // income 10000 expense 7000 => saved 30%
      await tester.pumpWidget(createWidget(const DashboardState(totalIncome: 10000, totalExpense: 7000)));
      await tester.pump();

      expect(find.text('30%'), findsOneWidget);
      expect(find.text('On track'), findsOneWidget);
      expect(find.text('Needs attention'), findsNothing);
    });

    testWidgets('shows Needs attention when saved <20%', (tester) async {
      // income 10000 expense 9000 => saved 10%
      await tester.pumpWidget(createWidget(const DashboardState(totalIncome: 10000, totalExpense: 9000)));
      await tester.pump();

      expect(find.text('10%'), findsOneWidget);
      expect(find.text('Needs attention'), findsOneWidget);
      expect(find.text('On track'), findsNothing);
    });

    testWidgets('saved clamped to 0 when expense > income', (tester) async {
      await tester.pumpWidget(createWidget(const DashboardState(totalIncome: 1000, totalExpense: 2000)));
      await tester.pump();

      expect(find.text('0%'), findsOneWidget);
      expect(find.text('Needs attention'), findsOneWidget);
    });

    testWidgets('renders income and expense with compact format and icons', (tester) async {
      await tester.pumpWidget(createWidget(const DashboardState(totalIncome: 12000000, totalExpense: 3000000)));
      await tester.pump();

      // 75% saved
      expect(find.text('75%'), findsOneWidget);
      expect(find.text('On track'), findsOneWidget);
      // compact formats
      expect(find.textContaining('12.0M'), findsOneWidget);
      expect(find.textContaining('3.0M'), findsOneWidget);
      expect(
        find.byWidgetPredicate((w) => w is Icon && w.icon == FPhosphorIcons.arrowDownLeft),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate((w) => w is Icon && w.icon == FPhosphorIcons.arrowUpRight),
        findsOneWidget,
      );
    });

    testWidgets('saved 20% exactly shows On track', (tester) async {
      // income 10000 expense 8000 => 20%
      await tester.pumpWidget(createWidget(const DashboardState(totalIncome: 10000, totalExpense: 8000)));
      await tester.pump();

      expect(find.text('20%'), findsOneWidget);
      expect(find.text('On track'), findsOneWidget);
    });

    testWidgets('shows 100% when expense is 0 and income >0', (tester) async {
      await tester.pumpWidget(createWidget(const DashboardState(totalIncome: 5000, totalExpense: 0)));
      await tester.pump();

      expect(find.text('100%'), findsOneWidget);
      expect(find.text('On track'), findsOneWidget);
    });
  });
}

class _FakeDashboardNotifier extends DashboardNotifier {
  final DashboardState _state;
  _FakeDashboardNotifier(this._state);
  @override
  DashboardState build() => _state;
}
