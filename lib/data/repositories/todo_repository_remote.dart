import 'package:mvvm_template_with_flutter/data/repositories/todo_repository.dart';
import 'package:mvvm_template_with_flutter/data/services/api/api_client.dart';
import 'package:mvvm_template_with_flutter/data/services/api/models/todo/todo_api_model.dart';
import 'package:mvvm_template_with_flutter/domain/models/todo.dart';
import 'package:mvvm_template_with_flutter/utils/result/result.dart';

class TodoRepositoryRemote implements TodoRepository {
  const TodoRepositoryRemote({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<Result<Todo>> add({
    required String name,
    required String description,
    required bool done,
  }) async {
    try {
      final result = await _apiClient.postTodo(CreateTodoApiModel(name: name));

      switch (result) {
        case Ok<Todo>():
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<void>> delete(Todo todo) async {
    try {
      final result = await _apiClient.delete(todo);

      switch (result) {
        case Ok<void>():
          return Result.ok(null);
        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<List<Todo>>> get() async {
    try {
      final result = await _apiClient.getTodos();

      switch (result) {
        case Ok<List<Todo>>():
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<Todo>> getById(String id) async {
    try {
      final result = await _apiClient.getById(id);
      switch (result) {
        case Ok<Todo>():
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
