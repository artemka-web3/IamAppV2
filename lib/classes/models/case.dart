// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///Дело дня
class Case {
  //Дата
  final DateTime? date;

  ///Лягушка дня
  final List<Task> frogs;

  ///Др
  final List<Task> birthdays;

  ///Встречи и звонки
  final List<Task> calls;

  ///Задачи
  final List<Task> tasks;

  ///успехи дня
  final List<Task> successes;
  Case({
    this.date,
    this.frogs = const [],
    this.birthdays = const [],
    this.calls = const [],
    this.tasks = const [],
    this.successes = const [],
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date?.millisecondsSinceEpoch,
      'frogs': frogs?.map((e) => e.toMap()).toList(),
      'birthdays': birthdays?.map((e) => e.toMap()).toList(),
      'calls': calls?.map((e) => e.toMap()).toList(),
      'tasks': tasks?.map((e) => e.toMap()).toList(),
      'successes': successes?.map((e) => e.toMap()).toList(),
    };
  }

  factory Case.fromMap(Map<String, dynamic> map) {
    return Case(
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'] as int)
          : null,
      frogs: map['frogs'] != null
          ? (map['frogs'] as List<dynamic>)
              .map(
                (e) => Task.fromMap(e),
              )
              .toList()
          : [],
      birthdays: map['birthdays'] != null
          ? (map['birthdays'] as List<dynamic>)
              .map(
                (e) => Task.fromMap(e),
              )
              .toList()
          : [],
      calls: map['calls'] != null
          ? (map['calls'] as List<dynamic>)
              .map(
                (e) => Task.fromMap(e),
              )
              .toList()
          : [],
      tasks: map['tasks'] != null
          ? (map['tasks'] as List<dynamic>)
              .map(
                (e) => Task.fromMap(e),
              )
              .toList()
          : [],
      successes: map['successes'] != null
          ? (map['successes'] as List<dynamic>)
              .map(
                (e) => Task.fromMap(e),
              )
              .toList()
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Case.fromJson(String source) =>
      Case.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Case(date: $date, frogs: $frogs, birthdays: $birthdays, calls: $calls, tasks: $tasks, successes: $successes)';
  }

  @override
  bool operator ==(covariant Case other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        listEquals(other.frogs, frogs) &&
        listEquals(other.birthdays, birthdays) &&
        listEquals(other.calls, calls) &&
        listEquals(other.tasks, tasks) &&
        listEquals(other.successes, successes);
  }

  @override
  int get hashCode {
    return date.hashCode ^
        frogs.hashCode ^
        birthdays.hashCode ^
        calls.hashCode ^
        tasks.hashCode ^
        successes.hashCode;
  }
}

class Task {
  final String text;
  final TimeOfDay? time;
  bool? isTicked;

  Task({
    required this.text,
    this.time,
    this.isTicked,
  });

  Task copyWith({
    String? task,
    TimeOfDay? time,
  }) {
    return Task(
      text: task ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'task': text,
      'time': (time != null)
          ? '${(time!.hour > 9) ? time!.hour : '0${time!.hour}'}:${(time!.minute > 9) ? time!.minute : '0${time!.minute}'}'
          : null,
      'isTicked': isTicked ?? false,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      text: map['task'] as String,
      time: map['time'] != null
          ? TimeOfDay(
              hour: int.parse(map['time'].split(":")[0]),
              minute: int.parse(map['time'].split(":")[1]))
          : null,
      isTicked: map['isTicked'] != null ? map['isTicked'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Task(task: $text, time: $time)';

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.text == text && other.time == time;
  }

  @override
  int get hashCode => text.hashCode ^ time.hashCode;
}
