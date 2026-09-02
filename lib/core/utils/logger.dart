import 'dart:ui';

import 'package:poka_ce/theme/tailwind.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Helper to convert Flutter [Color] to [AnsiPen] for console logging
AnsiPen _penFromColor(Color color) {
  return AnsiPen()..rgb(r: color.r, g: color.g, b: color.b);
}

/// Global singleton instance of Talker for logging.
/// Use `talker.info`, `talker.error`, `talker.handle`, etc.
final Talker talker = TalkerFlutter.init(
  settings: TalkerSettings(),
  logger: TalkerLogger(
    settings: TalkerLoggerSettings(
      colors: {
        LogLevel.critical: _penFromColor(TWind.red600),
        LogLevel.error: _penFromColor(TWind.red500),
        LogLevel.warning: _penFromColor(TWind.amber500),
        LogLevel.info: _penFromColor(TWind.blue500),
        LogLevel.debug: _penFromColor(TWind.slate400),
        LogLevel.verbose: _penFromColor(TWind.slate500),
      },
    ),
  ),
);
