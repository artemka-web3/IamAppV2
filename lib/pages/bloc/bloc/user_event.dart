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
  final bool? onlyDone;
  final String? goalSphere;
  final bool? goalIsDone;
  final bool growGoal;
  GetUserByPhone(
      {required super.phone,
      this.onlyDone,
      this.goalSphere,
      this.goalIsDone,
      this.growGoal = true});
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

class UpdateUser extends UserEvent {
  final Map<String, Object?> param;
  UpdateUser({required super.phone, required this.param});
}

class UpdateGoal extends UserEvent {
  final Goal goal;
  UpdateGoal({required super.phone, required this.goal});
}

class UpdateCase extends UserEvent {
  final Case newCase;
  UpdateCase({
    required super.phone,
    required this.newCase,
  });
}

class AddPlan extends UserEvent {
  final Plan plan;
  final bool isYears;

  AddPlan({required super.phone, required this.plan, required this.isYears});
}

class UpdateIndex extends UserEvent {
  final LifeIndex index;

  UpdateIndex({required super.phone, required this.index});
}

class UpdateInfo extends UserEvent {
  final Info info;

  UpdateInfo({required super.phone, required this.info});
}

class DeleteAcc extends UserEvent {
  DeleteAcc({required super.phone});
}
