import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_template_with_flutter/data/services/api/api_client.dart';
import 'package:mvvm_template_with_flutter/data/services/api/models/todo/todo_api_model.dart';
import 'package:mvvm_template_with_flutter/domain/models/todo.dart';
import 'package:mvvm_template_with_flutter/utils/result/result.dart';

void main() {
  group('[ApiClient]', () {
    late ApiClient apiClient;

    setUp(() {
      apiClient = ApiClient();
    });
    test('should return Ok when getTodos()', () async {
      final result = await apiClient.getTodos();

      expect(result.asOk.value, isA<List<Todo>>());
    });

    test('should return Ok when postTodo()', () async {
      const CreateTodoApiModel todoToCreate = CreateTodoApiModel(
        name: 'Todo created on Test',
      );
      final result = await apiClient.postTodo(todoToCreate);

      expect(result.asOk.value, isA<Todo>());
      expect(result.asOk.value.id, isNotNull);
      expect(result.asOk.value.name, 'Todo created on Test');
    });

    test('should return Ok when deleteTodo()', () async {
      const CreateTodoApiModel todoToCreate = CreateTodoApiModel(
        name: 'Todo created on Test',
      );

      final createTodoResult = await apiClient.postTodo(todoToCreate);

      final result = await apiClient.delete(createTodoResult.asOk.value);

      expect(result.asOk, isA<Result<void>>());
    });

    test('should return Ok when updateTodo()', () async {
      const CreateTodoApiModel todoToCreate = CreateTodoApiModel(
        name: 'Todo created on Test',
      );

      final createTodoResult = await apiClient.postTodo(todoToCreate);

      final result = await apiClient.updateTodo(
        UpdateTodoApiModel(
          id: createTodoResult.asOk.value.id!,
          name: '${createTodoResult.asOk.value.id} updated at ${DateTime.now().toIso8601String()}',
        ),
      );

      expect(result, isA<Result<Todo>>());
    });
  });
}
