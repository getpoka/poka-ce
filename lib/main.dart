import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/app.dart';
import 'package:poka_ce/core/logger/poka_logger.dart';
import 'package:poka_ce/core/logger/talker_riverpod_observer.dart';
import 'package:poka_ce/core/services/notification_service.dart';
import 'package:poka_ce/core/services/preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  // Setup Talker error handling
  FlutterError.onError = (details) => talker.handle(details.exception, details.stack);
  PlatformDispatcher.instance.onError = (error, stack) {
    talker.handle(error, stack);
    return true;
  };

  final sharedPrefs = await SharedPreferences.getInstance();
  await notificationService.init();

  if (kDebugMode) {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  }

  runApp(
    ProviderScope(
      observers: [TalkerRiverpodObserver()],
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPrefs),
      ],
      child: const PokaApp(),
    ),
  );
}
