import 'dart:async';
import 'dart:core';
import 'package:meta/meta.dart';

import 'package:bloc_todo/models/todo_entity.dart';
import 'package:bloc_todo/providers/web_client.dart';
import 'package:bloc_todo/providers/file_storage.dart';

class TodosRepositoryFlutter {
  final FileStorage fileStorage;
  final WebClient webClient;

  TodosRepositoryFlutter({
    @required this.fileStorage,
    this.webClient = const WebClient(),
  });

  Future<List<TodoEntity>> loadTodos() async {
    try {
      return await fileStorage.loadTodos();
    } catch (e) {
      final todos = await webClient.fetchTodos();

      fileStorage.saveTodos(todos);

      return todos;
    }
  }

  Future saveTodos(List<TodoEntity> todos) {
    return Future.wait<dynamic>([
      fileStorage.saveTodos(todos),
      webClient.postTodos(todos),
    ]);
  }
}
