import 'package:go_router/go_router.dart';
import 'package:mvvm_template_with_flutter/data/repositories/todo_repository.dart';
import 'package:mvvm_template_with_flutter/route/routes.dart';
import 'package:mvvm_template_with_flutter/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:mvvm_template_with_flutter/ui/todo/widgets/todo_screen.dart';
import 'package:mvvm_template_with_flutter/ui/todo_details/viewmodels/todo_details_viewmodel.dart';
import 'package:mvvm_template_with_flutter/ui/todo_details/widgets/todo_details.dart';
import 'package:provider/provider.dart';

GoRouter routesConfig() {
  return GoRouter(
    initialLocation: Routes.todos,
    routes: [
      GoRoute(
        path: Routes.todos,
        builder: (context, state) {
          return TodoScreen(
            todoViewmodel: TodoViewmodel(
              todoRepository: context.read<TodoRepository>(),
              todoUpdateUsecase: context.read(),
            ),
          );
        },
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final TodoDetailsViewmodel todoDetailsViewmodel =
                  TodoDetailsViewmodel(
                    todoRepository: context.read(),
                    todoUpdateUseCase: context.read(),
                  );
              final todoId = state.pathParameters['id']!;

              todoDetailsViewmodel.load.execute(todoId);

              return TodoDetailsScreen(
                todoDetailsViewmodel: todoDetailsViewmodel,
              );
            },
          ),
        ],
      ),
    ],
  );
}
