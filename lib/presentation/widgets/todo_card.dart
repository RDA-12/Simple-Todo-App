import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entity/todo.dart';

class TodoCard extends StatelessWidget {
  TodoCard({
    Key? key,
    required this.todo,
    required this.onTap,
  }) : super(key: key);

  final Todo todo;
  final Function() onTap;
  final DateTime now = DateTime.now();
  final DateFormat dateFormatter = DateFormat("d MMM");

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Card(
          color: _getCardColor(context, todo),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    todo.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(dateFormatter.format(todo.dueDate)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color? _getCardColor(BuildContext context, Todo todo) {
    final Color passDueColor = Theme.of(context).colorScheme.error;
    if (todo.isFinished) {
      if (todo.finishedDate!.isAfter(todo.dueDate)) {
        return passDueColor;
      }
      return null;
    } else {
      if (now.isAfter(todo.dueDate)) {
        return passDueColor;
      }
      return null;
    }
  }
}
