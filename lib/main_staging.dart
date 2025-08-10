import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:mvvm_template_with_flutter/config/dependencies.dart';
import 'package:mvvm_template_with_flutter/main.dart';
import 'package:provider/provider.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((log) {
    if (kDebugMode) {
      print('[${log.level}] - [${log.loggerName}] - [${log.message}]');
      if (log.stackTrace != null) print(log.stackTrace);
    }
  });

  runApp(MultiProvider(providers: providersRemote, child: const MyApp()));
}
