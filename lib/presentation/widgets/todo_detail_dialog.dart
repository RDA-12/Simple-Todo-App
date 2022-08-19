import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entity/todo.dart';
import 'horizontal_space.dart';
import 'vertical_space.dart';

class TodoDetailDialog extends StatelessWidget {
  TodoDetailDialog({
    Key? key,
    required this.todo,
    required this.onPressedDone,
    required this.onPressedDelete,
  }) : super(key: key);

  final Todo todo;
  final DateFormat dateFormatter = DateFormat("d MMMM y");
  final Function() onPressedDone, onPressedDelete;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 12,
      ),
      content: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              todo.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const VerticalSpace(height: 5),
            !todo.isFinished
                ? Text(
                    dateFormatter.format(todo.dueDate),
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: _getDateColor(context, todo),
                        ),
                  )
                : Text(
                    "finished at ${dateFormatter.format(todo.finishedDate!)}",
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: _getDateColor(context, todo),
                        ),
                  ),
            const VerticalSpace(height: 10),
            Text(
              todo.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const VerticalSpace(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onPressedDelete,
                    child: const Text("delete"),
                  ),
                ),
                const HorizontalSpace(width: 5),
                Expanded(
                  child: ElevatedButton(
                    onPressed: todo.isFinished ? null : onPressedDone,
                    child: Text(todo.isFinished ? "finished" : "done"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color? _getDateColor(BuildContext context, Todo todo) {
    final Color passDueColor = Theme.of(context).colorScheme.error;
    if (todo.isFinished) {
      if (todo.finishedDate!.isAfter(todo.dueDate)) {
        return passDueColor;
      }
      return null;
    } else {
      if (DateTime.now().isAfter(todo.dueDate)) {
        return passDueColor;
      }
      return null;
    }
  }
}
