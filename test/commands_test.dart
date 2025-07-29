import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_template_with_flutter/core/commands/commands.dart';
import 'package:mvvm_template_with_flutter/core/result/result.dart';

void main() {
  group('Should test Commands', () {
    test('Should test Command0 returns Ok', () async {
      final command0 = Command0<String>(getOkResult);

      expect(command0.running, false);

      expect(command0.completed, false);

      expect(command0.error, false);

      expect(command0.result, isNull);

      await command0.execute();

      expect(command0.running, false);

      expect(command0.completed, true);

      expect(command0.error, false);

      expect(command0.result, isNotNull);

      expect(command0.result!.asOk.value, 'Task has Success');
    });

    test('Should test Command0 returns Error', () async {
      final command0 = Command0<bool>(getErrorResult);

      expect(command0.running, false);

      expect(command0.completed, false);

      expect(command0.error, false);

      expect(command0.result, isNull);

      await command0.execute();

      expect(command0.error, true);

      expect(command0.running, false);

      expect(command0.result, isNotNull);

      expect(command0.completed, false);

      expect(command0.result!.asError.error, isA<Exception>());
    });

    test('Should test Command1 returns Ok with params', () async {
      final command1 = Command1<String, String>(getOkResultWithParams);

      expect(command1.running, false);

      expect(command1.completed, false);

      expect(command1.error, false);

      expect(command1.result, isNull);

      await command1.execute('Entry Params');

      expect(command1.running, false);

      expect(command1.completed, true);

      expect(command1.error, false);

      expect(command1.result, isNotNull);

      expect(command1.result!.asOk.value, 'Task has Success with params: Entry Params');
    });

    test('Should test Command1 returns Error with params', () async {
      final command1 = Command1<bool, String>(getErrorResultWithParams);

      expect(command1.running, false);

      expect(command1.completed, false);

      expect(command1.error, false);

      expect(command1.result, isNull);

      await command1.execute('Entry Params');

      expect(command1.running, false);

      expect(command1.completed, false);

      expect(command1.error, true);

      expect(command1.result, isNotNull);

      expect(command1.result!.asError.error, isA<Exception>());
    });
  });
}

Future<Result<String>> getOkResult() async {
  await Future.delayed(Duration(milliseconds: 500));
  return Result.ok('Task has Success');
}

Future<Result<bool>> getErrorResult() async {
  await Future.delayed(Duration(milliseconds: 500));
  return Result.error(Exception('Task has Error'));
}

Future<Result<String>> getOkResultWithParams(String params) async {
  await Future.delayed(Duration(milliseconds: 500));
  return Result.ok('Task has Success with params: $params');
}

Future<Result<bool>> getErrorResultWithParams(String params) async {
  await Future.delayed(Duration(milliseconds: 500));
  return Result.error(Exception('Task has Error with params: $params'));
}
