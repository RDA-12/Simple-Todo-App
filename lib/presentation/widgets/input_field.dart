import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.title,
    required this.ctrl,
    required this.hint,
  }) : super(key: key);
  final String title, hint;
  final TextEditingController ctrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        TextFormField(
          controller: ctrl,
          decoration: InputDecoration(
            isDense: true,
            hintText: hint,
          ),
          textInputAction: TextInputAction.next,
          validator: (val) {
            if (val!.isEmpty) {
              return "this field can't be empty";
            }
            return null;
          },
        ),
      ],
    );
  }
}
