import 'package:flutter/material.dart';
import 'package:mvvm_template_with_flutter/data/repositories/todo_repository.dart';
import 'package:mvvm_template_with_flutter/domain/models/todo.dart';
import 'package:mvvm_template_with_flutter/utils/result/result.dart';

class TodoRepositoryDev extends ChangeNotifier implements TodoRepository {
  final List<Todo> _todos = [];

  @override
  Future<Result<Todo>> add({
    required String name,
    required String description,
    required bool done,
  }) async {
    final lastIndex = _todos.length;

    try {
      final createdTodo = Todo(
        id: '${lastIndex + 1}',
        name: name,
        description: description,
        done: done,
      );

      _todos.add(createdTodo);

      return Result.ok(createdTodo);
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<void>> delete(Todo todo) async {
    try {
      if (_todos.contains(todo)) {
        _todos.remove(todo);
      }

      return Result.ok(null);
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<List<Todo>>> get() async {
    return Result.ok(_todos);
  }

  @override
  Future<Result<Todo>> getById(String id) async {
    return Result.ok(_todos.where((e) => e.id == id).first);
  }

  @override
  Future<Result<Todo>> update(Todo todo) async {
    try {
      final todoIndex = _todos.indexWhere((e) => e.id == todo.id);

      _todos[todoIndex] = todo;

      return Result.ok(todo);
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  @override
  List<Todo> get todos => _todos;
}
