import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:bloc_todo/ui/localization.dart';
import 'package:bloc_todo/data/models/todo.dart';

import 'package:bloc_todo/data/providers/file_storage.dart';
import 'package:bloc_todo/data/repositories/auth_repository.dart';
import 'package:bloc_todo/data/repositories/todos_repository.dart';

import 'package:bloc_todo/logic/routes.dart';
import 'package:bloc_todo/logic/blocs/app_bloc_delegate.dart';
import 'package:bloc_todo/logic/blocs/app_tab.dart';
import 'package:bloc_todo/logic/blocs/auth.dart';
import 'package:bloc_todo/logic/blocs/todos.dart';
import 'package:bloc_todo/logic/blocs/filtered_todos.dart';
import 'package:bloc_todo/logic/blocs/stats.dart';

import 'package:bloc_todo/ui/keys.dart';
import 'package:bloc_todo/ui/screens/login_screen.dart';
import 'package:bloc_todo/ui/screens/home_screen.dart';
import 'package:bloc_todo/ui/screens/add_edit_screen.dart';

import 'ui/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = AppBlocDelegate();
  final AuthRepository authRepository = AuthRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodosBloc(
            todosRepository: const TodosRepository(
              fileStorage: const FileStorage(
                '__flutter_bloc_app__',
                getApplicationDocumentsDirectory,
              ),
            ),
          )..add(TodosLoadSuccessed()),
        ),
        BlocProvider(
          create: (context) =>
              AuthBloc(authRepository: authRepository)..add(AppStarted()),
        ),
      ],
      child: BlocTodoApp(authRepository: authRepository),
    ),
  );
}

class BlocTodoApp extends StatelessWidget {
  BlocTodoApp({@required AuthRepository authRepository})
      : assert(authRepository != null),
        _authRepository = authRepository;

  final AuthRepository _authRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:
          BlocTodoLocalizations(Locale.fromSubtags(countryCode: 'en')).appTitle,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Color(0xFFEBEBEB),
      ),
      localizationsDelegates: [
        BlocTodoLocalizationsDelegate(),
        BlocTodoLocalizationsDelegate(),
      ],
      routes: {
        Routes.home: (context) {
          return BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is InitialAuthState) {
                return SplashScreen();
              }
              if (state is Authenticated) {
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
                  child: HomeScreen(
                      key: Keys.homeScreen, userName: state.displayName),
                );
              }
              if (state is Unauthenticated) {
                return LoginScreen(authRepository: _authRepository);
              }
              return null;
            },
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
