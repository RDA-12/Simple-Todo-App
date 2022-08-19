import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/presentation/widgets/date_card.dart';

import '../../domain/entity/todo.dart';

class CalendarCarousel extends StatefulWidget {
  const CalendarCarousel({
    Key? key,
    required this.todos,
    required this.onTap,
  }) : super(key: key);

  final List<Todo> todos;
  final Function(List date) onTap;

  @override
  State<CalendarCarousel> createState() => _CalendarCarouselState();
}

class _CalendarCarouselState extends State<CalendarCarousel> {
  final DateFormat fullDateFormatter = DateFormat("d MMMM y");
  final DateFormat dayFormatter = DateFormat('E');
  final NumberFormat dateNumFormatter = NumberFormat('00');
  final DateTime now = DateTime.now();
  int datePicked = -1;

  List<DateTime> fullDates = [];
  List<String> days = [];
  List<String> dates = [];

  List<int> _getTodoLeft() {
    List<int> result = [];
    for (int i = 0; i < 7; i++) {
      final fullDate = now.add(Duration(days: i));
      final int count = widget.todos
          .where((todo) =>
              fullDateFormatter.format(todo.dueDate) ==
                  fullDateFormatter.format(fullDate) &&
              !todo.isFinished)
          .length;
      result.add(count);
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 7; i++) {
      final fullDate = now.add(Duration(days: i));
      final formattedFullDate = fullDateFormatter.format(fullDate);
      fullDates.add(fullDateFormatter.parse(formattedFullDate));
      final day = dayFormatter.format(fullDate);
      final date = dateNumFormatter.format(fullDate.day);
      days.add(day);
      dates.add(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 100,
          width: 75,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  datePicked = -1;
                });
                widget.onTap([-1]);
              },
              child: Card(
                color: datePicked == -1
                    ? Theme.of(context).colorScheme.secondary
                    : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    "All",
                    style: TextStyle(
                      color: datePicked == -1
                          ? Theme.of(context).colorScheme.onSecondary
                          : null,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: fullDates.length,
            itemBuilder: (_, index) {
              return DateCard(
                date: dates[index],
                day: days[index],
                isActived: datePicked == index,
                onTap: () {
                  setState(() {
                    datePicked = index;
                  });
                  widget.onTap([fullDates[index]]);
                },
                todoLeft: _getTodoLeft()[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
