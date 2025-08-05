import 'package:go_router/go_router.dart';
import 'package:mvvm_template_with_flutter/data/repositories/todo_repository_remote.dart';
import 'package:mvvm_template_with_flutter/data/services/api/api_client.dart';
import 'package:mvvm_template_with_flutter/route/routes.dart';
import 'package:mvvm_template_with_flutter/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:mvvm_template_with_flutter/ui/todo/widgets/todo_screen.dart';

GoRouter routesConfig() {
  return GoRouter(
    initialLocation: Routes.todos,
    routes: [
      GoRoute(
        path: Routes.todos,
        builder: (context, state) {
          return TodoScreen(
            todoViewmodel: TodoViewmodel(
              todoRepository: TodoRepositoryRemote(
                apiClient: ApiClient(host: '192.168.1.105'),
              ),
            ),
          );
        },
      ),
    ],
  );
}
