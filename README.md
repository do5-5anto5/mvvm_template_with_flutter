
---

# Flutter MVVM

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

**Flow**  
`Widget` → `ViewModel` → `Repository` → `DataSource`  

**Key Benefits**  
✔️ Testable (easy mocking)  
✔️ Reusable (isolated logic)  
✔️ Maintainable (clear separation of concerns)  

---