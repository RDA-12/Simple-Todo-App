import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String title;
  final String? description, time;
  final DateTime date;
  const Todo(this.title, this.description, this.time, this.date);

  @override
  List<Object?> get props => [title, description, time, date];
}
