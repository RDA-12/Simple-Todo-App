import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int? key;
  final String title, description, time;
  final DateTime dueDate;
  final bool isFinished;
  const Todo({
    this.key,
    required this.title,
    required this.dueDate,
    required this.description,
    required this.time,
    this.isFinished = false,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        time,
        dueDate,
        key,
        isFinished,
      ];
}
