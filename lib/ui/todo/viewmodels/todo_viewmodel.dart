import 'package:flutter/widgets.dart';
import 'package:mvvm_template_with_flutter/core/commands/commands.dart';
import 'package:mvvm_template_with_flutter/core/result/result.dart';
import 'package:mvvm_template_with_flutter/domain/models/todo.dart';

class TodoViewmodel extends ChangeNotifier {
  TodoViewmodel() {
    load = Command0(_load)..execute();
    addTodo = Command1<Todo, String>(_addTodo);
    deleteTodo = Command1<String, Todo>(_removeTodo);
  }

  late Command0 load;
  late Command1 addTodo;
  late Command1 deleteTodo;

  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<Result> _load() async {
    await Future.delayed(Duration(seconds: 2));
    final List<Todo> todos = [];
    _todos = todos;
    notifyListeners();

    return Result.ok(todos);
  }

  Future<Result<Todo>> _addTodo(String name) async {
    final lastIndex = _todos.length;
    await Future.delayed(const Duration(seconds: 1));
    final newTodo = Todo(id: '${lastIndex + 1}', name: name);
    _todos.add(newTodo);
    notifyListeners();
    
    return Result.ok(newTodo);
  }

  Future<Result<String>> _removeTodo(Todo todo) async {
    await Future.delayed(Duration(seconds: 2));
    _todos.removeWhere((t) => t.id == todo.id);
    notifyListeners();
    
    return Result.ok('Deleted.');
  }
}
