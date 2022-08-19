import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoCard extends StatelessWidget {
  TodoCard({
    Key? key,
    required this.title,
    required this.date,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final DateTime date;
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
          color: now.isAfter(date) ? Theme.of(context).colorScheme.error : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(dateFormatter.format(date)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
