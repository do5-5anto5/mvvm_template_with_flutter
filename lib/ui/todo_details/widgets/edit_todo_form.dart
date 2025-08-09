import 'package:flutter/material.dart';
import 'package:mvvm_template_with_flutter/domain/models/todo.dart';
import 'package:mvvm_template_with_flutter/ui/todo_details/viewmodels/todo_details_viewmodel.dart';

class EditTodoForm extends StatefulWidget {
  const EditTodoForm({
    super.key,
    required this.todo,
    required this.todoDetailsViewmodel,
  });

  final Todo todo;
  final TodoDetailsViewmodel todoDetailsViewmodel;

  @override
  State<EditTodoForm> createState() => _EditTodoFormState();
}

class _EditTodoFormState extends State<EditTodoForm> {
  late final _nameController = TextEditingController(text: widget.todo.name);
  late final _descriptionController = TextEditingController(
    text: widget.todo.description,
  );

  final _formKey = GlobalKey<FormState>();

  final _verticalGap = const SizedBox(height: 8);

  @override
  void initState() {
    widget.todoDetailsViewmodel.updateTodo.addListener(_onUpdateTodo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text('Editando Tarefa'),

            _verticalGap,
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: "Nome",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == "") {
                  return "Preencha o campo de nome";
                }
                return null;
              },
            ),

            _verticalGap,
            Expanded(
              child: TextFormField(
                maxLines: null,
                minLines: 3,
                controller: _descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hint: Text('Descrição'),
                ),
              ),
            ),

            _verticalGap,
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() == true) {
                  widget.todoDetailsViewmodel.updateTodo.execute(
                    widget.todo.copyWith(
                      name: _nameController.text,
                      description: _descriptionController.text,
                    ),
                  );
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    widget.todoDetailsViewmodel.updateTodo.removeListener(_onUpdateTodo);
    super.dispose();
  }

  void _onUpdateTodo() {
    final command = widget.todoDetailsViewmodel.updateTodo;

    if (command.running) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: IntrinsicHeight(
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        },
      );
    } else {
      Navigator.of(context).pop();
      if (command.completed) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tarefa editada com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ocorreu um erro ao editar a Tarefa'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
