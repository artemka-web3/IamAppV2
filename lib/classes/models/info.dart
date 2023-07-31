// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Info {
  final String title;
  List<String> quotes;
  List<String> apps;
  List<String> websites;
  List<String> books;
  List<String> films;
  Info({
    required this.title,
    this.quotes = const [],
    this.apps = const [],
    this.websites = const [],
    this.books = const [],
    this.films = const [],
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'quotes': quotes,
      'apps': apps,
      'websites': websites,
      'books': books,
      'films': films,
    };
  }

  factory Info.fromMap(Map<String, dynamic> map) {
    return Info(
      title: map['title'] as String,
      quotes: List<String>.from((map['quotes'] as List<dynamic>)),
      apps: List<String>.from((map['apps'] as List<dynamic>)),
      websites: List<String>.from((map['websites'] as List<dynamic>)),
      books: List<String>.from((map['books'] as List<dynamic>)),
      films: List<String>.from((map['films'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Info.fromJson(String source) =>
      Info.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Info(title: $title, quotes: $quotes, apps: $apps, websites: $websites, books: $books, films: $films)';
  }

  @override
  bool operator ==(covariant Info other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        listEquals(other.quotes, quotes) &&
        listEquals(other.apps, apps) &&
        listEquals(other.websites, websites) &&
        listEquals(other.books, books) &&
        listEquals(other.films, films);
  }

  @override
  int get hashCode {
    return title.hashCode ^
        quotes.hashCode ^
        apps.hashCode ^
        websites.hashCode ^
        books.hashCode ^
        films.hashCode;
  }
}
