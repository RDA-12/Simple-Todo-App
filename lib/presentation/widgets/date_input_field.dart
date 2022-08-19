import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateInputField extends StatefulWidget {
  const DateInputField({
    Key? key,
    required this.dateCallback,
  }) : super(key: key);

  final Function(String date) dateCallback;

  @override
  State<DateInputField> createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<DateInputField> {
  final DateFormat fullDateFormatter = DateFormat("d MMMM y");
  final DateTime now = DateTime.now();
  DateTime? pickedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Due date",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        OutlinedButton(
          onPressed: () async {
            final DateTime? date = await showDatePicker(
              context: context,
              initialDate: now,
              firstDate: DateTime(now.year, now.month, 1),
              lastDate: DateTime(now.year + 1000),
            );
            if (date != null) {
              pickedDate = date;
              setState(() {});
              widget.dateCallback(fullDateFormatter.format(pickedDate!));
            }
          },
          child: Text(pickedDate != null
              ? fullDateFormatter.format(pickedDate!)
              : "pick a date"),
        ),
      ],
    );
  }
}
