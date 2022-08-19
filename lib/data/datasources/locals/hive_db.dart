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
    TodoModel todo = todoBox.get(key);
    await todo.delete();
  }

  @override
  Future<TodoModel> editTodo(
    int key,
    TodoModel updatedTodo,
  ) async {
    TodoModel todo = todoBox.get(key);
    todo.title = updatedTodo.title;
    todo.dueDate = updatedTodo.dueDate;
    todo.description = updatedTodo.description;
    todo.time = updatedTodo.time;
    todo.isFinished = updatedTodo.isFinished;
    todo.finishedDate = updatedTodo.finishedDate;
    await todo.save();
    return todo;
  }

  @override
  Future<List<TodoModel>> getAllTodos() async {
    List<TodoModel> todos = [];
    for (int key in todoBox.keys) {
      todos.add(todoBox.get(key));
    }
    return todos;
  }

  @override
  Future<TodoModel> getTodoByKey(int key) async {
    TodoModel todo = await todoBox.getAt(key);
    return todo;
  }
}
