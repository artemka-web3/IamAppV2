import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_am_app/classes/models/case.dart';
import 'package:i_am_app/classes/models/goal.dart';
import 'package:i_am_app/classes/models/user.dart' as custom;
import 'package:i_am_app/classes/services/firebase_realtime_service.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseDatabaseService databaseService = FirebaseDatabaseService();

  UserBloc() : super(UserState(user: custom.User(phone: '-1'))) {
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
    on<AddCase>((event, emit) async {
      emit(UserLoading(user: state.user));
      await databaseService.addCase(event.phone, event.newCase);
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
  }
}
