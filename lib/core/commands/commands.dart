import 'package:mvvm_template_with_flutter/core/result/result.dart';

// Command0 não exige parametros de entrada
typedef Command0<Output extends Object> = Future<Result<Output>> Function();

// Command1 exige um parametro de entrada
typedef Command1<Output extends Object, Input extends Object> =
    Future<Result<Output>> Function(Input);

abstract class Command<Output extends Object> {
  /// Verifies if command is executing
  bool _running = false;

  bool get running => _running;

  /// ver
  Result<Output>? _result;

  Result<Output>? get result => _result;

  bool get completed => _result is Ok;

  bool get error => _result is Error;
}