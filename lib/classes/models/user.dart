// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:i_am_app/classes/models/case.dart';
import 'package:i_am_app/classes/models/info.dart';
import 'package:i_am_app/classes/models/plan.dart';
import 'package:i_am_app/classes/models/life_index.dart';

import 'goal.dart';

class User {
  final String phone;
  final String? id;
  final bool? isWoman;
  final DateTime? birth;

  List<LifeIndex> index;

  List<Goal> goals;
  List<Case> cases;

  List<Plan> years;
  List<Plan> month;

  List<Info> info;

  User({
    required this.phone,
    this.id,
    this.isWoman,
    this.birth,
    this.index = const [],
    this.goals = const [],
    this.cases = const [],
    this.years = const [],
    this.month = const [],
    this.info = const [],
  });

  User copyWith({
    String? phone,
    String? id,
    bool? isWoman,
    DateTime? birth,
    List<Goal>? goals,
    List<Case>? cases,
    List<Plan>? years,
    List<Plan>? month,
  }) {
    return User(
      phone: phone ?? this.phone,
      id: id ?? this.id,
      isWoman: isWoman ?? this.isWoman,
      birth: birth ?? this.birth,
      goals: goals ?? this.goals,
      cases: cases ?? this.cases,
      years: years ?? this.years,
      month: month ?? this.month,
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
      'plan_years': years.map((x) => x.toMap()).toList(),
      'plan_month': month.map((x) => x.toMap()).toList(),
      'index': index.map((x) => x.toMap()).toList(),
      'info': info.map((e) => e.toMap()).toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    List<LifeIndex> li = [];
    if (map['index'] != null) {
      if (map['index'] is Map) {
        var buf = map['index'] as Map<String, dynamic>;
        for (var element in buf.values) {
          if (element != null) {
            li.add(LifeIndex.fromMap(element as Map<String, dynamic>));
          }
        }
      }
      if (map['index'] is List) {
        var buf = map['index'] as List<dynamic>;
        for (var element in buf) {
          if (element != null) {
            li.add(LifeIndex.fromMap(element as Map<String, dynamic>));
          }
        }
      }
    }
    var yearsBuf = (map['plan_years'] as Map<String, dynamic>)
        .entries
        .map((e) => Plan.fromMap(e.value))
        .toList();
    var monthBuf = (map['plan_month'] as Map<String, dynamic>)
        .entries
        .map((e) => Plan.fromMap(e.value))
        .toList();
    monthBuf.sort(((a, b) => a.date.month.compareTo(b.date.month)));
    yearsBuf.sort(((a, b) => a.date.millisecondsSinceEpoch
        .compareTo(b.date.millisecondsSinceEpoch)));
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
      years: map['plan_years'] != null ? yearsBuf : [],
      month: map['plan_month'] != null ? monthBuf : [],
      index: li,
      info: map['info'] != null
          ? (map['info'] as Map<String, dynamic>)
              .entries
              .map((e) => Info.fromMap(e.value))
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
