import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_todo/localization.dart';
import 'package:bloc_todo/keys.dart';
import 'package:bloc_todo/blocs/filtered_todos.dart';
import 'package:bloc_todo/blocs/todos.dart';

import 'package:bloc_todo/ui/screens/details_screen.dart';
import 'package:bloc_todo/ui/widgets/loading_indicator.dart';
import 'package:bloc_todo/ui/widgets/home/filtered_todos/delete_todo_snackbar.dart';
import 'package:bloc_todo/ui/widgets/home/filtered_todos/todo_item.dart';

class FilteredTodos extends StatelessWidget {
  FilteredTodos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = BlocTodoLocalizations.of(context);

    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
      builder: (context, state) {
        if (state is FilteredTodosLoadInProgress) {
          return LoadingIndicator(key: Keys.todosLoading);
        } else if (state is FilteredTodosLoadSuccess) {
          final todos = state.filteredTodos;
          return ListView.builder(
            key: Keys.todoList,
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              final todo = todos[index];
              return TodoItem(
                todo: todo,
                onDismissed: (direction) {
                  BlocProvider.of<TodosBloc>(context).add(TodoDeleted(todo));
                  Scaffold.of(context).showSnackBar(DeleteTodoSnackBar(
                    key: Keys.snackbarAction('deleteTodo__${todo.id}'),
                    todo: todo,
                    onUndo: () => BlocProvider.of<TodosBloc>(context)
                        .add(TodoAdded(todo)),
                    localizations: localizations,
                  ));
                },
                onTap: () async {
                  final removedTodo = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return DetailsScreen(id: todo.id);
                    }),
                  );
                  if (removedTodo != null) {
                    Scaffold.of(context).showSnackBar(DeleteTodoSnackBar(
                      key: Keys.snackbarAction('deleteTodo__${todo.id}'),
                      todo: todo,
                      onUndo: () => BlocProvider.of<TodosBloc>(context)
                          .add(TodoAdded(todo)),
                      localizations: localizations,
                    ));
                  }
                },
                onCheckboxChanged: (_) {
                  BlocProvider.of<TodosBloc>(context).add(
                    TodoUpdated(todo.copyWith(complete: !todo.complete)),
                  );
                },
              );
            },
          );
        } else {
          return Container(key: Keys.filteredTodosEmptyContainer);
        }
      },
    );
  }
}
