import 'package:flutter/material.dart';
import 'package:mvvm_template_with_flutter/data/repositories/todo_repository_dev.dart';
import 'package:mvvm_template_with_flutter/domain/use_cases/todo_update_use_case.dart';
import 'package:mvvm_template_with_flutter/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:mvvm_template_with_flutter/ui/todo/widgets/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final todoRepositoryDev = TodoRepositoryDev();
    final todoUpdateUseCase = TodoUpdateUseCase(
      todoRepository: todoRepositoryDev,
    );

    return MaterialApp(
      title: 'MVVM',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
      home: TodoScreen(
        todoViewmodel: TodoViewmodel(
          todoRepository: todoRepositoryDev,
          todoUpdateUsecase: todoUpdateUseCase
        ),
      ),
    );
  }
}
