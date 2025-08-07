import 'package:flutter/widgets.dart';
import 'package:mvvm_template_with_flutter/utils/commands/commands.dart';
import 'package:mvvm_template_with_flutter/utils/result/result.dart';
import 'package:mvvm_template_with_flutter/data/repositories/todo_repository.dart';
import 'package:mvvm_template_with_flutter/domain/models/todo.dart';

class TodoViewmodel extends ChangeNotifier {
  TodoViewmodel({required TodoRepository todoRepository})
    : _todoRepository = todoRepository {
    load = Command0(_load)..execute();
    addTodo = Command1(_addTodo);
    deleteTodo = Command1(_deleteTodo);
    updateTodo = Command1(_updateTodo);
  }

  final TodoRepository _todoRepository;

  late Command0 load;
  late Command1<Todo, (String, String, bool)> addTodo;
  late Command1<void, Todo> deleteTodo;
  late Command1<Todo, Todo> updateTodo;

  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<Result> _load() async {
    final result = await _todoRepository.get();

    switch (result) {
      case Ok<List<Todo>>():
        _todos = result.value;
        notifyListeners();
        break;
      case Error():
        //TODO: implement Logging
        break;
    }

    return result;
  }

  Future<Result<Todo>> _addTodo((String, String, bool) todo) async {
    final (name, description, done) = todo;

    final result = await _todoRepository.add(
      name: name,
      description: description,
      done: done,
    );

    switch (result) {
      case Ok<Todo>():
        print('OK');

        // ATENÇÃO: No ambiente dev, o TodoRepositoryDev já adiciona o item à sua lista interna.
        // Não adicionar manualmente ao _todos para evitar duplicação.
        _todos.add(result.value);
        notifyListeners();
        break;
      case Error():
      //TODO: implement LOGGING
      default:
    }
    return result;
  }

  Future<Result<void>> _deleteTodo(Todo todo) async {
    final result = await _todoRepository.delete(todo);

    switch (result) {
      case Ok<void>():
        _todos.remove(todo);
        notifyListeners();
        break;
      case Error():
        //TODO: implement Logging
        break;
    }

    return result;
  }

  Future<Result<Todo>> _updateTodo(Todo todo) async {
    final result = await _todoRepository.update(todo);

    switch (result) {
      case Ok<Todo>():
        final todoIndex = _todos.indexWhere((e) => e.id == todo.id);
        _todos[todoIndex] = todo;

        notifyListeners();
        return Result.ok(result.value);
      case Error():
        //TODO: implement Logging
        break;
      default:
        return result;
    }

    return result;
  }
}
