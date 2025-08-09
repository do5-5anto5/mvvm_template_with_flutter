import 'package:flutter/widgets.dart';
import 'package:mvvm_template_with_flutter/data/repositories/todo_repository.dart';
import 'package:mvvm_template_with_flutter/data/services/api/api_client.dart';
import 'package:mvvm_template_with_flutter/data/services/api/models/todo/todo_api_model.dart';
import 'package:mvvm_template_with_flutter/domain/models/todo.dart';
import 'package:mvvm_template_with_flutter/utils/result/result.dart';

class TodoRepositoryRemote extends ChangeNotifier implements TodoRepository {
  TodoRepositoryRemote({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  List<Todo> _todos = [];

  final Map<String, Todo> _cachedTodos = {};

  @override
  List<Todo> get todos => _todos;

  @override
  Future<Result<Todo>> add({
    required String name,
    required String description,
    required bool done,
  }) async {
    try {
      final result = await _apiClient.postTodo(
        CreateTodoApiModel(name: name, description: description, done: done),
      );

      switch (result) {
        case Ok<Todo>():
          _cachedTodos[result.value.id!] = result.value;
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<void>> delete(Todo todo) async {
    try {
      final result = await _apiClient.delete(todo);

      switch (result) {
        case Ok<void>():
          _cachedTodos.remove(todo.id);
          return Result.ok(null);
        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<List<Todo>>> get() async {
    try {
      final result = await _apiClient.getTodos();

      switch (result) {
        case Ok<List<Todo>>():
          _todos = result.value;
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<Todo>> getById(String id) async {
    if (_cachedTodos[id] != null) {
      return Result.ok(_cachedTodos[id]!);
    }

    try {
      final result = await _apiClient.getById(id);
      switch (result) {
        case Ok<Todo>():
          _cachedTodos[id] = result.value;
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<Todo>> update(Todo todo) async {
    try {
      final result = await _apiClient.updateTodo(
        UpdateTodoApiModel(
          id: todo.id!,
          name: todo.name,
          description: todo.description,
          done: todo.done,
        ),
      );

      switch (result) {
        case Ok<Todo>():
          final todoIndex = _todos.indexWhere((e) => e.id == todo.id);
          _todos[todoIndex] = result.value;
          _cachedTodos[todo.id!] = result.value;
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }
}
