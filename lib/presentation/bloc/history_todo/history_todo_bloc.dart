import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/domain/usecases/get_all_todo_usecase.dart';

import '../../../domain/entity/todo.dart';

part 'history_todo_event.dart';
part 'history_todo_state.dart';

class HistoryTodoBloc extends Bloc<HistoryTodoEvent, HistoryTodoState> {
  final GetAllTodoUseCase getAllTodoUseCase;
  HistoryTodoBloc(this.getAllTodoUseCase) : super(HistoryTodoInitial()) {
    on<GetHistoryTodo>((event, emit) async {
      emit(LoadingHistoryTodo());
      final List<Todo> allTodos = await getAllTodoUseCase(NoParams());
      final List<Todo> completedTodos =
          allTodos.where((todo) => todo.isFinished).toList();
      emit(HistoryTodoLoaded(completedTodos));
    });
  }
}
