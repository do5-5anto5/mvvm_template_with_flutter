import 'package:flutter/material.dart';
import 'package:mvvm_template_with_flutter/core/result/result.dart';

// Command0 não exige parametros de entrada
typedef CommandAction0<Output extends Object> =
    Future<Result<Output>> Function();

// Command1 exige um parametro de entrada
typedef CommandAction1<Output extends Object, Input extends Object> =
    Future<Result<Output>> Function(Input);

abstract class Command<Output extends Object> extends ChangeNotifier {
  bool _running = false;

  bool get running => _running;

  Result<Output>? _result;

  Result<Output>? get result => _result;

  bool get completed => _result is Ok;

  bool get error => _result is Error;
}