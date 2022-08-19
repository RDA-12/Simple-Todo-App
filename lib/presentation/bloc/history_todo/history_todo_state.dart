part of 'history_todo_bloc.dart';

abstract class HistoryTodoState extends Equatable {
  const HistoryTodoState();

  @override
  List<Object> get props => [];
}

class HistoryTodoInitial extends HistoryTodoState {}

class HistoryTodoLoaded extends HistoryTodoState {
  final List<Todo> todos;
  const HistoryTodoLoaded(this.todos);

  @override
  List<Object> get props => [todos];
}

class LoadingHistoryTodo extends HistoryTodoState {}
