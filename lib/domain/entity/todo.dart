import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String title;
  final String? description, time;
  final DateTime date;
  const Todo({
    required this.title,
    required this.date,
    this.description,
    this.time,
  });

  @override
  List<Object?> get props => [title, description, time, date];
}
