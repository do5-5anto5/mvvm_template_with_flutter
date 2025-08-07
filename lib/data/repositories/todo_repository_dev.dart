import 'package:mvvm_template_with_flutter/utils/result/result.dart';
import 'package:mvvm_template_with_flutter/data/repositories/todo_repository.dart';
import 'package:mvvm_template_with_flutter/domain/models/todo.dart';

class TodoRepositoryDev extends TodoRepository {
  final List<Todo> _todos = [];

  @override
  Future<Result<Todo>> add({
    required String name,
    required String description,
    required bool done,
  }) async {
    final lastIndex = _todos.length;

    final createdTodo = Todo(
      id: '${lastIndex + 1}',
      name: name,
      description: description,
      done: done,
    );

    _todos.add(createdTodo);

    return Result.ok(createdTodo);
  }

  @override
  Future<Result<void>> delete(Todo todo) async {
    if (_todos.contains(todo)) {
      _todos.remove(todo);
    }

    return Result.ok(null);
  }

  @override
  Future<Result<List<Todo>>> get() async {
    return Result.ok(_todos);
  }

  @override
  Future<Result<Todo>> getById(String id) async {
    return Result.ok(_todos.where((e) => e.id == id).first);
  }
}
