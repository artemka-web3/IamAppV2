// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///Дело дня
class Case {
  //Выполнено ли
  bool? isDone;
  //Дата
  final DateTime? date;

  ///Лягушка дня
  final List<String>? frogs;

  ///Др
  final List<String>? birthdays;

  ///Встречи и звонки
  final List<String>? calls;

  ///Задачи
  final List<Task>? tasks;

  ///успехи дня
  final List<String>? successes;
  Case({
    this.isDone,
    this.date,
    this.frogs,
    this.birthdays,
    this.calls,
    this.tasks,
    this.successes,
  });

  Case copyWith({
    bool? isDone,
    DateTime? date,
    List<String>? frogs,
    List<String>? birthdays,
    List<String>? calls,
    List<Task>? tasks,
    List<String>? successes,
  }) {
    return Case(
      isDone: isDone ?? this.isDone,
      date: date ?? this.date,
      frogs: frogs ?? this.frogs,
      birthdays: birthdays ?? this.birthdays,
      calls: calls ?? this.calls,
      tasks: tasks ?? this.tasks,
      successes: successes ?? this.successes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isDone': isDone,
      'date': date?.millisecondsSinceEpoch,
      'frogs': frogs,
      'birthdays': birthdays,
      'calls': calls,
      'tasks': tasks?.map((x) => x?.toMap()).toList(),
      'successes': successes,
    };
  }

  factory Case.fromMap(Map<String, dynamic> map) {
    return Case(
      isDone: map['isDone'] != null ? map['isDone'] as bool : null,
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'] as int)
          : null,
      frogs: map['frogs'] != null
          ? List<String>.from((map['frogs'] as List<dynamic>))
          : null,
      birthdays: map['birthdays'] != null
          ? List<String>.from((map['birthdays'] as List<dynamic>))
          : null,
      calls: map['calls'] != null
          ? List<String>.from((map['calls'] as List<dynamic>))
          : null,
      tasks: map['tasks'] != null
          ? (map['tasks'] as List<dynamic>)
              .map(
                (e) => Task.fromMap(e),
              )
              .toList()
          : [],
      successes: map['successes'] != null
          ? List<String>.from((map['successes'] as List<dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Case.fromJson(String source) =>
      Case.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Case(isDone: $isDone, date: $date, frogs: $frogs, birthdays: $birthdays, calls: $calls, tasks: $tasks, successes: $successes)';
  }

  @override
  bool operator ==(covariant Case other) {
    if (identical(this, other)) return true;

    return other.isDone == isDone &&
        other.date == date &&
        listEquals(other.frogs, frogs) &&
        listEquals(other.birthdays, birthdays) &&
        listEquals(other.calls, calls) &&
        listEquals(other.tasks, tasks) &&
        listEquals(other.successes, successes);
  }

  @override
  int get hashCode {
    return isDone.hashCode ^
        date.hashCode ^
        frogs.hashCode ^
        birthdays.hashCode ^
        calls.hashCode ^
        tasks.hashCode ^
        successes.hashCode;
  }
}

class Task {
  final String task;
  final TimeOfDay? time;
  Task({
    required this.task,
    this.time,
  });

  Task copyWith({
    String? task,
    TimeOfDay? time,
  }) {
    return Task(
      task: task ?? this.task,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'task': task,
      'time': (time != null) ? '${time!.hour}:${time!.minute}' : null,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      task: map['task'] as String,
      time: map['time'] != null
          ? TimeOfDay(
              hour: int.parse(map['time'].split(":")[0]),
              minute: int.parse(map['time'].split(":")[1]))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Task(task: $task, time: $time)';

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.task == task && other.time == time;
  }

  @override
  int get hashCode => task.hashCode ^ time.hashCode;
}
