part of 'user_bloc.dart';

@immutable
class UserState {
  final custom.User user;

  UserState({required this.user});
}

class UserLoading extends UserState {
  UserLoading({required super.user});
}

class UserInitial extends UserState {
  UserInitial({required super.user});
}
