// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class LifeIndex {
  final DateTime date;
  List<double>? indexes;

  double get lifeIndex {
    if (indexes != null) {
      double buffer = 0;
      for (var i in indexes!) {
        buffer += i;
      }
      return buffer;
    } else {
      return 0;
    }
  }

  LifeIndex({
    required this.date,
    this.indexes = const [],
  }) {
    if (indexes == null) {
      indexes = [];
      for (var i = 0; i < 20; i++) {
        indexes!.add(0);
      }
    }
  }

  LifeIndex copyWith({
    DateTime? date,
  }) {
    return LifeIndex(
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'indexes': indexes,
    };
  }

  factory LifeIndex.fromMap(Map<String, dynamic> map) {
    return LifeIndex(
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      indexes: (map['indexes'] as List<dynamic>).map((e) {
        return double.parse(e.toString());
      }).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory LifeIndex.fromJson(String source) =>
      LifeIndex.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LifeIndex(date: $date, indexes: $indexes)';

  @override
  bool operator ==(covariant LifeIndex other) {
    if (identical(this, other)) return true;

    return other.date == date && listEquals(other.indexes, indexes);
  }

  @override
  int get hashCode => date.hashCode ^ indexes.hashCode;
}
