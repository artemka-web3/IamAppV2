import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_am_app/classes/models/case.dart';
import 'package:i_am_app/classes/models/goal.dart';
import 'package:i_am_app/classes/models/life_index.dart';
import 'package:i_am_app/classes/models/plan.dart';
import 'package:i_am_app/classes/models/user.dart' as custom;
import 'package:i_am_app/classes/services/firebase_realtime_service.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseDatabaseService databaseService = FirebaseDatabaseService();

  UserBloc() : super(UserState(user: custom.User(phone: '-1'))) {
    on<UpdateUser>(
      (event, emit) async {
        try {
          emit(UserLoading(user: state.user));
          await databaseService.updateUser(event.phone, event.param);
          custom.User user = await databaseService.getUser(event.phone);
          emit(UserInitial(user: user));
        } catch (e) {
          print(e);
        }
      },
    );

    on<UpdateBirthday>(
      (event, emit) async {
        emit(UserLoading(user: state.user));
        await databaseService.updateUser(event.phone, event.value);
        emit(
          UserInitial(
            user: state.user.copyWith(
              birth: DateTime.fromMillisecondsSinceEpoch(
                  event.value['birth'] as int),
            ),
          ),
        );
      },
    );
    on<GetUserByPhone>((event, emit) async {
      emit(UserLoading(user: state.user));
      custom.User user = await databaseService.getUser(event.phone);
      if (event.onlyDone != null) {
        if (event.onlyDone!) {
          for (var i = 0; i < user.cases.length; i++) {
            user.cases[i].frogs.removeWhere((element) =>
                element.isTicked == null || element.isTicked == false);
            user.cases[i].birthdays.removeWhere((element) =>
                element.isTicked == null || element.isTicked == false);
            user.cases[i].calls.removeWhere((element) =>
                element.isTicked == null || element.isTicked == false);
            user.cases[i].tasks.removeWhere((element) =>
                element.isTicked == null || element.isTicked == false);
            user.cases[i].successes.removeWhere((element) =>
                element.isTicked == null || element.isTicked == false);
          }
        } else {
          for (var i = 0; i < user.cases.length; i++) {
            user.cases[i].frogs
                .removeWhere((element) => element.isTicked == true);
            user.cases[i].birthdays
                .removeWhere((element) => element.isTicked == true);
            user.cases[i].calls
                .removeWhere((element) => element.isTicked == true);
            user.cases[i].tasks
                .removeWhere((element) => element.isTicked == true);
            user.cases[i].successes
                .removeWhere((element) => element.isTicked == true);
          }
        }
      }
      emit(
        UserInitial(user: user),
      );
    });
    on<AddGoal>((event, emit) async {
      emit(UserLoading(user: state.user));
      await databaseService.addGoal(event.phone, event.goal);
      custom.User user = await databaseService.getUser(event.phone);
      emit(UserInitial(user: user));
    });
    on<UpdateIndex>((event, emit) async {
      emit(UserLoading(user: state.user));
      await databaseService.addIndex(event.phone, event.index);
      custom.User user = await databaseService.getUser(event.phone);
      emit(UserInitial(user: user));
    });
    on<AddCase>((event, emit) async {
      emit(UserLoading(user: state.user));
      await databaseService.addCase(event.phone, event.newCase);
      custom.User user = await databaseService.getUser(event.phone);
      emit(UserInitial(user: user));
    });

    on<AddPlan>((event, emit) async {
      emit(UserLoading(user: state.user));
      await databaseService.addPlan(event.phone, event.plan, event.isYears);
      custom.User user = await databaseService.getUser(event.phone);
      emit(UserInitial(user: user));
    });

    on<DeleteGoal>((event, emit) async {
      emit(UserLoading(user: state.user));
      await databaseService.deleteGoal(event.phone, event.goalKey);
      custom.User user = await databaseService.getUser(event.phone);
      emit(UserInitial(user: state.user));
    });
    on<DeleteCase>((event, emit) async {
      emit(UserLoading(user: state.user));
      await databaseService.deleteCase(event.phone, event.caseKey);
      custom.User user = await databaseService.getUser(event.phone);
      emit(UserInitial(user: state.user));
    });
    on<UpdateGoal>((event, emit) async {
      await databaseService.updateGoal(event.phone, event.goal);
      custom.User user = await databaseService.getUser(event.phone);
      emit(UserInitial(user: state.user));
    });
    on<UpdateCase>((event, emit) async {
      await databaseService.updateCase(event.phone, event.newCase);
      custom.User user = await databaseService.getUser(event.phone);
      emit(UserInitial(user: state.user));
    });
  }
}
