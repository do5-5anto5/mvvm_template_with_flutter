import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_template_with_flutter/data/repositories/todo_repository.dart';
import 'package:mvvm_template_with_flutter/data/repositories/todo_repository_dev.dart';
import 'package:mvvm_template_with_flutter/ui/todo/viewmodels/todo_viewmodel.dart';

void main() {
  late TodoViewmodel todoViewModel;
  late TodoRepository todoRepository;
  setUp(() {
    todoRepository = TodoRepositoryDev();
    todoViewModel = TodoViewmodel(todoRepository: todoRepository);
  });

  group('Should test TodoViewmodel', () {
    test('Verify TodoViewmodel initial state', () {

      expect(todoViewModel.todos, isEmpty);
    });

    test('Add todo', () async {

      expect(todoViewModel.todos, isEmpty);

      await todoViewModel.addTodo.execute('Todo 1');

      expect(todoViewModel.todos, isNotEmpty);
      expect(todoViewModel.todos.length, 1);
      expect(todoViewModel.todos.first.name, contains('Todo 1'));
      expect(todoViewModel.todos.first.id, '${todoViewModel.todos.length}');
    });

    test('Remove todo', () async {

      expect(todoViewModel.todos, isEmpty);

      await todoViewModel.addTodo.execute('Todo 1');

      expect(todoViewModel.todos, isNotEmpty);
      expect(todoViewModel.todos.length, 1);
      expect(todoViewModel.todos.first.name, contains('Todo 1'));
      expect(todoViewModel.todos.first.id, '${todoViewModel.todos.length}');

      await todoViewModel.deleteTodo.execute(todoViewModel.todos.first);

      expect(todoViewModel.todos, isEmpty);
    });
  });
}
