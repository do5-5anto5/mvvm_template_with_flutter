import 'main_staging.dart' as staging;
// import 'main_dev.dart' as dev;

import 'package:flutter/material.dart';
import 'package:mvvm_template_with_flutter/route/router.dart';

void main() => staging.main();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MVVM',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
      routerConfig: routesConfig(),
    );
  }
}
