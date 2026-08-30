import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart' hide GlobalMaterialLocalizations;
import 'package:poka_ce/app/router/router.dart';
import 'package:poka_ce/features/debts/domain/debt_alert_service_provider.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

/// Root widget for Poka CE.
class PokaApp extends HookConsumerWidget {
  const PokaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final settingsState = ref.watch(settingsProvider);

    var themeMode = ThemeMode.system;
    switch (settingsState.settings?.themeMode) {
      case 'light':
        themeMode = ThemeMode.light;
      case 'dark':
        themeMode = ThemeMode.dark;
    }

    // Sync language state to LocaleSettings
    final lang = settingsState.settings?.language;
    useEffect(() {
      if (lang != null) {
        if (lang == 'system') {
          LocaleSettings.useDeviceLocale();
        } else {
          LocaleSettings.setLocaleRaw(lang);
        }
      }
      return null;
    }, [lang]);

    useEffect(() {
      // Run debt alerts check on startup
      ref.read(debtAlertServiceProvider).checkAlerts();
      return null;
    }, const []);

    return TranslationProvider(
      child: MaterialApp.router(
        title: t.app.name,
        debugShowCheckedModeBanner: false,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: const [
          ...FLocalizations.localizationsDelegates,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        themeMode: themeMode,
        theme: lightTheme.toApproximateMaterialTheme(),
        darkTheme: darkTheme.toApproximateMaterialTheme(),
        builder: (context, child) => FTheme(
          data: Theme.brightnessOf(context) == Brightness.light ? lightTheme : darkTheme,
          child: FToaster(child: FTooltipGroup(child: child!)),
        ),
        routerConfig: router,
      ),
    );
  }
}
