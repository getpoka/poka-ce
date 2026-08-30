// We use SharePlus inside the function but the package structure causes this lint
// ignore_for_file: deprecated_member_use
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:poka_ce/core/logger/poka_logger.dart';
import 'package:share_plus/share_plus.dart';

class LogExporter {
  static Future<void> exportLogs() async {
    final directory = await getApplicationSupportDirectory();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final file = File('${directory.path}/poka-$timestamp.txt');

    final logs = talker.history.map((e) => e.generateTextMessage()).join('\n');
    await file.writeAsString(logs);

    await Share.shareXFiles([XFile(file.path)], text: 'Poka CE Debug Logs');
  }
}
