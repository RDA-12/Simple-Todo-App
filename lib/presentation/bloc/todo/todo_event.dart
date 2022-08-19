part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class CreateTodo extends TodoEvent {
  final Todo todo;
  const CreateTodo(this.todo);

  @override
  List<Object> get props => [todo];
}

class EditTodo extends TodoEvent {
  final Todo todo;
  final int key;
  const EditTodo(this.todo, this.key);

  @override
  List<Object> get props => [todo, key];
}

class DeleteTodo extends TodoEvent {
  final int key;
  const DeleteTodo(this.key);

  @override
  List<Object> get props => [key];
}

class GetTodo extends TodoEvent {}
