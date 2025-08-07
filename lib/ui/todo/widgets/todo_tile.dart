import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvvm_template_with_flutter/domain/models/todo.dart';
import 'package:mvvm_template_with_flutter/route/routes.dart';
import 'package:mvvm_template_with_flutter/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:mvvm_template_with_flutter/utils/typedefs/delete_todo.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    required this.todo,
    required this.onDeleteTodo,
    required this.todoViewmodel,
  });
  final OnDeleteTodo onDeleteTodo;
  final Todo todo;
  final TodoViewmodel todoViewmodel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(Routes.todoDetails(todo.id!)),
      child: Card(
        child: ListTile(
          leading: Checkbox(
            value: todo.done,
            onChanged: (value) {
              print('🔲 Checkbox onChanged - value recebido: $value');
              print(
                '🔲 Todo atual antes da mudança: ${todo.name}, done: ${todo.done}',
              );

              final updatedTodo = todo.copyWith(done: value);
              print(
                '🔲 Todo após copyWith: ${updatedTodo.name}, done: ${updatedTodo.done}',
              );
              todoViewmodel.updateTodo.execute(updatedTodo);
            },
          ),
          title: Text(todo.name),
          trailing: IconButton(
            onPressed: () {
              onDeleteTodo(todo);
            },
            icon: Icon(Icons.delete),
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
