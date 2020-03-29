import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:bloc_todo/l10n/messages_all.dart';

class BlocTodoLocalizations {
  BlocTodoLocalizations(this.localeName);

  final String localeName;

  static Future<BlocTodoLocalizations> load(Locale locale) {
    final String localeName = Intl.canonicalizedLocale(
      locale.countryCode != null && locale.countryCode.isEmpty
          ? locale.languageCode
          : locale.toString(),
    );
    return initializeMessages(localeName).then((_) {
      return BlocTodoLocalizations(localeName);
    });
  }

  static BlocTodoLocalizations of(BuildContext context) {
    return Localizations.of<BlocTodoLocalizations>(
        context, BlocTodoLocalizations);
  }

  String get appTitle => Intl.message(
        'Todo',
        name: 'appTitle',
        args: [],
        locale: localeName,
      );

  String get todos => Intl.message(
        'Todos',
        name: 'todos',
        args: [],
        locale: localeName,
      );

  String get stats => Intl.message(
        'Stats',
        name: 'stats',
        args: [],
        locale: localeName,
      );

  String get login => Intl.message(
        'Sign in',
        name: 'login',
        args: [],
        locale: localeName,
      );

  String get loginLoading => Intl.message(
        'Logging in...',
        name: 'loginLoading',
        args: [],
        locale: localeName,
      );

  String get loginFailure => Intl.message(
        'Login failure',
        name: 'loginFailure',
        args: [],
        locale: localeName,
      );

  String get register => Intl.message(
        'Create an account',
        name: 'register',
        args: [],
        locale: localeName,
      );

  String get registerLoading => Intl.message(
        'Registering...',
        name: 'registerLoading',
        args: [],
        locale: localeName,
      );

  String get registerFailure => Intl.message(
        'Registration Failure',
        name: 'registerFailure',
        args: [],
        locale: localeName,
      );

  String get emailFieldLabel => Intl.message(
        'Email',
        name: 'emailFieldLabel',
        args: [],
        locale: localeName,
      );

  String get emailFieldError => Intl.message(
        'Invalid email',
        name: 'emailFieldError',
        args: [],
        locale: localeName,
      );

  String get passwordFieldLabel => Intl.message(
        'Password',
        name: 'passwordFieldLabel',
        args: [],
        locale: localeName,
      );

  String get passwordFieldError => Intl.message(
        'Invalid password',
        name: 'passwordFieldError',
        args: [],
        locale: localeName,
      );

  String get loginWithGoogle => Intl.message(
        'Sign in with Google',
        name: 'loginWithGoogle',
        args: [],
        locale: localeName,
      );

  String get showAll => Intl.message(
        'Show all',
        name: 'showAll',
        args: [],
        locale: localeName,
      );

  String get showActive => Intl.message(
        'Show active',
        name: 'showActive',
        args: [],
        locale: localeName,
      );

  String get showCompleted => Intl.message(
        'Show completed',
        name: 'showCompleted',
        args: [],
        locale: localeName,
      );

  String get newTodoHint => Intl.message(
        'What needs to be done?',
        name: 'newTodoHint',
        args: [],
        locale: localeName,
      );

  String get markAllComplete => Intl.message(
        'Mark all complete',
        name: 'markAllComplete',
        args: [],
        locale: localeName,
      );

  String get markAllIncomplete => Intl.message(
        'Mark all incomplete',
        name: 'markAllIncomplete',
        args: [],
        locale: localeName,
      );

  String get clearCompleted => Intl.message(
        'Clear completed',
        name: 'clearCompleted',
        args: [],
        locale: localeName,
      );

  String get addTodo => Intl.message(
        'Add todo',
        name: 'addTodo',
        args: [],
        locale: localeName,
      );

  String get editTodo => Intl.message(
        'Edit todo',
        name: 'editTodo',
        args: [],
        locale: localeName,
      );

  String get saveChanges => Intl.message(
        'Save changes',
        name: 'saveChanges',
        args: [],
        locale: localeName,
      );

  String get filterTodos => Intl.message(
        'Filter todos',
        name: 'filterTodos',
        args: [],
        locale: localeName,
      );

  String get deleteTodo => Intl.message(
        'Delete todo',
        name: 'deleteTodo',
        args: [],
        locale: localeName,
      );

  String get todoDetails => Intl.message(
        'Todo details',
        name: 'todoDetails',
        args: [],
        locale: localeName,
      );

  String get emptyTodoError => Intl.message(
        'Please enter some text',
        name: 'emptyTodoError',
        args: [],
        locale: localeName,
      );

  String get notesHint => Intl.message(
        'Additional notes...',
        name: 'notesHint',
        args: [],
        locale: localeName,
      );

  String get completedTodos => Intl.message(
        'Completed todos',
        name: 'completedTodos',
        args: [],
        locale: localeName,
      );

  String get activeTodos => Intl.message(
        'Active todos',
        name: 'activeTodos',
        args: [],
        locale: localeName,
      );

  String todoDeleted(String task) => Intl.message(
        'Deleted "$task"',
        name: 'todoDeleted',
        args: [task],
        locale: localeName,
      );

  String get undo => Intl.message(
        'Undo',
        name: 'undo',
        args: [],
        locale: localeName,
      );

  String get deleteTodoConfirmation => Intl.message(
        'Delete this todo?',
        name: 'deleteTodoConfirmation',
        args: [],
        locale: localeName,
      );

  String get delete => Intl.message(
        'Delete',
        name: 'delete',
        args: [],
        locale: localeName,
      );

  String get cancel => Intl.message(
        'Cancel',
        name: 'cancel',
        args: [],
        locale: localeName,
      );
}

class BlocTodoLocalizationsDelegate
    extends LocalizationsDelegate<BlocTodoLocalizations> {
  @override
  Future<BlocTodoLocalizations> load(Locale locale) =>
      BlocTodoLocalizations.load(locale);

  @override
  bool shouldReload(BlocTodoLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) => ['en', 'fr'].contains(locale.languageCode);
}
