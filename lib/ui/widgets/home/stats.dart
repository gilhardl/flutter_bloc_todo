import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_todo/l10n/localizations.dart';
import 'package:bloc_todo/ui/keys.dart';
import 'package:bloc_todo/logic/blocs/stats.dart';

import 'package:bloc_todo/ui/widgets/loading_indicator.dart';

class Stats extends StatelessWidget {
  Stats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        if (state is StatsLoadInProgress) {
          return LoadingIndicator(key: Keys.statsLoading);
        } else if (state is StatsLoadSuccess) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    BlocTodoLocalizations.of(context).completedTodos,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 24.0),
                  child: Text(
                    '${state.numCompleted}',
                    key: Keys.statsNumCompleted,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    BlocTodoLocalizations.of(context).activeTodos,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 24.0),
                  child: Text(
                    "${state.numActive}",
                    key: Keys.statsNumActive,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                )
              ],
            ),
          );
        } else {
          return Container(key: Keys.emptyStatsContainer);
        }
      },
    );
  }
}
