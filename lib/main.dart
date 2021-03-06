import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_todo/l10n/localizations.dart';
import 'package:bloc_todo/data/models/todo.dart';

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
//  BlocSupervisor.delegate = AppBlocDelegate();
  runApp(
    Provider(
      create: (_) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
            authRepository: Provider.of<AuthRepository>(context, listen: false))
          ..add(AppStarted()),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return BlocProvider(
              create: (context) => TodosBloc(
                todosRepository:
                    TodosRepository(state is Authenticated ? state.userId : ''),
              )..add(TodosLoadSuccessed()),
              child: BlocTodoApp(),
            );
          },
        ),
      ),
    ),
  );
}

class BlocTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) =>
          BlocTodoLocalizations.of(context).appTitle,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Color(0xFFEBEBEB),
      ),
      localizationsDelegates: [
        BlocTodoLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('fr'), // French
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
                return LoginScreen();
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
