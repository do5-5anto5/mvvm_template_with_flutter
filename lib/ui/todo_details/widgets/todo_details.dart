import 'package:flutter/material.dart';
import 'package:mvvm_template_with_flutter/ui/todo_details/viewmodels/todo_details_viewmodel.dart';

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
        builder: (context, child) {
          if (widget.todoDetailsViewmodel.load.running) {
            return const Center(child: CircularProgressIndicator());
          }
          if (widget.todoDetailsViewmodel.load.error) {
            return const Center(
              child: Text('Ocorreu um erro ao carregar detalhes da tarefa'),
            );
          }
          return child!;
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.blue
            ),
            child: Text(widget.todoDetailsViewmodel.todo.name, style: const TextStyle(
              color: Colors.white
            )),
          ),
        ),
      ),
    );
  }
}
