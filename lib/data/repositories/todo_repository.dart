import 'package:mvvm_template_with_flutter/utils/result/result.dart';
import 'package:mvvm_template_with_flutter/domain/models/todo.dart';

abstract class TodoRepository {
  Future<Result<List<Todo>>> get();

  Future<Result<Todo>> add({
    required String name,
    required String description,
    required bool done,
  });

  Future<Result<void>> delete(Todo todo);

  Future<Result<Todo>> getById(String id);

  Future<Result<Todo>> update(Todo todo);
}
