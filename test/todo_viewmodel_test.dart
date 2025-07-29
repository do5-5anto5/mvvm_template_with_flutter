import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_template_with_flutter/ui/todo/viewmodels/todo_viewmodel.dart';

void main() {
  group('Should test TodoViewmodel', () {
    test('Verify TodoViewmodel initial state', () {
      final todoViewModel = TodoViewmodel();

      expect(todoViewModel.todos, isEmpty);
    });

    test('Add todo', () async {
      final todoViewModel = TodoViewmodel();

      expect(todoViewModel.todos, isEmpty);

      await todoViewModel.addTodo.execute('Todo 1');

      expect(todoViewModel.todos, isNotEmpty);
      expect(todoViewModel.todos.length, 1);
      expect(todoViewModel.todos.first.name, contains('Todo 1'));
      expect(todoViewModel.todos.first.id, '${todoViewModel.todos.length}');
    });

    test('Remove todo', () async {
      final todoViewModel = TodoViewmodel();

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
