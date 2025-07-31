# Flutter MVVM Template

 ## This implementation focuses on two main goals: 
 1. Proper MVVM architecture following Flutter guidelines
 2. Custom state management solution for deeper understanding

## Project Structure

```plaintext
lib/
├── core/
│   ├── commands/          `// Command pattern implementation`
│   ├── result/            `// Success/Error result handling`
│   └── typedefs/          `// Common type definitions`
├── domain/
│   └── models/            `// Business models (e.g. Todo)`
└── ui/
    └── todo/              `// Feature implementation`
        ├── viewmodels/    `// ViewModel classes`
        └── widgets/       `// UI Components`
```

## Core Components

### 1. Command Pattern (`core/commands/commands.dart`)
```dart
`// Base command class`
abstract class Command<Output> extends ChangeNotifier {
  bool _running = false;
  Result<Output>? _result;
  
  `// Execution logic`
  Future<void> _execute(CommandAction0<Output> action) async {
    if (_running) return;
    _running = true;
    notifyListeners();
    
    try {
      _result = await action();
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}
```

### 2. Result Type (`core/result/result.dart`)
```dart
`// Type-safe result handling`
abstract class Result<T> {
  const Result();
  
  factory Result.ok(T value) = Ok._;
  factory Result.error(Exception error) = Error._;
}

`// Success case`
class Ok<T> extends Result<T> {
  final T value;
  const Ok._(this.value);
}
```

## MVVM Implementation

### ViewModel Example
```dart
`// ui/todo/viewmodels/todo_viewmodel.dart`
class TodoViewmodel extends ChangeNotifier {
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;
  
  late Command0 loadTodos;
  late Command1<Todo, String> addTodo;
  
  TodoViewmodel() {
    loadTodos = Command0(_loadTodos);
    addTodo = Command1(_addTodo);
  }
  
  Future<Result<List<Todo>>> _loadTodos() async {
    `// ... implementation ...`
  }
}
```

### View Example
```dart
`// ui/todo/widgets/todo_screen.dart`
class TodoScreen extends StatelessWidget {
  final TodoViewmodel viewModel;
  
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) => Column(
        children: [
          if (viewModel.loadTodos.running) CircularProgressIndicator(),
          TodoList(viewModel.todos),
          AddTodoButton(onPressed: () => viewModel.addTodo.execute("New Task")),
        ],
      ),
    );
  }
}
```

## Key Features Table

| Feature           | Implementation                     | Benefit                         |
|-------------------|------------------------------------|---------------------------------|
| State Management  | `ChangeNotifier + Commands`        | No external dependencies        |
| Error Handling    | `Result type`                      | Type-safe error paths           |
| UI Updates        | `ListenableBuilder`                | Efficient rebuilds              |
| Business Logic    | `Separate ViewModel layer`         | Clean separation                |

## Getting Started

1. Clone the repository:
```bash
git clone https://github.com/do5-5anto5/mvvm_template_with_flutter.git
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## How to Use

1. **Create ViewModel**:
```dart
class MyViewModel extends ChangeNotifier {
  late Command0 loadData;
  
  MyViewModel() {
    loadData = Command0(_loadData);
  }
  
  Future<Result<Data>> _loadData() async {
    `// ... your logic ...`
  }
}
```

2. **Connect to UI**:
```dart
ListenableBuilder(
  listenable: viewModel.loadData,
  builder: (context, _) {
    if (viewModel.loadData.running) return LoadingWidget();
    if (viewModel.loadData.error) return ErrorWidget();
    return DataWidget(viewModel.data);
  },
)
```

## Testing

```dart
`// Example test`
test('ViewModel should load data', () async {
  final vm = MyViewModel();
  await vm.loadData.execute();
  
  expect(vm.data, isNotNull);
  expect(vm.loadData.completed, isTrue);
});
```

```bash
// To run tests:
flutter test`
