import '../../core/usecases/usecase.dart';
import '../entity/todo.dart';
import '../repositories/todo_repo.dart';

class GetAllTodoUseCase implements UseCase<List<Todo>, NoParams> {
  final TodoRepo repo;

  GetAllTodoUseCase(this.repo);

  @override
  Future<List<Todo>> call(NoParams params) async {
    return await repo.getAllTodo();
  }
}
