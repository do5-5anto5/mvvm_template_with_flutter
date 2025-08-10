import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:mvvm_template_with_flutter/data/repositories/todo_repository.dart';
import 'package:mvvm_template_with_flutter/domain/models/todo.dart';
import 'package:mvvm_template_with_flutter/domain/use_cases/todo_update_use_case.dart';
import 'package:mvvm_template_with_flutter/utils/commands/commands.dart';
import 'package:mvvm_template_with_flutter/utils/result/result.dart';

class TodoDetailsViewmodel extends ChangeNotifier {
  final TodoRepository _todoRepository;
  final TodoUpdateUseCase _todoUpdateUseCase;

  TodoDetailsViewmodel({
    required TodoRepository todoRepository,
    required TodoUpdateUseCase todoUpdateUseCase,
  }) : _todoRepository = todoRepository,
       _todoUpdateUseCase = todoUpdateUseCase {
    load = Command1(_load);
    updateTodo = Command1(_todoUpdateUseCase.updateTodo);
    _todoRepository.addListener(() {
      load.execute(_todo.id!);
    });
  }

  late final Command1<Todo, String> load;

  late final Command1<Todo, Todo> updateTodo;

  late Todo _todo;
  Todo get todo => _todo;

  final _log = Logger('TodoDetailsViewmodel');

  Future<Result<Todo>> _load(String id) async {
    try {
      final result = await _todoRepository.getById(id);

      switch (result) {
        case Ok<Todo>():
          _todo = result.value;
          _log.fine('Tarefa carregada.');
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
