import 'package:hive/hive.dart';

import '../../domain/entity/todo.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  String time;

  @HiveField(3)
  DateTime dueDate;

  @HiveField(4)
  bool isFinished;

  TodoModel({
    required this.title,
    required this.dueDate,
    required this.description,
    required this.time,
    required this.isFinished,
  });

  factory TodoModel.fromEntity(Todo todo) {
    return TodoModel(
      title: todo.title,
      dueDate: todo.dueDate,
      description: todo.description,
      time: todo.time,
      isFinished: todo.isFinished,
    );
  }

  Todo toEntity() {
    return Todo(
      key: key,
      title: title,
      dueDate: dueDate,
      description: description,
      time: time,
      isFinished: isFinished,
    );
  }
}
