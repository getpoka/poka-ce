import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart' hide GlobalMaterialLocalizations;
import 'package:poka_ce/app/router/router.dart';
import 'package:poka_ce/core/services/quick_actions_service.dart';
import 'package:poka_ce/features/backup/domain/backup_reminder_service.dart';
import 'package:poka_ce/features/debts/domain/debt_alert_service_provider.dart';
import 'package:poka_ce/features/settings/presentation/controllers/app_lock_controller.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/features/transactions/data/excel_export_service.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

/// Root widget for Poka CE.
class PokaApp extends HookConsumerWidget {
  const PokaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final settingsState = ref.watch(settingsProvider);

    // ── App Lock Background Grace Period (1 minute) ──────────────────────────
    final lifecycleState = useAppLifecycleState();
    final lastBackgroundedAt = useRef<DateTime?>(null);

    useEffect(() {
      if (lifecycleState == AppLifecycleState.paused || lifecycleState == AppLifecycleState.hidden) {
        lastBackgroundedAt.value = DateTime.now();
      } else if (lifecycleState == AppLifecycleState.resumed) {
        if (lastBackgroundedAt.value != null) {
          final elapsed = DateTime.now().difference(lastBackgroundedAt.value!);
          final isSuppressed = ref.read(appLockSuppressionProvider);
          if (!isSuppressed && elapsed >= const Duration(minutes: 1)) {
            ref.read(appLockControllerProvider.notifier).lock();
          }
          lastBackgroundedAt.value = null;
        }
      }
      return null;
    }, [lifecycleState]);

    var themeMode = ThemeMode.system;
    switch (settingsState.settings?.themeMode) {
      case 'light':
        themeMode = ThemeMode.light;
      case 'dark':
        themeMode = ThemeMode.dark;
    }

    // Sync language state to LocaleSettings and Intl
    final lang = settingsState.settings?.language;
    useEffect(() {
      if (lang != null) {
        if (lang == 'system') {
          LocaleSettings.useDeviceLocale().then((locale) {
            Intl.defaultLocale = locale.languageCode;
          });
        } else {
          LocaleSettings.setLocaleRaw(lang).then((locale) {
            Intl.defaultLocale = locale.languageCode;
          });
        }
      }
      Intl.defaultLocale = LocaleSettings.currentLocale.languageCode;
      return null;
    }, [lang]);

    useEffect(() {
      // Run debt alerts check on startup
      ref.read(debtAlertServiceProvider).checkAlerts();

      // Check periodic backup reminder
      ref.read(backupReminderServiceProvider).checkAndNotify();

      // Clean up stale temporary exports
      ref.read(excelExportServiceProvider).cleanupOldExports();

      // Initialize quick actions
      QuickActionsService.instance.initialize();

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
