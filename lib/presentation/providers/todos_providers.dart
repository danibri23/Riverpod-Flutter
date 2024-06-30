import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_app/config/config.dart';
import 'package:riverpod_app/domain/entities/todo.dart';
import 'package:uuid/uuid.dart';

part 'todos_providers.g.dart';

enum FilterType { all, completed, pending }

const uuid = Uuid();

@Riverpod(keepAlive: true)
class TodoCurrentFilter extends _$TodoCurrentFilter {
  @override
  FilterType build() {
    return FilterType.all;
  }

  void updateFilter(FilterType newFilter) {
    state = newFilter;
  }
}

@Riverpod(keepAlive: true)
class Todos extends _$Todos {
  @override
  List<Todo> build() {
    return [
      Todo(
        id: uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: DateTime.now(),
      ),
      Todo(
        id: uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: null,
      ),
      Todo(
        id: uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: null,
      ),
      Todo(
        id: uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: DateTime.now(),
      ),
      Todo(
        id: uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: null,
      ),
      Todo(
        id: uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: DateTime.now(),
      ),
      Todo(
        id: uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: null,
      ),
      Todo(
        id: uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: null,
      ),
    ];
  }

  void toggleDone(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          todo.copyWith(
            completedAt: todo.done ? null : DateTime.now(),
          )
        else
          todo,
    ];
  }

  void addTodo(String description) {
    state = [
      ...state,
      Todo(
        id: uuid.v4(),
        description: description,
        completedAt: null,
      ),
    ];
  }
}

@riverpod
List<Todo> filteredTodos(FilteredTodosRef ref) {
  final todos = ref.watch(todosProvider);
  final filter = ref.watch(todoCurrentFilterProvider);

  switch (filter) {
    case FilterType.completed:
      return todos.where((todo) => todo.done).toList();
    case FilterType.pending:
      return todos.where((todo) => !todo.done).toList();
    default:
      return todos;
  }
}
