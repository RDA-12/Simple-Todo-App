part of 'filter_todo_bloc.dart';

abstract class FilterTodoEvent extends Equatable {
  const FilterTodoEvent();

  @override
  List<Object> get props => [];
}

class FilterTodo extends FilterTodoEvent {
  final DateTime date;
  const FilterTodo(this.date);

  @override
  List<Object> get props => [date];
}

class UnFilterTodo extends FilterTodoEvent {}
