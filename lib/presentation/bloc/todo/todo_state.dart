part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class LoadingTodo extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;
  const TodoLoaded(this.todos);

  @override
  List<Object> get props => [todos];
}
