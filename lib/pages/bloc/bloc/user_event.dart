part of 'user_bloc.dart';

@immutable
abstract class UserEvent {
  final String phone;

  UserEvent({required this.phone});
}

class UpdateBirthday extends UserEvent {
  final Map<String, Object?> value;

  UpdateBirthday({required super.phone, required this.value});
}

class GetUserByPhone extends UserEvent {
  GetUserByPhone({required super.phone});
}

class AddGoal extends UserEvent {
  final Goal goal;
  AddGoal({required this.goal, required super.phone});
}

class AddCase extends UserEvent {
  final Case newCase;
  AddCase({required this.newCase, required super.phone});
}

class GetGoalList extends UserEvent {
  GetGoalList({required super.phone});
}

class DeleteGoal extends UserEvent {
  final String goalKey;
  DeleteGoal({required super.phone, required this.goalKey});
}

class GetCaseList extends UserEvent {
  GetCaseList({required super.phone});
}

class DeleteCase extends UserEvent {
  final String caseKey;
  DeleteCase({required super.phone, required this.caseKey});
}
