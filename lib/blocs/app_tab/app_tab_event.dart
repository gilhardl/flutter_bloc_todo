import 'package:equatable/equatable.dart';

import 'package:bloc_todo/models/app_tab.dart';

abstract class AppTabEvent extends Equatable {
  const AppTabEvent();
}

class AppTabUpdated extends AppTabEvent {
  final AppTab tab;

  AppTabUpdated(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'TabUpdated { tab: $tab }';
}
