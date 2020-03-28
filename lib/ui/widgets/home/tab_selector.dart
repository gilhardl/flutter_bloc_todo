import 'package:flutter/material.dart';

import 'package:bloc_todo/localization.dart';
import 'package:bloc_todo/keys.dart';
import 'package:bloc_todo/models/app_tab.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: Keys.tabs,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Icon(
            tab == AppTab.todos ? Icons.list : Icons.show_chart,
            key: tab == AppTab.todos ? Keys.todoTab : Keys.statsTab,
          ),
          title: Text(tab == AppTab.stats
              ? BlocTodoLocalizations.of(context).stats
              : BlocTodoLocalizations.of(context).todos),
        );
      }).toList(),
    );
  }
}
