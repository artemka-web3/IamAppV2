// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:i_am_app/classes/models/case.dart';
import 'package:i_am_app/classes/models/goal.dart';
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
      await ref.child('users/$phone/cases').push().set(newCase.toMap());
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
}
