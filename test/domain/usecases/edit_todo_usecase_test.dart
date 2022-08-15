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

  const String tKey = "test";
  final Map<String, dynamic> tData = {"title": "test2"};
  final Todo tNewTodo = Todo("test2", "test", "12:00", DateTime.now());

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
