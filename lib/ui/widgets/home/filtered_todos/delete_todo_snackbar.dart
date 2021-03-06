import 'package:flutter/material.dart';

import 'package:bloc_todo/l10n/localizations.dart';
import 'package:bloc_todo/data/models/todo.dart';

class DeleteTodoSnackBar extends SnackBar {
  final BlocTodoLocalizations localizations;

  DeleteTodoSnackBar({
    Key key,
    @required Todo todo,
    @required VoidCallback onUndo,
    @required this.localizations,
  }) : super(
          key: key,
          content: Text(
            localizations.todoDeleted(todo.task),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: localizations.undo,
            onPressed: onUndo,
          ),
        );
}
