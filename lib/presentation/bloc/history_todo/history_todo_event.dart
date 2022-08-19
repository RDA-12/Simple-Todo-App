part of 'history_todo_bloc.dart';

abstract class HistoryTodoEvent extends Equatable {
  const HistoryTodoEvent();

  @override
  List<Object> get props => [];
}

class GetHistoryTodo extends HistoryTodoEvent {}

class FilterHistoryTodo extends HistoryTodoEvent {
  final bool Function(Todo) filter;
  const FilterHistoryTodo(this.filter);

  @override
  List<Object> get props => [filter];
}
