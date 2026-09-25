import 'dart:ui';

import 'package:poka_ce/theme/theme.dart';
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
        LogLevel.critical: _penFromColor(PokaColors.red600),
        LogLevel.error: _penFromColor(PokaColors.rose500),
        LogLevel.warning: _penFromColor(PokaColors.amber500),
        LogLevel.info: _penFromColor(PokaColors.brand500),
        LogLevel.debug: _penFromColor(PokaColors.darkMutedForeground),
        LogLevel.verbose: _penFromColor(PokaColors.lightMutedForeground),
      },
    ),
  ),
);
