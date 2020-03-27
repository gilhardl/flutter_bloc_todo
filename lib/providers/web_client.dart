import 'dart:async';

import 'package:bloc_todo/repositories/todos/todo_entity.dart';

class WebClient {
  final Duration delay;

  const WebClient([this.delay = const Duration(milliseconds: 3000)]);

  /// Mock that "fetches" some Todos from a "web service" after a short delay
  Future<List<TodoEntity>> fetchTodos() async {
    return Future.delayed(
        delay,
        () => [
              TodoEntity(
                '1',
                'Buy food for da kitty',
                'With the chickeny bits!',
                false,
              ),
              TodoEntity(
                '2',
                'Find a Red Sea dive trip',
                'Echo vs MY Dream',
                false,
              ),
              TodoEntity(
                '3',
                'Book flights to Egypt',
                '',
                true,
              ),
              TodoEntity(
                '4',
                'Decide on accommodation',
                '',
                false,
              ),
              TodoEntity(
                '5',
                'Sip Margaritas',
                'on the beach',
                true,
              ),
            ]);
  }

  Future<bool> postTodos(List<TodoEntity> todos) async {
    return Future.value(true);
  }
}
