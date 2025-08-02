import 'package:mvvm_template_with_flutter/utils/result/result.dart';
import 'package:mvvm_template_with_flutter/domain/models/todo.dart';

abstract class TodoRepository {
  Future<Result<List<Todo>>> get();

  Future<Result<Todo>> add(String name);

  Future<Result<void>> delete(Todo todo);
}
