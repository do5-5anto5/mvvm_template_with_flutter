import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:mvvm_template_with_flutter/data/repositories/todo_repository_remote.dart';
import 'package:mvvm_template_with_flutter/domain/use_cases/todo_update_use_case.dart';
import 'package:mvvm_template_with_flutter/utils/commands/commands.dart';
import 'package:mvvm_template_with_flutter/utils/result/result.dart';
import 'package:mvvm_template_with_flutter/data/repositories/todo_repository.dart';
import 'package:mvvm_template_with_flutter/domain/models/todo.dart';

class TodoViewmodel extends ChangeNotifier {
  TodoViewmodel({
    required TodoRepository todoRepository,
    required TodoUpdateUseCase todoUpdateUsecase,
  }) : _todoRepository = todoRepository,
       _todoUpdateUseCase = todoUpdateUsecase {
    load = Command0(_load)..execute();
    addTodo = Command1(_addTodo);
    deleteTodo = Command1(_deleteTodo);
    updateTodo = Command1((todo) => _todoUpdateUseCase.updateTodo(todo));
    _todoRepository.addListener(() {
      _todos = todoRepository.todos;
      notifyListeners();
    });
  }

  final TodoRepository _todoRepository;

  final TodoUpdateUseCase _todoUpdateUseCase;

  late Command0 load;
  late Command1<Todo, (String, String, bool)> addTodo;
  late Command1<void, Todo> deleteTodo;
  late Command1<Todo, Todo> updateTodo;

  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  final _log = Logger("TodoViewmodel");

  Future<Result> _load() async {
    try {
      final result = await _todoRepository.get();

      switch (result) {
        case Ok<List<Todo>>():
          _todos = result.value;
          _log.fine('Tarefas carregadas');
          break;
        case Error():
          _log.warning('Falha ao carregar tarefas', result.error);
          break;
      }

      return result;
    } on Exception catch (error, stackTrace) {
      _log.warning('Falha ao carregar tarefas', error, stackTrace);
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  Future<Result<Todo>> _addTodo((String, String, bool) todo) async {
    try {
      final (name, description, done) = todo;

      final result = await _todoRepository.add(
        name: name,
        description: description,
        done: done,
      );

      switch (result) {
        case Ok<Todo>():
          if (_todoRepository is TodoRepositoryRemote) {
            _todos.add(result.value);
          }
          _log.fine('Adição de Tarefa concluída.');
          _load();
        case Error():
          _log.warning('Falha ao adicionar Tarefa', result.error);
        default:
      }
      return result;
    } on Exception catch (error, stackTrace) {
      _log.warning('Falha adicionar Tarefa', error, stackTrace);
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _deleteTodo(Todo todo) async {
    try {
      final result = await _todoRepository.delete(todo);

      switch (result) {
        case Ok<void>():
          _todos.remove(todo);
          _log.fine('Tarefa removida');
          break;
        case Error():
          _log.warning('Falha ao deletar Tarefa', result.error);
          break;
      }

      return result;
    } on Exception catch (error, stackTrace) {
      _log.warning('Falha deletar Tarefa', error, stackTrace);
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }
}
