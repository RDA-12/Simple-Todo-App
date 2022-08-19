import 'package:equatable/equatable.dart';

import '../../core/usecases/usecase.dart';
import '../entity/todo.dart';
import '../repositories/todo_repo.dart';

class CreateTodoUseCase implements UseCase<Todo, Params> {
  final TodoRepo repo;
  CreateTodoUseCase(this.repo);

  @override
  Future<Todo> call(Params params) async {
    return await repo.createTodo(params.toTodo());
  }
}

class Params extends Equatable {
  final String title, description, time;
  final DateTime dueDate;

  const Params({
    required this.title,
    required this.description,
    required this.time,
    required this.dueDate,
  });

  Todo toTodo() {
    return Todo(
      title: title,
      description: description,
      time: time,
      dueDate: dueDate,
    );
  }

  @override
  List<Object?> get props => [title, description, time, dueDate];
}
