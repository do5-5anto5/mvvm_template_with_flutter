import 'package:flutter/material.dart';
import 'package:mvvm_template_with_flutter/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:mvvm_template_with_flutter/ui/todo/widgets/add_todo_form.dart';
import 'package:mvvm_template_with_flutter/ui/todo/widgets/todos_list.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key, required this.todoViewmodel});
  final TodoViewmodel todoViewmodel;

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    widget.todoViewmodel.deleteTodo.addListener(_onResult);
    super.initState();
  }

  void _onResult() {
    if (widget.todoViewmodel.deleteTodo.running) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) => const AlertDialog(
          content: IntrinsicHeight(
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    } else {
      if (widget.todoViewmodel.deleteTodo.completed) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
            content: Text('Tarefa deletada.'),
          ),
        );
      }

      if (widget.todoViewmodel.deleteTodo.error) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
            content: Text('Erro ao deletar tarefa.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos Screen')),
      body: ListenableBuilder(
        listenable: widget.todoViewmodel.load,
        builder: (context, child) {
          if (widget.todoViewmodel.load.running) {
            return const Center(child: CircularProgressIndicator());
          }

          if (widget.todoViewmodel.load.error) {
            return const Center(child: Text('Erro ao carregar tarefas...'));
          }

          return child!;
        },
        child: ListenableBuilder(
          listenable: widget.todoViewmodel,
          builder: (context, child) {
            return TodosList(
              todos: widget.todoViewmodel.todos,
              onDeleteTodo: (todo) {
                widget.todoViewmodel.deleteTodo.execute(todo);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddTodoForm(todoViewmodel: widget.todoViewmodel);
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    widget.todoViewmodel.deleteTodo.removeListener(_onResult);
    super.dispose();
  }
}
