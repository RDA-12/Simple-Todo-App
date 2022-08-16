import '../entity/todo.dart';

abstract class TodoRepo {
  Future<List<Todo>> getAllTodo();
  Future<Todo> createTodo(Todo data);
  Future<void> deleteTodo(int key);
  Future<Todo> editTodo(int key, Todo data);
}
