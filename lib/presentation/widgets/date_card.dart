import 'package:flutter/material.dart';

import 'vertical_space.dart';

class DateCard extends StatelessWidget {
  const DateCard({
    Key? key,
    required this.date,
    required this.day,
    required this.todoLeft,
    required this.onTap,
    required this.isActived,
  }) : super(key: key);

  final String date, day;
  final int todoLeft;
  final Function() onTap;
  final bool isActived;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 75,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Card(
            color: isActived ? Theme.of(context).colorScheme.secondary : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day,
                  style: TextStyle(
                    color: isActived
                        ? Theme.of(context).colorScheme.onSecondary
                        : null,
                  ),
                ),
                const VerticalSpace(height: 5),
                Text(
                  date,
                  style: TextStyle(
                    color: isActived
                        ? Theme.of(context).colorScheme.onSecondary
                        : null,
                  ),
                ),
                const VerticalSpace(height: 5),
                Text(
                  todoLeft != 0 ? "$todoLeft todo(s)" : "free",
                  style: TextStyle(
                    color: isActived
                        ? Theme.of(context).colorScheme.onSecondary
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
