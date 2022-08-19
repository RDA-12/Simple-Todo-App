part of 'filter_todo_bloc.dart';

abstract class FilterTodoState extends Equatable {
  const FilterTodoState();

  @override
  List<Object> get props => [];
}

class UnFilteredTodos extends FilterTodoState {}

class FilteredTodos extends FilterTodoState {
  final DateTime date;
  final List<Todo> todos;
  const FilteredTodos({required this.todos, required this.date});

  @override
  List<Object> get props => [todos, date];
}
