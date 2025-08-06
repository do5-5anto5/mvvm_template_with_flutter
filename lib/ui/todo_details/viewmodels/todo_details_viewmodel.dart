import 'package:flutter/material.dart';
import 'package:mvvm_template_with_flutter/data/repositories/todo_repository.dart';
import 'package:mvvm_template_with_flutter/domain/models/todo.dart';
import 'package:mvvm_template_with_flutter/utils/commands/commands.dart';
import 'package:mvvm_template_with_flutter/utils/result/result.dart';

class TodoDetailsViewmodel extends ChangeNotifier {
  final TodoRepository _todoRepository;

  TodoDetailsViewmodel({required TodoRepository todoRepository})
    : _todoRepository = todoRepository {
    load = Command1(_load);
  }

  late Todo _todo;
  Todo get todo => _todo;

  late final Command1<Todo, String> load;

  Future<Result<Todo>> _load(String id) async {
    try {
      final result = await _todoRepository.getById(id);

      switch (result) {
        case Ok<Todo>():
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
