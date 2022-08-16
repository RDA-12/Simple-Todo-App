import 'package:hive/hive.dart';

import '../../models/todo_model.dart';

abstract class LocalDataSource {
  Future<List<TodoModel>> getAllTodos();
  Future<TodoModel> createTodo(TodoModel todo);
  Future<TodoModel> editTodo(int key, TodoModel todo);
  Future<TodoModel> getTodoByKey(int key);
  Future<void> deleteTodo(int key);
}

class HiveDataSource implements LocalDataSource {
  final Box todoBox;
  HiveDataSource({required this.todoBox});

  @override
  Future<TodoModel> createTodo(TodoModel todo) async {
    await todoBox.add(todo);
    return todo;
  }

  @override
  Future<void> deleteTodo(int key) async {
    await todoBox.delete(key);
  }

  @override
  Future<TodoModel> editTodo(
    int key,
    TodoModel updatedTodo,
  ) async {
    TodoModel todo = todoBox.getAt(key);
    todo.title = updatedTodo.title;
    todo.date = updatedTodo.date;
    todo.description = updatedTodo.description ?? todo.description;
    todo.time = updatedTodo.time ?? todo.time;
    await todo.save();
    return todo;
  }

  @override
  Future<List<TodoModel>> getAllTodos() async {
    List<TodoModel> todos = [];
    for (int key in todoBox.keys) {
      todos.add(todoBox.getAt(key));
    }
    return todos;
  }

  @override
  Future<TodoModel> getTodoByKey(int key) async {
    TodoModel todo = await todoBox.getAt(key);
    return todo;
  }
}
