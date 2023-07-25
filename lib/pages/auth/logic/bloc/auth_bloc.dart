import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_app/pages/auth/logic/authentication_repository.dart';

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
        await phoneAuthRepository.verifyPhone(
          phoneNumber: event.number,
          verificationCompleted: (PhoneAuthCredential credential) async {
            //В [verificationComplete] мы получим учетные данные из firebase и отправим их в событие [OnPhoneAuthVerificationCompleteEvent], которое будет обработано блоком, а затем выдадим состояние [PhoneAuthVerified] после успешного входа в систему
            add(OnPhoneAuthVerificationCompleteEvent(credential: credential));
          },
          codeSent: (String verificationId, int? resendToken) {
            // На [codeSent] мы получим verificationId и resendToken из firebase и отправим их в событие [OnPhoneOtpSent], которое будет обработано блоком, а затем выдадим событие [OnPhoneAuthVerificationCompleteEvent] после получения кода с телефона пользователя
            add(OnPhoneOtpSent(
                verificationId: verificationId, token: resendToken));
          },
          verificationFailed: (FirebaseAuthException e) {
            // При [verificationFailed] мы получим исключение из firebase и отправим его в событие [Onphoneautherrorrevent], которое будет обработано блоком, а затем выдадим состояние [PhoneAuthError], чтобы отобразить ошибку на экране пользователя
            add(OnPhoneAuthErrorEvent(error: e.code));
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            print("СООБЩЕНИЕ НЕ ОТПРАВЛЕНО ПО ВРЕМЕНИ");
          },
        );
      } catch (e) {
        emit(PhoneAuthError(error: e.toString()));
      }
    });

    // После получения otp, когда пользователь нажимает на кнопку проверки otp, это событие будет запущено
    on<VerifySentOtpEvent>((event, emit) {
      emit(AuthLoading());
      try {
        // После получения otp мы проверим otp, а затем создадим учетные данные из otp и verificationId, а затем отправим их в событие [OnPhoneAuthVerificationCompleteEvent], которое будет обработано блоком, а затем выдаст состояние [PhoneAuthVerified] после успешного входа в систему

        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: event.verificationId,
          smsCode: event.otp,
        );
        add(OnPhoneAuthVerificationCompleteEvent(credential: credential));
      } catch (e) {
        emit(PhoneAuthError(error: e.toString()));
      }
    });

    // Когда firebase отправит код на телефон пользователя, это событие будет запущено
    on<OnPhoneOtpSent>((event, emit) =>
        emit(PhoneAuthCodeSentSuccess(verificationId: event.verificationId)));

    // При возникновении какой-либо ошибки при отправке otp на телефон пользователя будет запущено это событие
    on<OnPhoneAuthErrorEvent>(
        (event, emit) => emit(PhoneAuthError(error: event.error)));

    // Когда проверка otp пройдет успешно, это событие будет запущено
    on<OnPhoneAuthVerificationCompleteEvent>((event, emit) async {
      // После получения учетных данных от события мы войдем в систему с этими учетными данными, а затем выдадим состояние [PhoneAuthVerified] после успешного входа в систему
      try {
        await auth.signInWithCredential(event.credential).then((user) {
          if (user.user != null) {
            emit(PhoneAuthVerified());
          }
        });
      } on FirebaseAuthException catch (e) {
        emit(PhoneAuthError(error: e.code));
      } catch (e) {
        emit(PhoneAuthError(error: e.toString()));
      }
    });
  }
}