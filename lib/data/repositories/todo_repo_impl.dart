import 'package:todo_app/data/datasources/locals/hive_db.dart';
import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/domain/entity/todo.dart';
import 'package:todo_app/domain/repositories/todo_repo.dart';

class TodoRepoImpl implements TodoRepo {
  final LocalDataSource localDataSource;
  TodoRepoImpl(this.localDataSource);

  @override
  Future<Todo> createTodo(Todo data) async {
    TodoModel todo =
        await localDataSource.createTodo(TodoModel.fromEntity(data));
    Todo todoEntity = todo.toEntity();
    return todoEntity;
  }

  @override
  Future<void> deleteTodo(int key) async {
    await localDataSource.deleteTodo(key);
  }

  @override
  Future<Todo> editTodo(int key, Todo data) async {
    TodoModel todo =
        await localDataSource.editTodo(key, TodoModel.fromEntity(data));
    Todo todoEntity = todo.toEntity();
    return todoEntity;
  }

  @override
  Future<List<Todo>> getAllTodo() async {
    List<TodoModel> todos = await localDataSource.getAllTodos();
    List<Todo> todosEntitiy = [];
    for (TodoModel todo in todos) {
      todosEntitiy.add(todo.toEntity());
    }
    return todosEntitiy;
  }
}
