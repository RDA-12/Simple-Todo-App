import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/todo.dart';
import '../bloc/history_todo/history_todo_bloc.dart';
import '../bloc/todo/todo_bloc.dart';
import '../widgets/todo_card.dart';
import '../widgets/todo_detail_dialog.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryTodoBloc>().add(GetHistoryTodo());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is TodoLoaded) {
          context.read<HistoryTodoBloc>().add(GetHistoryTodo());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("History"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<HistoryTodoBloc, HistoryTodoState>(
            builder: (_, state) {
              if (state is HistoryTodoLoaded) {
                final List<Todo> todos = state.todos;
                return todos.isEmpty
                    ? const Center(
                        child: Text("You never finished a todo"),
                      )
                    : ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (_, index) {
                          return TodoCard(
                            title: todos[index].title,
                            date: todos[index].dueDate,
                            onTap: () => _openDetail(context, todos[index]),
                          );
                        },
                      );
              }
              if (state is HistoryTodoInitial || state is LoadingHistoryTodo) {
                return const Center(child: CircularProgressIndicator());
              }
              return const Center(
                child: Text("Unexpected error"),
              );
            },
          ),
        ),
      ),
    );
  }

  void _deleteTodo(BuildContext context, int key) {
    context.read<TodoBloc>().add(DeleteTodo(key));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
          dismissDirection: DismissDirection.horizontal,
          content: Text("todo deleted"),
        ),
      );
    Navigator.of(context).pop();
  }

  void _openDetail(BuildContext context, Todo todo) {
    showDialog(
      context: context,
      builder: (_) {
        return TodoDetailDialog(
          todo: todo,
          onPressedDone: () {},
          onPressedDelete: () => _deleteTodo(context, todo.key!),
        );
      },
    );
  }
}
