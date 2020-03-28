import 'package:bloc/bloc.dart';

import 'package:bloc_todo/data/models/app_tab.dart';

import 'app_tab_event.dart';

class AppTabBloc extends Bloc<AppTabEvent, AppTab> {
  @override
  AppTab get initialState => AppTab.todos;

  @override
  Stream<AppTab> mapEventToState(AppTabEvent event) async* {
    if (event is AppTabUpdated) {
      yield event.tab;
    }
  }
}
