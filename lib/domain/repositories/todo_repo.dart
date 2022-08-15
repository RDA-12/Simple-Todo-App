import '../entity/todo.dart';

abstract class TodoRepo {
  Future<List<Todo>> getAllTodo();
  Future<Todo> createTodo(Map<String, dynamic> data);
  Future<void> deleteTodo(String key);
  Future<Todo> editTodo(String key, Map<String, dynamic> data);
}
