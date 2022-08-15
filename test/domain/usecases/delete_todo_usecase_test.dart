import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/domain/usecases/delete_todo_usecase.dart';

import 'todo_repo.mocks.dart';

void main() {
  late final MockTodoRepo repo;
  late final DeleteTodoUseCase usecase;

  setUpAll(() {
    repo = MockTodoRepo();
    usecase = DeleteTodoUseCase(repo);
  });

  const String tKey = "test";

  test(
    'should return nothing from todo',
    () async {
      // act
      await usecase(const Params(tKey));

      // assert
      verify(repo.deleteTodo(tKey)).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
