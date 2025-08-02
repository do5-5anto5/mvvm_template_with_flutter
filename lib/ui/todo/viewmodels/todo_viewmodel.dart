import 'package:flutter/widgets.dart';
import 'package:mvvm_template_with_flutter/core/commands/commands.dart';
import 'package:mvvm_template_with_flutter/core/result/result.dart';
import 'package:mvvm_template_with_flutter/data/repositories/todo_repository.dart';
import 'package:mvvm_template_with_flutter/domain/models/todo.dart';

class TodoViewmodel extends ChangeNotifier {
  TodoViewmodel({required TodoRepository todoRepository})
    : _todoRepository = todoRepository {
    load = Command0(_load)..execute();
    addTodo = Command1<Todo, String>(_addTodo);
    deleteTodo = Command1<void, Todo>(_deleteTodo);
  }

  final TodoRepository _todoRepository;

  late Command0 load;
  late Command1 addTodo;
  late Command1 deleteTodo;

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

  Future<Result<Todo>> _addTodo(String name) async {
    final result = await _todoRepository.add(name);

    switch (result) {
      case Ok<Todo>():
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
        notifyListeners();
        await _load();
        break;
      case Error():
        //TODO: implement Logging
        break;
    }

    return result;
  }
}
