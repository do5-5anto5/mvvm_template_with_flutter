import 'package:mvvm_template_with_flutter/data/repositories/todo_repository.dart';
import 'package:mvvm_template_with_flutter/data/repositories/todo_repository_dev.dart';
import 'package:mvvm_template_with_flutter/data/repositories/todo_repository_remote.dart';
import 'package:mvvm_template_with_flutter/data/services/api/api_client.dart';
import 'package:mvvm_template_with_flutter/domain/use_cases/todo_update_use_case.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get providersRemote {
  return [
    Provider(create: (context) => ApiClient(host: '192.168.1.105')),
    ChangeNotifierProvider(
      create: (context) =>
          TodoRepositoryRemote(apiClient: context.read<ApiClient>()) as TodoRepository,
    ),
    ..._sharedProviders
  ];
}

List<SingleChildWidget> get providersLocal {
  return [
    ChangeNotifierProvider(
      create: (context) => TodoRepositoryDev() as TodoRepository,
    ),
    ..._sharedProviders
  ];
}

List<SingleChildWidget> get _sharedProviders {
  return [
    Provider(
      create: (context) => TodoUpdateUseCase(todoRepository: context.read<TodoRepository>()),
    ),
  ];
}
