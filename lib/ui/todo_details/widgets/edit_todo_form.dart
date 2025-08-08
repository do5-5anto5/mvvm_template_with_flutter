import 'package:flutter/material.dart';

class EditTodoForm extends StatefulWidget {
  const EditTodoForm({super.key});

  @override
  State<EditTodoForm> createState() => _EditTodoFormState();
}

class _EditTodoFormState extends State<EditTodoForm> {
  late final _nameController = TextEditingController();
  late final _descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _verticalGap = const SizedBox(height: 8);

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
                if (_formKey.currentState?.validate() == true) {}
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
