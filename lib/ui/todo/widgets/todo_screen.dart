import 'package:flutter/material.dart';
import 'package:mvvm_template_with_flutter/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:mvvm_template_with_flutter/ui/todo/widgets/todos_list.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key, required this.todoViewmodel});
  final TodoViewmodel todoViewmodel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos Screen')),
      body: ListenableBuilder(
        listenable: todoViewmodel.load,
        builder: (context, child) {
          if (todoViewmodel.load.running) {
            return const Center(child: CircularProgressIndicator());
          }

          if (todoViewmodel.load.error) {
            return const Center(child: Text('Erro ao carregar todos...'));
          }

          return child!;
        },
        child: ListenableBuilder(
          listenable: todoViewmodel,
          builder: (context, child) {
            return TodosList(todos: todoViewmodel.todos);
          },
        ),
      ),
    );
  }
}
