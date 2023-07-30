// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Plan {
  final DateTime date;
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
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'income': income,
      'fixedCosts': fixedCosts,
      'varCosts': varCosts,
      'drr': drr,
      'progressiveTotal': progressiveTotal,
      'passiveIncome': passiveIncome,
    };
  }

  factory Plan.fromMap(Map<String, dynamic> map) {
    return Plan(
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
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
