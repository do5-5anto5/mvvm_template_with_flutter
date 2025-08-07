import 'package:flutter/material.dart';
import 'package:mvvm_template_with_flutter/ui/todo_details/viewmodels/todo_details_viewmodel.dart';
import 'package:mvvm_template_with_flutter/ui/todo_details/widgets/todo_description.dart';
import 'package:mvvm_template_with_flutter/ui/todo_details/widgets/todo_name.dart';

class TodoDetailsScreen extends StatefulWidget {
  const TodoDetailsScreen({super.key, required this.todoDetailsViewmodel});

  final TodoDetailsViewmodel todoDetailsViewmodel;

  @override
  State<TodoDetailsScreen> createState() => _TodoDetailsScreenState();
}

class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Listando detalhes do Todo')),
      body: ListenableBuilder(
        listenable: widget.todoDetailsViewmodel.load,
        builder: (context, _) {
          if (widget.todoDetailsViewmodel.load.running) {
            return const Center(child: CircularProgressIndicator());
          }
          if (widget.todoDetailsViewmodel.load.error) {
            return const Center(
              child: Text('Ocorreu um erro ao carregar detalhes da tarefa'),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TodoName(todo: widget.todoDetailsViewmodel.todo),
                SizedBox(height: 8),
                if (widget.todoDetailsViewmodel.todo.description != "")
                  TodoDescription(todo: widget.todoDetailsViewmodel.todo),
              ],
            ),
          );
        },
      ),
    );
  }
}
