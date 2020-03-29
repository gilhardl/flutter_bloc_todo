import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_todo/l10n/localizations.dart';
import 'package:bloc_todo/ui/keys.dart';

import 'package:bloc_todo/data/models/filter_visibility.dart';

import 'package:bloc_todo/logic/blocs/filtered_todos.dart';

class FilterButton extends StatelessWidget {
  final bool visible;

  FilterButton({this.visible, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.bodyText2;
    final activeStyle = Theme.of(context)
        .textTheme
        .bodyText2
        .copyWith(color: Theme.of(context).accentColor);
    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
        builder: (context, state) {
      final button = _Button(
        onSelected: (filter) {
          BlocProvider.of<FilteredTodosBloc>(context)
              .add(FilterUpdated(filter));
        },
        activeFilter: state is FilteredTodosLoadSuccess
            ? state.activeFilter
            : FilterVisibility.all,
        activeStyle: activeStyle,
        defaultStyle: defaultStyle,
      );
      return AnimatedOpacity(
        opacity: visible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 150),
        child: visible ? button : IgnorePointer(child: button),
      );
    });
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key key,
    @required this.onSelected,
    @required this.activeFilter,
    @required this.activeStyle,
    @required this.defaultStyle,
  }) : super(key: key);

  final PopupMenuItemSelected<FilterVisibility> onSelected;
  final FilterVisibility activeFilter;
  final TextStyle activeStyle;
  final TextStyle defaultStyle;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<FilterVisibility>(
      key: Keys.filterButton,
      tooltip: BlocTodoLocalizations.of(context).filterTodos,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuItem<FilterVisibility>>[
        PopupMenuItem<FilterVisibility>(
          key: Keys.allFilter,
          value: FilterVisibility.all,
          child: Text(
            BlocTodoLocalizations.of(context).showAll,
            style: activeFilter == FilterVisibility.all
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<FilterVisibility>(
          key: Keys.activeFilter,
          value: FilterVisibility.active,
          child: Text(
            BlocTodoLocalizations.of(context).showActive,
            style: activeFilter == FilterVisibility.active
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<FilterVisibility>(
          key: Keys.completedFilter,
          value: FilterVisibility.completed,
          child: Text(
            BlocTodoLocalizations.of(context).showCompleted,
            style: activeFilter == FilterVisibility.completed
                ? activeStyle
                : defaultStyle,
          ),
        ),
      ],
      icon: Icon(Icons.filter_list),
    );
  }
}
