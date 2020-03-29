// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'fr';

  static m0(task) => "\"${task}\" supprimé";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "activeTodos" : MessageLookupByLibrary.simpleMessage("Todos à faire"),
    "addTodo" : MessageLookupByLibrary.simpleMessage("Ajouter un todo"),
    "appTitle" : MessageLookupByLibrary.simpleMessage("Todo"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Annuler"),
    "clearCompleted" : MessageLookupByLibrary.simpleMessage("Suppression terminée"),
    "completedTodos" : MessageLookupByLibrary.simpleMessage("Todos terminés"),
    "delete" : MessageLookupByLibrary.simpleMessage("Supprimer"),
    "deleteTodo" : MessageLookupByLibrary.simpleMessage("Supprimer un Todo"),
    "deleteTodoConfirmation" : MessageLookupByLibrary.simpleMessage("Supprimer ce todo?"),
    "editTodo" : MessageLookupByLibrary.simpleMessage("Modifier un todo"),
    "emptyTodoError" : MessageLookupByLibrary.simpleMessage("Veuillez saisir une tâche"),
    "filterTodos" : MessageLookupByLibrary.simpleMessage("Filtrer les Todos"),
    "markAllComplete" : MessageLookupByLibrary.simpleMessage("Tout terminer"),
    "markAllIncomplete" : MessageLookupByLibrary.simpleMessage("Tout à faire"),
    "newTodoHint" : MessageLookupByLibrary.simpleMessage("Qu\'y a t-il à faire ?"),
    "notesHint" : MessageLookupByLibrary.simpleMessage("Notes additionnelles..."),
    "saveChanges" : MessageLookupByLibrary.simpleMessage("Enregistrer les changements"),
    "showActive" : MessageLookupByLibrary.simpleMessage("Afficher à faire"),
    "showAll" : MessageLookupByLibrary.simpleMessage("Afficher tout"),
    "showCompleted" : MessageLookupByLibrary.simpleMessage("Afficher terminés"),
    "stats" : MessageLookupByLibrary.simpleMessage("Stats"),
    "todoDeleted" : m0,
    "todoDetails" : MessageLookupByLibrary.simpleMessage("Détails d\'un Todo"),
    "todos" : MessageLookupByLibrary.simpleMessage("Todos"),
    "undo" : MessageLookupByLibrary.simpleMessage("Annuler")
  };
}
