import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/domain/entity/todo.dart';
import 'package:todo_app/domain/usecases/edit_todo_usecase.dart';

import 'todo_repo.mocks.dart';

void main() {
  late final MockTodoRepo repo;
  late final EditTodoUseCase usecase;

  setUpAll(() {
    repo = MockTodoRepo();
    usecase = EditTodoUseCase(repo);
  });

  const int tKey = 1;
  final Todo tData = Todo(
    title: "test",
    dueDate: DateTime(2022),
    description: "test",
    time: "12:00",
  );
  final Todo tNewTodo = Todo(
    title: "test2",
    description: "test",
    time: "12:00",
    dueDate: DateTime.now(),
  );

  test(
    'should return newly edited todo from repo',
    () async {
      // arrange
      when(repo.editTodo(tKey, tData)).thenAnswer((_) async => tNewTodo);

      // act
      final result = await usecase(Params(tKey, tData));

      // assert
      expect(result, tNewTodo);
      verify(repo.editTodo(tKey, tData)).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
