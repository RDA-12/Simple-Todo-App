import 'package:equatable/equatable.dart';

import '../../core/usecases/usecase.dart';
import '../repositories/todo_repo.dart';

class DeleteTodoUseCase implements UseCase<void, Params> {
  final TodoRepo repo;
  DeleteTodoUseCase(this.repo);

  @override
  Future<void> call(Params params) async {
    return await repo.deleteTodo(params.key);
  }
}

class Params extends Equatable {
  final String key;
  const Params(this.key);

  @override
  List<Object?> get props => [key];
}
