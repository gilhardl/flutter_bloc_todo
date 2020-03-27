import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_todo/localization.dart';
import 'package:bloc_todo/keys.dart';
import 'package:bloc_todo/routes.dart';
import 'package:bloc_todo/models/app_tab.dart';
import 'package:bloc_todo/blocs/app_tab.dart';

import 'package:bloc_todo/ui/widgets/extra_actions.dart';
import 'package:bloc_todo/ui/widgets/filter_button.dart';
import 'package:bloc_todo/ui/widgets/filtered_todos.dart';
import 'package:bloc_todo/ui/widgets/stats.dart';
import 'package:bloc_todo/ui/widgets/tab_selector.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key ?? Keys.homeScreen);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppTabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text('BLoC Todo'),
            actions: [
              FilterButton(visible: activeTab == AppTab.todos),
              ExtraActions(),
            ],
          ),
          body: activeTab == AppTab.todos ? FilteredTodos() : Stats(),
          floatingActionButton: FloatingActionButton(
            key: Keys.addTodoFab,
            onPressed: () {
              Navigator.pushNamed(context, Routes.addTodo);
            },
            child: Icon(Icons.add),
            tooltip: BlocTodoLocalizations.of(context).addTodo,
          ),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) =>
                BlocProvider.of<AppTabBloc>(context).add(AppTabUpdated(tab)),
          ),
        );
      },
    );
  }
}
