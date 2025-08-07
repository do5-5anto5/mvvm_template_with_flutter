import 'package:flutter/material.dart';
import 'package:mvvm_template_with_flutter/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:mvvm_template_with_flutter/ui/todo/widgets/todo_tile.dart';
import 'package:mvvm_template_with_flutter/utils/typedefs/delete_todo.dart';

class TodosList extends StatelessWidget {
  const TodosList({
    super.key,
    required this.onDeleteTodo,
    required this.todoViewmodel,
  });
  final OnDeleteTodo onDeleteTodo;
  final TodoViewmodel todoViewmodel;

  @override
  Widget build(BuildContext context) {
    if (todoViewmodel.todos.isEmpty) {
      return const Center(child: Text('Nenhuma tarefa por enquanto'));
    }
    return ListView.builder(
      itemCount: todoViewmodel.todos.length,
      itemBuilder: (context, index) {
        return TodoTile(
          todo: todoViewmodel.todos[index],
          onDeleteTodo: onDeleteTodo,
          todoViewmodel: todoViewmodel,
        );
      },
    );
  }
}
