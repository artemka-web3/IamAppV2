// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:i_am_app/classes/models/case.dart';

import 'goal.dart';

class User {
  final String phone;
  final String? id;
  final bool? isWoman;
  final DateTime? birth;

  List<Goal> goals;
  List<Case> cases;

  User({
    required this.phone,
    this.id,
    this.isWoman,
    this.birth,
    this.goals = const [],
    this.cases = const [],
  });

  User copyWith({
    String? phone,
    String? id,
    bool? isWoman,
    DateTime? birth,
    List<Goal>? goals,
    List<Case>? cases,
  }) {
    return User(
      phone: phone ?? this.phone,
      id: id ?? this.id,
      isWoman: isWoman ?? this.isWoman,
      birth: birth ?? this.birth,
      goals: goals ?? this.goals,
      cases: cases ?? this.cases,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phone': phone,
      'id': id,
      'isWoman': isWoman,
      'birth': birth?.millisecondsSinceEpoch,
      'goals': goals.map((x) => x.toMap()).toList(),
      'cases': cases.map((x) => x.toMap()).toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      phone: map['phone'] as String,
      id: map['id'] as String,
      isWoman: map['isWoman'] != null ? map['isWoman'] as bool : null,
      birth: map['birth'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['birth'] as int)
          : null,
      goals: map['goals'] != null
          ? (map['goals'] as Map<String, dynamic>)
              .entries
              .map((e) => Goal.fromMap(e.value))
              .toList()
          : [],
      cases: map['cases'] != null
          ? (map['cases'] as Map<String, dynamic>)
              .entries
              .map((e) => Case.fromMap(e.value))
              .toList()
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(phone: $phone, id: $id, isWoman: $isWoman, birth: $birth, goals: $goals, cases: $cases)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.phone == phone &&
        other.id == id &&
        other.isWoman == isWoman &&
        other.birth == birth &&
        listEquals(other.goals, goals) &&
        listEquals(other.cases, cases);
  }

  @override
  int get hashCode {
    return phone.hashCode ^
        id.hashCode ^
        isWoman.hashCode ^
        birth.hashCode ^
        goals.hashCode ^
        cases.hashCode;
  }
}