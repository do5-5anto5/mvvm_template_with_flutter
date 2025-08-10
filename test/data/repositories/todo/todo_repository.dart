import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mvvm_template_with_flutter/data/repositories/todo_repository_remote.dart';
import 'package:mvvm_template_with_flutter/data/services/api/api_client.dart';
import 'package:mvvm_template_with_flutter/domain/models/todo.dart';
import 'package:mvvm_template_with_flutter/utils/result/result.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late TodoRepositoryRemote todoRepositoryRemote;
  late ApiClient apiClient;

  setUp(() {
    apiClient = MockApiClient();
    todoRepositoryRemote = TodoRepositoryRemote(apiClient: apiClient);
  });
  test('Should get a todo by id', () async {
    when(() => apiClient.getById((any()))).thenAnswer(
      (invocation) => Future.value(
        Result.ok(
          Todo(
            id: '1',
            name: 'Primeiro',
            description: 'Descrição',
            done: false,
          ),
        ),
      ),
    );

    final result = await todoRepositoryRemote.getById('1');

    expect(result, isA<Ok<Todo>>());

    expect(result.asOk.value.name, 'Primeiro');
    expect(result.asOk.value.description, 'Descrição');
    expect(result.asOk.value.done, false);
  });
}
