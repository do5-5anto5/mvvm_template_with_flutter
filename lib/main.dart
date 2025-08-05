import 'package:flutter/material.dart';
import 'package:mvvm_template_with_flutter/route/router.dart';

void main() {
  runApp(const MyApp());
}

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
