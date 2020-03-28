import 'package:uuid/uuid.dart';
import 'package:equatable/equatable.dart';

import 'package:bloc_todo/data/models/todo_entity.dart';

class Todo extends Equatable {
  final String id;
  final String task;
  final String note;
  final bool complete;

  Todo(
    this.task, {
    String id,
    String note,
    this.complete = false,
  })  : this.note = note ?? '',
        this.id = id ?? Uuid().v4();

  Todo copyWith({bool complete, String id, String note, String task}) {
    return Todo(
      task ?? this.task,
      id: id ?? this.id,
      note: note ?? this.note,
      complete: complete ?? this.complete,
    );
  }

  @override
  List<Object> get props => [id, task, note, complete];

  @override
  String toString() {
    return 'Todo { id: $id, task: $task, note: $note, complete: $complete }';
  }

  TodoEntity toEntity() {
    return TodoEntity(id, task, note, complete);
  }

  static Todo fromEntity(TodoEntity entity) {
    return Todo(
      entity.task,
      id: entity.id ?? Uuid().v4(),
      note: entity.note,
      complete: entity.complete ?? false,
    );
  }
}
