import 'package:equatable/equatable.dart';

import 'package:bloc_todo/data/models/todo.dart';
import 'package:bloc_todo/data/models/filter_visibility.dart';

abstract class FilteredTodosState extends Equatable {
  const FilteredTodosState();

  @override
  List<Object> get props => [];
}

class FilteredTodosLoadInProgress extends FilteredTodosState {}

class FilteredTodosLoadSuccess extends FilteredTodosState {
  final FilterVisibility activeFilter;
  final List<Todo> filteredTodos;

  FilteredTodosLoadSuccess(
    this.activeFilter,
    this.filteredTodos,
  );

  @override
  List<Object> get props => [activeFilter, filteredTodos];

  @override
  String toString() {
    return 'FilteredTodosLoadSuccess { activeFilter: $activeFilter, filteredTodos: $filteredTodos }';
  }
}
