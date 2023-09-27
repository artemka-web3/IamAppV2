import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_am_app/classes/models/case.dart';
import 'package:i_am_app/classes/models/goal.dart';
import 'package:i_am_app/classes/models/info.dart';
import 'package:i_am_app/classes/models/life_index.dart';
import 'package:i_am_app/classes/models/plan.dart';
import 'package:i_am_app/classes/models/user.dart' as custom;
import 'package:i_am_app/classes/services/firebase_realtime_service.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseDatabaseService databaseService = FirebaseDatabaseService();

  UserBloc() : super(UserState(user: custom.User(phone: '-1'))) {
    on<DeleteAcc>((event, emit) async {
      try {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.remove('phone');
        pref.remove('entered');
        pref.remove('pin');
        FirebaseAuth.instance.signOut();
        await databaseService.deleteAcc(event.phone);
        emit(UserState(user: custom.User(phone: '-1')));
      } catch (e) {
        print(e);
      }
    });

    on<FreeUpdate>((event, emit) => emit(UserState(user: state.user)));

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
      if (event.goalSphere != null) {
        user.goals.removeWhere((element) => element.sphere != event.goalSphere);
      }
      if (event.goalIsDone != null) {
        if (event.goalIsDone == true) {
          user.goals.removeWhere((element) => (element.isTicked != null)
              ? element.isTicked != event.goalIsDone
              : true);
        }
        if (event.goalIsDone == false) {
          user.goals.removeWhere((element) => (element.isTicked != null)
              ? element.isTicked != event.goalIsDone
              : false);
        }
      }
      if (event.growGoal == true) {
        user.goals.sort(((a, b) => a.date!.millisecondsSinceEpoch
            .compareTo(b.date!.millisecondsSinceEpoch)));
      }
      if (event.growGoal == false) {
        user.goals.sort(((a, b) => b.date!.millisecondsSinceEpoch
            .compareTo(a.date!.millisecondsSinceEpoch)));
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
    on<UpdateInfo>((event, emit) async {
      emit(UserLoading(user: state.user));
      await databaseService.updateInfo(event.phone, event.info);
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
      emit(UserInitial(user: state.user));
      await databaseService.updateGoal(event.phone, event.goal);
    });
    on<UpdateCase>((event, emit) async {
      emit(UserInitial(user: state.user));
      await databaseService.updateCase(event.phone, event.newCase);
    });
  }
}
