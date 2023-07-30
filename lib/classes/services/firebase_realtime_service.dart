// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:i_am_app/classes/models/case.dart';
import 'package:i_am_app/classes/models/goal.dart';
import 'package:i_am_app/classes/models/plan.dart';
import 'package:i_am_app/classes/models/user.dart';

class FirebaseDatabaseService {
  final ref = FirebaseDatabase.instance.ref('');

  Future<void> createUser(User user) async {
    try {
      return await ref.child('users/${user.phone}').set(user.toMap());
    } catch (e) {
      print(e);
    }
  }

  Future<User> getUser(String phone) async {
    try {
      final snapshot = await ref.child('users/$phone').get();
      Map<String, dynamic> body = jsonDecode(jsonEncode(snapshot.value));
      return User.fromMap(body);
    } catch (e) {
      print(e);
      return User(phone: '-1', id: '-1');
    }
  }

  Future<void> updateUser(String phone, Map<String, Object?> value) async {
    try {
      return await ref.child('users/$phone').update(value);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> contains(String phone) async {
    try {
      final snapshot = await ref.child('users/$phone').get();
      if (snapshot.value != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> addGoal(String phone, Goal goal) async {
    try {
      await ref.child('users/$phone/goals').push().set(goal.toMap());
    } catch (e) {
      print(e);
    }
  }

  Future<void> addCase(String phone, Case newCase) async {
    try {
      final snapshot = await ref
          .child('users/$phone/cases/${newCase.date?.millisecondsSinceEpoch}')
          .get();
      if (snapshot.value == null) {
        await ref
            .child('users/$phone/cases/${newCase.date?.millisecondsSinceEpoch}')
            .set(newCase.toMap());
      } else {
        Case ccase = Case.fromMap(
            jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>);
        for (var i = 0; i < newCase.frogs.length; i++) {
          ccase.frogs.add(newCase.frogs[i]);
        }
        for (var i = 0; i < newCase.birthdays.length; i++) {
          ccase.birthdays.add(newCase.birthdays[i]);
        }
        for (var i = 0; i < newCase.calls.length; i++) {
          ccase.calls.add(newCase.calls[i]);
        }
        for (var i = 0; i < newCase.tasks.length; i++) {
          ccase.tasks.add(newCase.tasks[i]);
        }
        for (var i = 0; i < newCase.successes.length; i++) {
          ccase.successes.add(newCase.successes[i]);
        }
        await ref
            .child('users/$phone/cases/${newCase.date?.millisecondsSinceEpoch}')
            .update(ccase.toMap());
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> addPlan(String phone, Plan plan, bool isYears) async {
    try {
      if (isYears) {
        await ref
            .child('users/$phone/plan_years/${plan.date.year}')
            .update(plan.toMap());
      } else {
        await ref
            .child(
                'users/$phone/plan_month/${plan.date.microsecondsSinceEpoch}')
            .update(plan.toMap());
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<Goal>> getGoalList(String phone) async {
    try {
      List<Goal> result = [];
      final snapshot = await ref.child('users/$phone/goals').get();
      Map<String, dynamic> body = jsonDecode(jsonEncode(snapshot.value));
      for (var element in body.keys) {
        result.add(Goal.fromMap(body[element]));
      }
      return result;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> deleteGoal(String phone, String goalKey) async {
    try {
      final snapshot = await ref.child('users/$phone/goals').get();
      Map<String, dynamic> body = jsonDecode(jsonEncode(snapshot.value));
      for (var element in body.keys) {
        if (element == goalKey) {
          await ref.child('users/$phone/goals/$goalKey').remove();
          return true;
        }
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Case>> getCaseList(String phone) async {
    try {
      List<Case> result = [];
      final snapshot = await ref.child('users/$phone/cases').get();
      Map<String, dynamic> body = jsonDecode(jsonEncode(snapshot.value));
      for (var element in body.keys) {
        result.add(Case.fromMap(body[element]));
      }
      return result;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> deleteCase(String phone, String caseKey) async {
    try {
      final snapshot = await ref.child('users/$phone/cases').get();
      Map<String, dynamic> body = jsonDecode(jsonEncode(snapshot.value));
      for (var element in body.keys) {
        if (element == caseKey) {
          await ref.child('users/$phone/cases/$caseKey').remove();
          return true;
        }
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> updateGoal(String phone, Goal goal) async {
    try {
      final snapshot = await ref.child('users/$phone/goals').get();
      Map<String, dynamic> body = jsonDecode(jsonEncode(snapshot.value));
      for (var element in body.keys) {
        final resp = await ref.child('users/$phone/goals/$element').get();
        Map<String, dynamic> respBody = jsonDecode(jsonEncode(resp.value));
        if (respBody.containsValue(goal.description)) {
          ref.child('users/$phone/goals/$element').update(goal.toMap());
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateCase(String phone, Case newCase) async {
    try {
      var resp = await ref
          .child('users/$phone/cases/${newCase.date?.millisecondsSinceEpoch}')
          .update(newCase.toMap());
    } catch (e) {
      print(e);
    }
  }
}
