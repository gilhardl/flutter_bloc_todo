import 'package:bloc_todo/blocs/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_todo/localization.dart';
import 'package:bloc_todo/keys.dart';
import 'package:bloc_todo/routes.dart';
import 'package:bloc_todo/models/app_tab.dart';
import 'package:bloc_todo/blocs/app_tab.dart';

import 'package:bloc_todo/ui/widgets/home/extra_actions.dart';
import 'package:bloc_todo/ui/widgets/home/filter_button.dart';
import 'package:bloc_todo/ui/widgets/home/filtered_todos.dart';
import 'package:bloc_todo/ui/widgets/home/stats.dart';
import 'package:bloc_todo/ui/widgets/home/tab_selector.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key, this.userName}) : super(key: key ?? Keys.homeScreen);

  final String userName;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppTabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
                '${BlocTodoLocalizations.of(context).appTitle} - $userName'),
            actions: [
              FilterButton(visible: activeTab == AppTab.todos),
              ExtraActions(),
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(LoggedOut());
                },
              )
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
