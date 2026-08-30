import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/settings/domain/currency_model.dart';
import 'package:poka_ce/features/settings/domain/settings_model.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  Widget wrap(Widget child, {SettingsState? state}) {
    return ProviderScope(
      overrides: [
        settingsProvider.overrideWith(() => _FakeSettingsNotifier(state ?? const SettingsState())),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, c) => FTheme(data: lightTheme, child: c!),
          home: Scaffold(body: Center(child: child)),
        ),
      ),
    );
  }

  group('PokaAmountText', () {
    testWidgets('income shows + prefix and green', (tester) async {
      await tester.pumpWidget(wrap(const PokaAmountText(amount: 50000, type: TransactionType.income)));
      await tester.pump();
      expect(find.textContaining('+'), findsOneWidget);
      // income formatted with Rp by default fallback
      expect(find.textContaining('Rp'), findsOneWidget);
      final text = tester.widget<Text>(find.byType(Text));
      // lightTheme income color is emerald600
      expect(text.style!.color, const Color(0xFF059669));
    });

    testWidgets('expense shows - prefix and destructive color', (tester) async {
      await tester.pumpWidget(wrap(const PokaAmountText(amount: 25000, type: TransactionType.expense)));
      await tester.pump();
      expect(find.textContaining('-'), findsOneWidget);
      final text = tester.widget<Text>(find.byType(Text));
      // destructive is theme's destructive, not green
      expect(text.style!.color, isNot(const Color(0xFF10B981)));
    });

    testWidgets('transfer shows no prefix and foreground color', (tester) async {
      await tester.pumpWidget(wrap(const PokaAmountText(amount: 10000, type: TransactionType.transfer)));
      await tester.pump();
      // transfer prefix is empty, so text should NOT contain + or -
      final textWidget = tester.widget<Text>(find.byType(Text));
      final data = textWidget.data!;
      expect(data.startsWith('+'), false);
      expect(data.startsWith('-'), false);
      expect(data.contains('Rp'), true);
      // color is foreground (not green, not destructive) - check not emerald
      expect(textWidget.style!.color, isNot(const Color(0xFF10B981)));
    });

    testWidgets('isObscured true shows bullets with prefix', (tester) async {
      await tester.pumpWidget(
        wrap(const PokaAmountText(amount: 12345, type: TransactionType.income, isObscured: true)),
      );
      await tester.pump();
      expect(find.textContaining('••••••'), findsOneWidget);
      expect(find.textContaining('+'), findsOneWidget);
    });

    testWidgets('isObscured expense shows - ••••••', (tester) async {
      await tester.pumpWidget(wrap(const PokaAmountText(amount: 999, type: TransactionType.expense, isObscured: true)));
      await tester.pump();
      expect(find.text('- ••••••'), findsOneWidget);
    });

    testWidgets('isObscured transfer shows •••••• without prefix', (tester) async {
      await tester.pumpWidget(
        wrap(const PokaAmountText(amount: 777, type: TransactionType.transfer, isObscured: true)),
      );
      await tester.pump();
      // transfer obscured is "••••••" without +/-
      expect(find.text('••••••'), findsOneWidget);
    });

    testWidgets('uses fallbackCurrencySymbol when settings not loaded', (tester) async {
      await tester.pumpWidget(
        wrap(const PokaAmountText(amount: 1000, type: TransactionType.income, fallbackCurrencySymbol: 'USD')),
      );
      await tester.pump();
      expect(find.textContaining('USD'), findsOneWidget);
    });

    testWidgets('uses baseCurrency symbol from settings when available', (tester) async {
      const state = SettingsState(
        settings: SettingsModel(
          themeMode: 'system',
          baseCurrency: CurrencyModel(id: 'c1', name: 'Dollar', code: 'USD', symbol: r'$', precision: 2),
        ),
      );
      await tester.pumpWidget(wrap(const PokaAmountText(amount: 1000, type: TransactionType.income), state: state));
      await tester.pump();
      expect(find.textContaining(r'$'), findsOneWidget);
      expect(find.textContaining('USD'), findsNothing);
    });

    testWidgets('custom style is respected but color overridden', (tester) async {
      const custom = TextStyle(fontSize: 99, fontWeight: FontWeight.bold);
      await tester.pumpWidget(wrap(const PokaAmountText(amount: 100, type: TransactionType.income, style: custom)));
      await tester.pump();
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style!.fontSize, 99);
      expect(text.style!.fontWeight, FontWeight.bold);
      // color still emerald for income
      expect(text.style!.color, const Color(0xFF059669));
    });
  });
}

class _FakeSettingsNotifier extends SettingsNotifier {
  final SettingsState _state;
  _FakeSettingsNotifier(this._state);
  @override
  SettingsState build() => _state;
}
