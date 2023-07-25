// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

///Дело дня
class Case {
  ///Лягушка дня
  final List<String>? frogs;

  ///Др
  final List<String>? birthdays;

  ///Встречи и звонки
  final List<String>? calls;

  ///Задачи
  final List<String>? tasks;

  ///успехи дня
  final List<String>? successes;
  Case({
    this.frogs,
    this.birthdays,
    this.calls,
    this.tasks,
    this.successes,
  });

  Case copyWith({
    List<String>? frogs,
    List<String>? birthdays,
    List<String>? calls,
    List<String>? tasks,
    List<String>? successes,
  }) {
    return Case(
      frogs: frogs ?? this.frogs,
      birthdays: birthdays ?? this.birthdays,
      calls: calls ?? this.calls,
      tasks: tasks ?? this.tasks,
      successes: successes ?? this.successes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'frogs': frogs,
      'birthdays': birthdays,
      'calls': calls,
      'tasks': tasks,
      'successes': successes,
    };
  }

  factory Case.fromMap(Map<String, dynamic> map) {
    return Case(
      frogs: map['frogs'] != null
          ? List<String>.from((map['frogs'] as List<String>))
          : null,
      birthdays: map['birthdays'] != null
          ? List<String>.from((map['birthdays'] as List<String>))
          : null,
      calls: map['calls'] != null
          ? List<String>.from((map['calls'] as List<String>))
          : null,
      tasks: map['tasks'] != null
          ? List<String>.from((map['tasks'] as List<String>))
          : null,
      successes: map['successes'] != null
          ? List<String>.from((map['successes'] as List<String>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Case.fromJson(String source) =>
      Case.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Case(frogs: $frogs, birthdays: $birthdays, calls: $calls, tasks: $tasks, successes: $successes)';
  }

  @override
  bool operator ==(covariant Case other) {
    if (identical(this, other)) return true;

    return listEquals(other.frogs, frogs) &&
        listEquals(other.birthdays, birthdays) &&
        listEquals(other.calls, calls) &&
        listEquals(other.tasks, tasks) &&
        listEquals(other.successes, successes);
  }

  @override
  int get hashCode {
    return frogs.hashCode ^
        birthdays.hashCode ^
        calls.hashCode ^
        tasks.hashCode ^
        successes.hashCode;
  }
}
