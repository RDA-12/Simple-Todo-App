import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/presentation/bloc/history_todo/history_todo_bloc.dart';

import 'data/datasources/locals/hive_db.dart';
import 'data/models/todo_model.dart';
import 'data/repositories/todo_repo_impl.dart';
import 'domain/usecases/create_todo_usecase.dart';
import 'domain/usecases/delete_todo_usecase.dart';
import 'domain/usecases/edit_todo_usecase.dart';
import 'domain/usecases/get_all_todo_usecase.dart';
import 'presentation/bloc/filter_todo/filter_todo_bloc.dart';
import 'presentation/bloc/todo/todo_bloc.dart';
import 'presentation/pages/home_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<TodoModel>(TodoModelAdapter());
  await Hive.openBox("todos");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final HiveDataSource dataSource;
  late final TodoRepoImpl todoRepo;
  late final Box todoBox;
  late final GetAllTodoUseCase getAllTodoUseCase;
  late final CreateTodoUseCase createTodoUseCase;
  late final DeleteTodoUseCase deleteTodoUseCase;
  late final EditTodoUseCase editTodoUseCase;
  late final TodoBloc todoBloc;
  late final FilterTodoBloc filterTodoBloc;
  late final HistoryTodoBloc historyTodoBloc;

  @override
  void initState() {
    super.initState();
    todoBox = Hive.box("todos");
    _deleteTodoData(todoBox);
    dataSource = HiveDataSource(todoBox: todoBox);
    todoRepo = TodoRepoImpl(dataSource);
    getAllTodoUseCase = GetAllTodoUseCase(todoRepo);
    createTodoUseCase = CreateTodoUseCase(todoRepo);
    deleteTodoUseCase = DeleteTodoUseCase(todoRepo);
    editTodoUseCase = EditTodoUseCase(todoRepo);
    todoBloc = TodoBloc(
      createTodoUseCase: createTodoUseCase,
      deleteTodoUseCase: deleteTodoUseCase,
      editTodoUseCase: editTodoUseCase,
      getAllTodoUseCase: getAllTodoUseCase,
    );
    filterTodoBloc = FilterTodoBloc(getAllTodoUseCase);
    historyTodoBloc = HistoryTodoBloc(getAllTodoUseCase);
  }

  void _deleteTodoData(Box box) async {
    await box.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => todoBloc),
        BlocProvider(create: (context) => filterTodoBloc),
        BlocProvider(create: (context) => historyTodoBloc),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: const HomePage(),
      ),
    );
  }
}
