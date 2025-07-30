import 'package:flutter/material.dart';
import 'package:mvvm_template_with_flutter/domain/models/todo.dart';
import 'package:mvvm_template_with_flutter/ui/todo/widgets/todo_tile.dart';

class TodosList extends StatelessWidget {
  const TodosList({super.key, required this.todos});
  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(child: Text('Nenhuma tarefa por enquanto'));
    }
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return TodoTile(todo: todos[index]);
      },
    );
  }
}
