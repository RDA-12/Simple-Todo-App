import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/domain/entity/todo.dart';
import 'package:todo_app/domain/usecases/create_todo_usecase.dart';

import 'todo_repo.mocks.dart';

void main() {
  late final MockTodoRepo repo;
  late final CreateTodoUseCase usecase;

  setUpAll(() {
    repo = MockTodoRepo();
    usecase = CreateTodoUseCase(repo);
  });

  Map<String, dynamic> tData = {
    "title": "test",
    "description": "test",
    "time": "12:00",
    "date": DateTime(2022),
  };

  final Todo tTodo = Todo("test", "test", "12:00", DateTime(2022));

  test(
    'should return todo that newly created',
    () async {
      // arrange
      when(repo.createTodo(tData)).thenAnswer((_) async => tTodo);

      // act
      final result = await usecase(
        Params("test", "test", "12:00", DateTime(2022)),
      );

      // assert
      expect(result, tTodo);
      verify(repo.createTodo(tData)).called(1);
      verifyNoMoreInteractions(repo);
    },
  );

  test(
    'should return correct map data',
    () async {
      // act
      final params = Params("test", "test", "12:00", DateTime(2022));
      final result = params.toMap();

      // assert
      expect(result, tData);
    },
  );
}
