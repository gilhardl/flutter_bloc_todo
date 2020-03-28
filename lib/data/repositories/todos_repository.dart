import 'dart:async';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bloc_todo/data/models/todo_entity.dart';
import 'package:bloc_todo/data/models/todo.dart';

class TodosRepository {
  TodosRepository(String userId)
      : assert(userId != null),
        _todoCollection = Firestore.instance
            .collection('users')
            .document(userId)
            .collection('todos');

  final CollectionReference _todoCollection;

  Stream<List<Todo>> todos() {
    return _todoCollection.snapshots().map<List<Todo>>((snapshot) {
      final res = snapshot.documents
          .map<Todo>((doc) => Todo.fromEntity(TodoEntity.fromSnapshot(doc)))
          .toList();
      print(res);
      return res;
    });
  }

  Future<void> addNewTodo(Todo todo) {
    return _todoCollection.add(todo.toEntity().toDocument());
  }

  Future<void> updateTodo(Todo update) {
    return _todoCollection
        .document(update.id)
        .updateData(update.toEntity().toDocument());
  }

  Future<void> deleteTodo(Todo todo) async {
    return _todoCollection.document(todo.id).delete();
  }
}
