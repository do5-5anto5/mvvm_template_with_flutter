import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_template_with_flutter/utils/result/result.dart';


void main() {
  group('Should test Result', () {
    test('Shoud create an Ok Result', () {
      //arrange
      final result = Result.ok('Ok');

      //assert
      expect((result as Ok).value, 'Ok');
    });

    test('Should create an error Result', () {
      //arrange
      final error = Exception('Ocorreu um erro...');
      final result = Result.error(error);

      //assert
      expect((result as Error).error, error);

    });

    test('Should create an Ok result with extension', () {
      //arrange
      final result = "Ok".ok();

      //assert
      expect(result.asOk.value, 'Ok');
    } );

    test('Should creat an Error result with extension', () {
      //arrange
      final result =  Exception('Ocorreu um erro...').error();

      //assert
      expect(result.asError.error, isA<Exception>());
    });
  });
}