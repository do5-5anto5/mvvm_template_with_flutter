import 'package:mvvm_template_with_flutter/data/services/api/models/todo/todo_api_model.dart';

void main() {
  const TodoApiModel todoApiModel = TodoApiModel.create(name: 'test');
  print(todoApiModel.name);

  final copy = todoApiModel.copyWith(name: 'novo nome');
  print(copy.name);

  const updatedTodo = UpdateTodoApiModel(id: "test", name: 'updated name');
  print(updatedTodo.toJson());
}
