import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  TodoEntity(this.id, this.task, this.note, this.complete);

  final String id;
  final String task;
  final String note;
  final bool complete;

  @override
  List<Object> get props => [id, task, note, complete];

  @override
  String toString() {
    return 'TodoEntity { id: $id, task: $task, note: $note, complete: $complete }';
  }

  Map<String, Object> toJson() {
    return {
      'id': id,
      'task': task,
      'note': note,
      'complete': complete,
    };
  }

  static TodoEntity fromJson(Map<String, Object> json) {
    return TodoEntity(
      json['id'] as String,
      json['task'] as String,
      json['note'] as String,
      json['complete'] as bool,
    );
  }
}
