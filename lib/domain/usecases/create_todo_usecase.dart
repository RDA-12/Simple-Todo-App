import 'package:equatable/equatable.dart';

import '../../core/usecases/usecase.dart';
import '../entity/todo.dart';
import '../repositories/todo_repo.dart';

class CreateTodoUseCase implements UseCase<Todo, Params> {
  final TodoRepo repo;
  CreateTodoUseCase(this.repo);

  @override
  Future<Todo> call(Params params) async {
    return await repo.createTodo(params.toMap());
  }
}

class Params extends Equatable {
  final String title;
  final String? description, time;
  final DateTime date;

  const Params(this.title, this.description, this.time, this.date);

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "time": time,
      "date": date,
    };
  }

  @override
  List<Object?> get props => [];
}
