import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_app/classes/models/user.dart' as custom;
import 'package:i_am_app/classes/services/firebase_realtime_service.dart';
import 'package:i_am_app/pages/auth/logic/authentication_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthInitial> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final PhoneAuthRepository phoneAuthRepository;

  AuthBloc({required this.phoneAuthRepository}) : super(AuthInitial()) {
    on<DeleteAcc>((event, emit) => emit(AuthInitial()));
    // Когда пользователь нажмет на кнопку отправки, это событие будет запущено
    on<SendOtpToPhoneEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final PackageInfo packageInfo = await PackageInfo.fromPlatform();
        var acs = ActionCodeSettings(
          // URL you want to redirect back to. The domain (www.example.com) for this
          // URL must be whitelisted in the Firebase Console.
          url: 'https://iamapp01.page.link/qbvQ',

          androidPackageName: packageInfo.packageName,
          iOSBundleId: packageInfo.packageName,
          // This must be true
          handleCodeInApp: true,
          // installIfNotAvailable
          androidInstallApp: true,
          // minimumVersion
          androidMinimumVersion: '12',
        );
        emit(AuthLoading());

        try {
          await FirebaseAuth.instance.sendSignInLinkToEmail(
            email: event.phone,
            actionCodeSettings: acs,
          );
          final link = await FirebaseDynamicLinks.instance.onLink.first;
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString('link', link.link.toString());
          emit(PhoneAuthCodeSentSuccess());
        } catch (e) {
          print(e);
        }
      } catch (e) {
        emit(PhoneAuthError(error: e.toString()));
      }
    });

    on<VerifySentOtpEvent>(
      (event, emit) async {
        final pref = await SharedPreferences.getInstance();
        final link = pref.getString('link') ?? "-1";
        try {
          if (auth.isSignInWithEmailLink(link)) {
            // The client SDK will parse the code from the link for you.
            await auth
                .signInWithEmailLink(email: event.phone, emailLink: link)
                .then((value) async {
              var userEmail = value.user;
              SharedPreferences prefs = await SharedPreferences.getInstance();
              FirebaseDatabaseService service = FirebaseDatabaseService();
              String parser = event.phone.replaceAll(RegExp('\\.'), '');
              bool isContaned = await service.contains(parser);

              if (!isContaned) {
                await service.createUser(
                  custom.User(
                    phone: parser,
                  ),
                );
              }
              await prefs.setBool('entered', true);
              await prefs.setString('phone', parser);

              add(OnPhoneAuthVerificationCompleteEvent(parser));
            });
          }
        } catch (e) {
          emit(PhoneAuthError(error: e.toString()));
        }
      },
    );

    // При возникновении какой-либо ошибки при отправке otp на телефон пользователя будет запущено это событие
    on<OnPhoneAuthErrorEvent>(
        (event, emit) => emit(PhoneAuthError(error: event.error)));

    // Когда проверка otp пройдет успешно, это событие будет запущено
    on<OnPhoneAuthVerificationCompleteEvent>(
      (event, emit) => emit(PhoneAuthVerified(phone: event.phone)),
    );
  }
}
