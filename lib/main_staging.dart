import 'package:flutter/material.dart';
import 'package:mvvm_template_with_flutter/config/dependencies.dart';
import 'package:mvvm_template_with_flutter/main.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(providers: providersRemote, child: const MyApp(),));
