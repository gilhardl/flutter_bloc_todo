import 'dart:async';
import 'package:bloc_todo/models/todo.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:bloc_todo/models/filter_visibility.dart';
import 'package:bloc_todo/blocs/todos/todos_bloc.dart';
import 'package:bloc_todo/blocs/todos/todos_state.dart';

import 'filtered_todos_state.dart';
import 'filtered_todos_event.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  final TodosBloc todosBloc;
  StreamSubscription todosSubscription;

  FilteredTodosBloc({@required this.todosBloc}) {
    todosSubscription = todosBloc.listen((state) {
      if (state is TodosLoadSuccess) {
        add(TodosUpdated((todosBloc.state as TodosLoadSuccess).todos));
      }
    });
  }

  @override
  FilteredTodosState get initialState {
    return todosBloc.state is TodosLoadSuccess
        ? FilteredTodosLoadSuccess(
            FilterVisibility.all,
            (todosBloc.state as TodosLoadSuccess).todos,
          )
        : FilteredTodosLoadInProgress();
  }

  @override
  Stream<FilteredTodosState> mapEventToState(FilteredTodosEvent event) async* {
    if (event is FilterUpdated) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is TodosUpdated) {
      yield* _mapTodosUpdatedToState(event);
    }
  }

  Stream<FilteredTodosState> _mapUpdateFilterToState(
    FilterUpdated event,
  ) async* {
    if (todosBloc.state is TodosLoadSuccess) {
      yield FilteredTodosLoadSuccess(
        event.filter,
        _mapTodosToFilteredTodos(
          (todosBloc.state as TodosLoadSuccess).todos,
          event.filter,
        ),
      );
    }
  }

  Stream<FilteredTodosState> _mapTodosUpdatedToState(
    TodosUpdated event,
  ) async* {
    final visibilityFilter = state is FilteredTodosLoadSuccess
        ? (state as FilteredTodosLoadSuccess).activeFilter
        : FilterVisibility.all;
    yield FilteredTodosLoadSuccess(
      visibilityFilter,
      _mapTodosToFilteredTodos(
        (todosBloc.state as TodosLoadSuccess).todos,
        visibilityFilter,
      ),
    );
  }

  List<Todo> _mapTodosToFilteredTodos(
      List<Todo> todos, FilterVisibility filter) {
    return todos.where((todo) {
      if (filter == FilterVisibility.all) {
        return true;
      } else if (filter == FilterVisibility.active) {
        return !todo.complete;
      } else {
        return todo.complete;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    todosSubscription.cancel();
    return super.close();
  }
}
