import 'package:flutter/material.dart';

class TimeInputField extends StatefulWidget {
  const TimeInputField({
    Key? key,
    required this.timeCallback,
  }) : super(key: key);

  final Function(String time) timeCallback;

  @override
  State<TimeInputField> createState() => _TimeInputFieldState();
}

class _TimeInputFieldState extends State<TimeInputField> {
  String hour = "";
  String minute = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Time",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        OutlinedButton(
          onPressed: () async {
            TimeOfDay? time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              initialEntryMode: TimePickerEntryMode.input,
            );
            if (time != null) {
              setState(() {
                hour = time.hour.toString().padLeft(2, '0');
                minute = time.minute.toString().padLeft(2, '0');
              });
              widget.timeCallback("$hour : $minute");
            }
          },
          child: Text(hour.isEmpty && minute.isEmpty
              ? "pick a time"
              : "$hour : $minute"),
        ),
      ],
    );
  }
}
