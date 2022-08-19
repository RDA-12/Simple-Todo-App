import 'package:flutter/material.dart';

class CreateTodoDialog extends StatelessWidget {
  const CreateTodoDialog({
    Key? key,
    required this.onPressedCancel,
    required this.onPressedNext,
    required this.content,
  }) : super(key: key);

  final Function() onPressedCancel, onPressedNext;
  final Widget content;

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
      actions: [
        OutlinedButton(
          onPressed: onPressedCancel,
          child: const Text("cancel"),
        ),
        ElevatedButton(
          onPressed: onPressedNext,
          child: const Text("create"),
        ),
      ],
      content: content,
    );
  }
}
