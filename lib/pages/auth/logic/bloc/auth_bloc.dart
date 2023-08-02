import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_app/classes/models/user.dart' as custom;
import 'package:i_am_app/classes/services/firebase_realtime_service.dart';
import 'package:i_am_app/pages/auth/logic/authentication_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthInitial> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final PhoneAuthRepository phoneAuthRepository;

  AuthBloc({required this.phoneAuthRepository}) : super(AuthInitial()) {
    // Когда пользователь нажмет на кнопку отправки, это событие будет запущено
    on<SendOtpToPhoneEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        FirebaseDatabaseService service = FirebaseDatabaseService();
        String parser = event.phone.replaceAll(RegExp('\\.'), '');
        bool isContaned = await service.contains(parser);
        if (isContaned) {
          await auth.signInWithEmailAndPassword(
              email: event.phone, password: event.password);
        } else {
          await auth.createUserWithEmailAndPassword(
              email: event.phone, password: event.password);
        }
        var subscription;
        subscription = auth.authStateChanges().listen((user) async {
          if (user != null) {
            if (!isContaned) {
              await service.createUser(
                custom.User(
                  phone: parser,
                ),
              );
            }
            await prefs.setBool('entered', true);
            await prefs.setString('phone', parser);
          }
          add(OnPhoneAuthVerificationCompleteEvent(parser));
        });
      } catch (e) {
        emit(PhoneAuthError(error: e.toString()));
      }
    });

    // При возникновении какой-либо ошибки при отправке otp на телефон пользователя будет запущено это событие
    on<OnPhoneAuthErrorEvent>(
        (event, emit) => emit(PhoneAuthError(error: event.error)));

    // Когда проверка otp пройдет успешно, это событие будет запущено
    on<OnPhoneAuthVerificationCompleteEvent>(
      (event, emit) => emit(PhoneAuthVerified(phone: event.phone)),
    );
  }
}
