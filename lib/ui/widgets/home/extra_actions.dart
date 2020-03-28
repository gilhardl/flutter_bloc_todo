import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_todo/ui/localization.dart';
import 'package:bloc_todo/ui/keys.dart';

import 'package:bloc_todo/data/models/extra_action.dart';

import 'package:bloc_todo/logic/blocs/todos.dart';

class ExtraActions extends StatelessWidget {
  ExtraActions({Key key}) : super(key: Keys.extraActionsButton);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        if (state is TodosLoadSuccess) {
          bool allComplete =
              (BlocProvider.of<TodosBloc>(context).state as TodosLoadSuccess)
                  .todos
                  .every((todo) => todo.complete);
          return PopupMenuButton<ExtraAction>(
            key: Keys.extraActionsPopupMenuButton,
            onSelected: (action) {
              switch (action) {
                case ExtraAction.clearCompleted:
                  BlocProvider.of<TodosBloc>(context).add(ClearCompleted());
                  break;
                case ExtraAction.toggleAllComplete:
                  BlocProvider.of<TodosBloc>(context).add(ToggleAll());
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
              PopupMenuItem<ExtraAction>(
                key: Keys.toggleAll,
                value: ExtraAction.toggleAllComplete,
                child: Text(
                  allComplete
                      ? BlocTodoLocalizations.of(context).markAllIncomplete
                      : BlocTodoLocalizations.of(context).markAllComplete,
                ),
              ),
              PopupMenuItem<ExtraAction>(
                key: Keys.clearCompleted,
                value: ExtraAction.clearCompleted,
                child: Text(
                  BlocTodoLocalizations.of(context).clearCompleted,
                ),
              ),
            ],
          );
        }
        return Container(key: Keys.extraActionsEmptyContainer);
      },
    );
  }
}
