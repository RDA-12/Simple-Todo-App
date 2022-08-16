import 'package:equatable/equatable.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/domain/repositories/todo_repo.dart';

import '../entity/todo.dart';

class EditTodoUseCase implements UseCase<Todo, Params> {
  final TodoRepo repo;
  EditTodoUseCase(this.repo);

  @override
  Future<Todo> call(Params params) async {
    return await repo.editTodo(params.key, params.data);
  }
}

class Params extends Equatable {
  final int key;
  final Todo data;
  const Params(this.key, this.data);

  @override
  List<Object?> get props => [key, data];
}
