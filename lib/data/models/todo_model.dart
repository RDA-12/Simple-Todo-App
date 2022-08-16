import 'package:hive/hive.dart';

import '../../domain/entity/todo.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String? description;

  @HiveField(2)
  String? time;

  @HiveField(3)
  DateTime date;

  TodoModel({
    required this.title,
    required this.date,
    this.description,
    this.time,
  });

  factory TodoModel.fromEntity(Todo todo) {
    return TodoModel(
      title: todo.title,
      date: todo.date,
      description: todo.description,
      time: todo.time,
    );
  }

  Todo toEntity() {
    return Todo(
      title: title,
      date: date,
      description: description,
      time: time,
    );
  }
}
