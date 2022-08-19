import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/usecases/usecase.dart';
import '../../../domain/entity/todo.dart';
import '../../../domain/usecases/create_todo_usecase.dart' as create;
import '../../../domain/usecases/delete_todo_usecase.dart' as delete;
import '../../../domain/usecases/edit_todo_usecase.dart' as edit;
import '../../../domain/usecases/get_all_todo_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetAllTodoUseCase getAllTodoUseCase;
  final create.CreateTodoUseCase createTodoUseCase;
  final delete.DeleteTodoUseCase deleteTodoUseCase;
  final edit.EditTodoUseCase editTodoUseCase;
  TodoBloc({
    required this.getAllTodoUseCase,
    required this.createTodoUseCase,
    required this.deleteTodoUseCase,
    required this.editTodoUseCase,
  }) : super(TodoInitial()) {
    on<GetTodo>((event, emit) async {
      emit(LoadingTodo());
      final List<Todo> allTodos = await getAllTodoUseCase(NoParams());
      final List<Todo> todos =
          allTodos.where((todo) => !todo.isFinished).toList();
      emit(TodoLoaded(todos));
    });
    on<CreateTodo>((event, emit) async {
      emit(LoadingTodo());
      final Todo todo = event.todo;
      await createTodoUseCase(
        create.Params(
          title: todo.title,
          description: todo.description,
          time: todo.time,
          dueDate: todo.dueDate,
        ),
      );
      final List<Todo> allTodos = await getAllTodoUseCase(NoParams());
      final List<Todo> todos =
          allTodos.where((todo) => !todo.isFinished).toList();
      emit(TodoLoaded(todos));
    });
    on<DeleteTodo>((event, emit) async {
      emit(LoadingTodo());
      final int key = event.key;
      await deleteTodoUseCase(delete.Params(key));
      final List<Todo> allTodos = await getAllTodoUseCase(NoParams());
      final List<Todo> todos =
          allTodos.where((todo) => !todo.isFinished).toList();
      emit(TodoLoaded(todos));
    });
    on<EditTodo>((event, emit) async {
      emit(LoadingTodo());
      final int key = event.key;
      final Todo todo = event.todo;
      await editTodoUseCase(edit.Params(key, todo));
      final List<Todo> allTodos = await getAllTodoUseCase(NoParams());
      final List<Todo> todos =
          allTodos.where((todo) => !todo.isFinished).toList();
      emit(TodoLoaded(todos));
    });
  }
}
