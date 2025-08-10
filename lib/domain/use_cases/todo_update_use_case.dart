import 'package:logging/logging.dart';
import 'package:mvvm_template_with_flutter/data/repositories/todo_repository.dart';
import 'package:mvvm_template_with_flutter/domain/models/todo.dart';
import 'package:mvvm_template_with_flutter/utils/result/result.dart';

class TodoUpdateUseCase {
  final TodoRepository _todoRepository;

  TodoUpdateUseCase({required todoRepository})
    : _todoRepository = todoRepository;

  final _log = Logger('TodoUpdateUseCase');

  Future<Result<Todo>> updateTodo(Todo todo) async {
    try {
      final result = await _todoRepository.update(todo);

      switch (result) {
        case Ok<Todo>():
          _log.fine('Tarefa editada');
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (error, stackTrace) {
      _log.warning('Falha ao editar Tarefa', error, stackTrace);
      return Result.error(error);
    }
  }
}
