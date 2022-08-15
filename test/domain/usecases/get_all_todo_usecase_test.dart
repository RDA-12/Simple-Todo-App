import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/domain/entity/todo.dart';
import 'package:todo_app/domain/repositories/todo_repo.dart';
import 'package:todo_app/domain/usecases/get_all_todo_usecase.dart';

import 'todo_repo.mocks.dart';

@GenerateMocks([TodoRepo])
void main() {
  late final MockTodoRepo repo;
  late final GetAllTodoUseCase usecase;
  setUpAll(() {
    repo = MockTodoRepo();
    usecase = GetAllTodoUseCase(repo);
  });

  Todo tTodo = Todo("title", "description", "12:00", DateTime.now());
  List<Todo> tTodos = [tTodo, tTodo];

  test(
    'should return all todo from repo',
    () async {
      // arrange
      when(repo.getAllTodo()).thenAnswer((_) async => tTodos);

      // act
      final result = await usecase(NoParams());

      // assert
      expect(result, tTodos);
      verify(repo.getAllTodo()).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
