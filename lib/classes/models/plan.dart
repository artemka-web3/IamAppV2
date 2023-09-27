// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Node {
  String? category;
  String value;
  Node({
    required this.category,
    required this.value,
  });

  Node copyWith({
    String? category,
    String? value,
  }) {
    return Node(
      category: category ?? this.category,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'value': value,
    };
  }

  factory Node.fromMap(Map<String, dynamic> map) {
    return Node(
      category: map['category'] != null ? map['category'] as String : null,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Node.fromJson(String source) =>
      Node.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Node(category: $category, value: $value)';

  @override
  bool operator ==(covariant Node other) {
    if (identical(this, other)) return true;

    return other.category == category && other.value == value;
  }

  @override
  int get hashCode => category.hashCode ^ value.hashCode;
}

class Plan {
  final DateTime date;

  List<Node> incomeList;
  List<Node> fixedCostsList;
  List<Node> varCostsList;

  final String? income;
  final String? fixedCosts;
  final String? varCosts;
  final String? drr;
  final String? progressiveTotal;
  final String? passiveIncome;

  Plan({
    required this.date,
    this.income,
    this.fixedCosts,
    this.varCosts,
    this.drr,
    this.progressiveTotal,
    this.passiveIncome,
    this.incomeList = const [],
    this.fixedCostsList = const [],
    this.varCostsList = const [],
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': '${date.month}/${date.year}',
      'income': income,
      'fixedCosts': fixedCosts,
      'varCosts': varCosts,
      'drr': drr,
      'progressiveTotal': progressiveTotal,
      'passiveIncome': passiveIncome,
      'income_list': incomeList.map((e) => e.toMap()).toList(),
      'fixed_list': fixedCostsList.map((e) => e.toMap()).toList(),
      'var_list': varCostsList.map((e) => e.toMap()).toList(),
    };
  }

  factory Plan.fromMap(Map<String, dynamic> map) {
    DateTime date = DateTime.now();
    if (map['date'] != null) {
      String buf = map['date'].toString();
      if (map['date'] is int) {
        final dateBuf = DateTime.fromMillisecondsSinceEpoch(map['date'] as int);
        buf = '${dateBuf.month}/${dateBuf.year}';
      }
      for (var i = 0; i < buf.length; i++) {
        if (buf[i] == '/') {
          int year = int.parse(buf.substring(i + 1, buf.length));
          int month = int.parse(buf.substring(0, i));
          date = DateTime(year, month);
          break;
        }
      }
    }
    return Plan(
      date: date,
      income: map['income'] != null ? map['income'] as String : null,
      fixedCosts:
          map['fixedCosts'] != null ? map['fixedCosts'] as String : null,
      varCosts: map['varCosts'] != null ? map['varCosts'] as String : null,
      drr: map['drr'] != null ? map['drr'] as String : null,
      progressiveTotal: map['progressiveTotal'] != null
          ? map['progressiveTotal'] as String
          : null,
      passiveIncome:
          map['passiveIncome'] != null ? map['passiveIncome'] as String : null,
      incomeList: map['income_list'] != null
          ? (map['income_list'] as List<dynamic>)
              .map((e) => Node.fromMap(e))
              .toList()
          : [],
      fixedCostsList: map['fixed_list'] != null
          ? (map['fixed_list'] as List<dynamic>)
              .map((e) => Node.fromMap(e))
              .toList()
          : [],
      varCostsList: map['var_list'] != null
          ? (map['var_list'] as List<dynamic>)
              .map((e) => Node.fromMap(e))
              .toList()
          : [],
    );
  }

  @override
  bool operator ==(covariant Plan other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.income == income &&
        other.fixedCosts == fixedCosts &&
        other.varCosts == varCosts &&
        other.drr == drr &&
        other.progressiveTotal == progressiveTotal &&
        other.passiveIncome == passiveIncome;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        income.hashCode ^
        fixedCosts.hashCode ^
        varCosts.hashCode ^
        drr.hashCode ^
        progressiveTotal.hashCode ^
        passiveIncome.hashCode;
  }
}
