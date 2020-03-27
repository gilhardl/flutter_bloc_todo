import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:bloc_todo/localization.dart';
import 'package:bloc_todo/blocs/todos.dart';
import 'package:bloc_todo/keys.dart';
import 'package:bloc_todo/models/todo.dart';
import 'package:bloc_todo/providers/file_storage.dart';
import 'package:bloc_todo/routes.dart';
import 'package:bloc_todo/ui/screens/add_edit_screen.dart';
import 'package:bloc_todo/ui/screens/home_screen.dart';
import 'package:bloc_todo/blocs/app_tab.dart';
import 'package:bloc_todo/blocs/filtered_todos.dart';
import 'package:bloc_todo/blocs/stats.dart';
import 'package:bloc_todo/blocs/app_bloc_delegate.dart';
import 'package:bloc_todo/repositories/todos_repository.dart';

void main() {
  BlocSupervisor.delegate = AppBlocDelegate();
  runApp(
    BlocProvider(
      create: (context) {
        return TodosBloc(
          todosRepository: const TodosRepository(
            fileStorage: const FileStorage(
              '__flutter_bloc_app__',
              getApplicationDocumentsDirectory,
            ),
          ),
        )..add(TodosLoadSuccessed());
      },
      child: BlocTodoApp(),
    ),
  );
}

class BlocTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:
          BlocTodoLocalizations(Locale.fromSubtags(countryCode: 'en')).appTitle,
      localizationsDelegates: [
        BlocTodoLocalizationsDelegate(),
        BlocTodoLocalizationsDelegate(),
      ],
      routes: {
        Routes.home: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<AppTabBloc>(
                create: (context) => AppTabBloc(),
              ),
              BlocProvider<FilteredTodosBloc>(
                create: (context) => FilteredTodosBloc(
                  todosBloc: BlocProvider.of<TodosBloc>(context),
                ),
              ),
              BlocProvider<StatsBloc>(
                create: (context) => StatsBloc(
                  todosBloc: BlocProvider.of<TodosBloc>(context),
                ),
              ),
            ],
            child: HomeScreen(key: Keys.homeScreen),
          );
        },
        Routes.addTodo: (context) {
          return AddEditScreen(
            key: Keys.addTodoScreen,
            onSave: (task, note) {
              BlocProvider.of<TodosBloc>(context).add(
                TodoAdded(Todo(task, note: note)),
              );
            },
            isEditing: false,
          );
        },
      },
    );
  }
}
