import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../domain/entity/todo.dart';
import '../bloc/filter_todo/filter_todo_bloc.dart';
import '../bloc/todo/todo_bloc.dart';
import '../widgets/calendar_carousel.dart';
import '../widgets/create_todo_dialog.dart';
import '../widgets/date_input_field.dart';
import '../widgets/input_field.dart';
import '../widgets/list_todos.dart';
import '../widgets/time_input_field.dart';
import '../widgets/todo_detail_dialog.dart';
import '../widgets/vertical_space.dart';
import 'history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DateFormat dateFormatter = DateFormat("d MMMM y");
  late final GlobalKey<FormState> formKey;
  late final TextEditingController titleCtrl;
  late final TextEditingController descriptionCtrl;
  late final TextEditingController timeCtrl;
  late final TextEditingController dateCtrl;

  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(GetTodo());
    formKey = GlobalKey<FormState>();
    titleCtrl = TextEditingController();
    descriptionCtrl = TextEditingController();
    timeCtrl = TextEditingController();
    dateCtrl = TextEditingController();
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    descriptionCtrl.dispose();
    timeCtrl.dispose();
    dateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const HistoryPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  if (state is TodoLoaded) {
                    return CalendarCarousel(
                      todos: state.todos,
                      onTap: (List dateOrAll) {
                        if (dateOrAll[0] != -1) {
                          context
                              .read<FilterTodoBloc>()
                              .add(FilterTodo(dateOrAll[0]));
                        } else {
                          context.read<FilterTodoBloc>().add(UnFilterTodo());
                        }
                      },
                    );
                  }
                  return CalendarCarousel(
                    todos: const [],
                    onTap: (date) {},
                  );
                },
              ),
            ),
            const VerticalSpace(height: 12),
            Expanded(
              child: Builder(
                builder: (_) {
                  final TodoState todoState = context.watch<TodoBloc>().state;
                  final FilterTodoState filterTodoState =
                      context.watch<FilterTodoBloc>().state;
                  if (todoState is TodoLoaded) {
                    if (filterTodoState is FilteredTodos) {
                      context
                          .read<FilterTodoBloc>()
                          .add(FilterTodo(filterTodoState.date));
                      return ListTodos(
                        todos: filterTodoState.todos,
                        onTap: (Todo todo) => _openDetails(context, todo),
                      );
                    }
                    return ListTodos(
                      todos: todoState.todos,
                      onTap: (Todo todo) => _openDetails(context, todo),
                    );
                  }
                  if (todoState is LoadingTodo || todoState is TodoInitial) {
                    return const CircularProgressIndicator();
                  }
                  return const Text("Unexpected Error");
                },
              ),
            ),
            const VerticalSpace(height: 12),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return WillPopScope(
                onWillPop: () {
                  _popAndClear(context);
                  return Future.value(false);
                },
                child: CreateTodoDialog(
                  onPressedCancel: () => _popAndClear(context),
                  onPressedNext: () => _createTodo(context),
                  content: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Text(
                            "Create New Todo",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const VerticalSpace(height: 24),
                          InputField(
                            title: "Name",
                            ctrl: titleCtrl,
                            hint: "Make ice tea",
                          ),
                          const VerticalSpace(height: 16),
                          InputField(
                            title: "Detail",
                            ctrl: descriptionCtrl,
                            hint: "Ice tea for myself",
                          ),
                          const VerticalSpace(height: 16),
                          DateInputField(
                            dateCallback: (String date) {
                              setState(() {
                                dateCtrl.text = date;
                              });
                            },
                          ),
                          const VerticalSpace(height: 16),
                          TimeInputField(
                            timeCallback: (String time) {
                              setState(() {
                                timeCtrl.text = time;
                              });
                            },
                          ),
                          const VerticalSpace(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _popAndClear(BuildContext context) {
    Navigator.of(context).pop();
    titleCtrl.clear();
    descriptionCtrl.clear();
    timeCtrl.clear();
    dateCtrl.clear();
  }

  void _createTodo(BuildContext context) {
    if (formKey.currentState!.validate() &&
        dateCtrl.text.isNotEmpty &&
        timeCtrl.text.isNotEmpty) {
      final Todo newTodo = Todo(
        title: titleCtrl.text,
        description: descriptionCtrl.text,
        time: timeCtrl.text,
        dueDate: dateFormatter.parse(dateCtrl.text),
      );
      context.read<TodoBloc>().add(CreateTodo(newTodo));
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 3),
            content: Text("todo created"),
          ),
        );
      _popAndClear(context);
    }
  }

  void _finishTodo(BuildContext context, Todo todo) {
    final Todo newTodo = Todo(
      time: todo.time,
      title: todo.title,
      description: todo.description,
      dueDate: todo.dueDate,
      isFinished: true,
    );
    context.read<TodoBloc>().add(
          EditTodo(newTodo, todo.key!),
        );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.horizontal,
          content: Text("${todo.title} finished"),
        ),
      );
    Navigator.of(context).pop();
  }

  void _deleteTodo(BuildContext context, int key) {
    context.read<TodoBloc>().add(DeleteTodo(key));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.horizontal,
          duration: Duration(seconds: 3),
          content: Text("todo deleted"),
        ),
      );
    Navigator.of(context).pop();
  }

  void _openDetails(BuildContext context, Todo todo) {
    showDialog(
      context: context,
      builder: (_) {
        return TodoDetailDialog(
          todo: todo,
          onPressedDone: () => _finishTodo(context, todo),
          onPressedDelete: () => _deleteTodo(context, todo.key!),
        );
      },
    );
  }
}
