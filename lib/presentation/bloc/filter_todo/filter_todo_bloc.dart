import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/usecases/usecase.dart';
import '../../../domain/entity/todo.dart';
import '../../../domain/usecases/get_all_todo_usecase.dart';

part 'filter_todo_event.dart';
part 'filter_todo_state.dart';

class FilterTodoBloc extends Bloc<FilterTodoEvent, FilterTodoState> {
  final GetAllTodoUseCase getAllTodoUseCase;
  final DateFormat dateFormatter = DateFormat("d MMMM y");
  FilterTodoBloc(this.getAllTodoUseCase) : super(UnFilteredTodos()) {
    on<FilterTodo>((event, emit) async {
      final List<Todo> allTodos = await getAllTodoUseCase(NoParams());
      final List<Todo> todos =
          allTodos.where((todo) => !todo.isFinished).toList();
      final DateTime date = event.date;
      final String formattedDate = dateFormatter.format(date);
      final List<Todo> filteredTodo = todos
          .where(
            (todo) => dateFormatter.format(todo.dueDate) == formattedDate,
          )
          .toList();
      emit(FilteredTodos(todos: filteredTodo, date: date));
    });
    on<UnFilterTodo>((event, emit) {
      emit(UnFilteredTodos());
    });
  }
}
