import 'package:flutter/material.dart';
import 'package:mvvm_template_with_flutter/ui/todo/viewmodels/todo_viewmodel.dart';

class AddTodoForm extends StatefulWidget {
  const AddTodoForm({super.key, required this.todoViewmodel});
  final TodoViewmodel todoViewmodel;

  @override
  State<AddTodoForm> createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController descriptionController =
      TextEditingController();

  final vertigalGap = const SizedBox(height: 16);

  @override
  void initState() {
    widget.todoViewmodel.addTodo.addListener(_onResult);
    super.initState();
  }

  void _onResult() {
    if (widget.todoViewmodel.addTodo.running) {
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
      if (widget.todoViewmodel.addTodo.completed) {
        Navigator.of(context).pop(); // pop CircularProgressIndicator
        Navigator.of(context).pop(); // pop AlertDialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
            content: Text('Tarefa criada com sucesso!'),
          ),
        );
      }

      if (widget.todoViewmodel.addTodo.error) {
        Navigator.of(context).pop(); // pop CircularProgressIndicator
        Navigator.of(context).pop(); // pop AlertDialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
            content: Text('Erro ao criar tarefa.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar tarefa'),
      content: IntrinsicHeight(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nome da tarefa',
                ),
                validator: (value) {
                  if (value == null || value.trim() == '') {
                    return 'Informe o nome da tarefa';
                  }
                  return null;
                },
              ),
              vertigalGap,
              Expanded(
                child: TextFormField(
                  minLines: 3,
                  maxLines: null,
                  controller: descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Descrição',
                  ),
                ),
              ),
              vertigalGap,
              ElevatedButton(
                onPressed: () {
                  widget.todoViewmodel.addTodo.execute((
                    nameController.text,
                    descriptionController.text,
                    false,
                  ));
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    widget.todoViewmodel.addTodo.removeListener(_onResult);
    super.dispose();
  }
}
