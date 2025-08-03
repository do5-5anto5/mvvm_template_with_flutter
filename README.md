
---

# Flutter MVVM

Simple implementation from MVVM to Flutter with reactive state management

**Core Components**  
`Command` (typed actions) + `Result` (error handling) + `Repository` (data isolation)

### 1. Command
```dart
final cmd = Command1<String, void>(_save); // Input: String, Output: void
await cmd.execute("data");
```

### 2. Result
```dart
Future<Result<Item>> load() async {
  try {
    return Result.ok(await repo.getItem()); // Ok<Item>
  } catch (e) {
    return Result.error(e as Exception); // Error<Item>
  }
}
```

### 3. ViewModel
```dart
class MyViewModel extends ChangeNotifier {
  final MyRepo repo;
  List<Item> items = [];

  MyViewModel(this.repo);

  Future<void> loadItems() async {
    final res = await repo.load();
    if (res is Ok<List<Item>>) items = res.value;
    notifyListeners();
  }
}
```

### 4. Repository
```dart
abstract class MyRepo {
  Future<Result<List<Item>>> load();
}

class FakeRepo implements MyRepo {
  @override
  Future<Result<List<Item>>> load() async => Result.ok([Item()]);
}
```

## Database Structure (json-server mock api)  

Simulating a local API REST during development:

### Start server  
```bash
json-server --watch server/db.json --port 3000
```
**Access:** [http://localhost:3000](http://localhost:3000)  

### `db.json` structure
```json
{
  "todos": [
    { "id": "a324", "name": "Primeiro Todo" },
    { "id": "05bf", "name": "Segundo Todo" }
  ]
}
```
**Flow**  
`Widget` → `ViewModel` → `Repository` → `DataSource`  

**Key Benefits**  
✔️ Testable (easy mocking)  
✔️ Reusable (isolated logic)  
✔️ Maintainable (clear separation of concerns)  

---