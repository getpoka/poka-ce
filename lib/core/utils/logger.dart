import 'package:talker_flutter/talker_flutter.dart';

/// Global singleton instance of Talker for logging.
/// Use `talker.info`, `talker.error`, `talker.handle`, etc.
final Talker talker = TalkerFlutter.init(
  settings: TalkerSettings(),
);
