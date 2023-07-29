// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Goal {
  bool? isTicked;
  //Название
  final String? title;
  //Дата
  final DateTime? date;
  //Сфера
  final String? sphere;
  //Описание
  final String? description;

  Goal({
    this.isTicked,
    this.title,
    this.date,
    this.sphere,
    this.description,
  });

  Goal copyWith({
    String? title,
    DateTime? date,
    String? sphere,
    String? description,
  }) {
    return Goal(
      title: title ?? this.title,
      date: date ?? this.date,
      sphere: sphere ?? this.sphere,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ticked': isTicked,
      'title': title,
      'date': date?.millisecondsSinceEpoch,
      'sphere': sphere,
      'description': description,
    };
  }

  factory Goal.fromMap(Map<String, dynamic> map) {
    return Goal(
      isTicked: map['ticked'] != null ? map['ticked'] as bool : null,
      title: map['title'] != null ? map['title'] as String : null,
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'] as int)
          : null,
      sphere: map['sphere'] != null ? map['sphere'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Goal.fromJson(String source) =>
      Goal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Goal(title: $title, date: $date, sphere: $sphere, description: $description)';
  }

  @override
  bool operator ==(covariant Goal other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.date == date &&
        other.sphere == sphere &&
        other.description == description;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        date.hashCode ^
        sphere.hashCode ^
        description.hashCode;
  }
}
