import 'package:flutter/material.dart';
import 'package:mvvm_template_with_flutter/domain/models/todo.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({super.key, required this.todo, required this.onDeleteTodo});
  final void Function(Todo todo) onDeleteTodo;
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(todo.id!),
      title: Text(todo.name),
      trailing: IconButton(
        onPressed: () {
          onDeleteTodo(todo);
        },
        icon: Icon(Icons.delete),
        color: Colors.red,
      ),
    );
  }
}
