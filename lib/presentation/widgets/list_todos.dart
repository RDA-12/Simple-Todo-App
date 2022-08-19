import 'package:flutter/material.dart';
import 'package:todo_app/presentation/widgets/todo_card.dart';

import '../../domain/entity/todo.dart';

class ListTodos extends StatelessWidget {
  const ListTodos({
    Key? key,
    required this.todos,
    required this.onTap,
  }) : super(key: key);

  final List<Todo> todos;
  final Function(Todo todo) onTap;

  @override
  Widget build(BuildContext context) {
    return todos.isNotEmpty
        ? ListView.builder(
            itemCount: todos.length,
            itemBuilder: (_, index) {
              return TodoCard(
                title: todos[index].title,
                date: todos[index].dueDate,
                onTap: () => onTap(todos[index]),
              );
            },
          )
        : const Center(
            child: Text("You are free now!"),
          );
  }
}
