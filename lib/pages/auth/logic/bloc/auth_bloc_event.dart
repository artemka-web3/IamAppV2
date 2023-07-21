part of 'auth_bloc_bloc.dart';

@immutable
abstract class AuthBlocEvent {}

class SendOtpToPhoneEvent extends AuthBlocEvent {
  final String number;

  SendOtpToPhoneEvent({required this.number});
}

class VerifySentOtpEvent extends AuthBlocEvent {
  final String verificationId;
  final String otp;

  VerifySentOtpEvent({required this.verificationId, required this.otp});
}

class OnPhoneOtpSent extends AuthBlocEvent {
  final String verificationId;
  final int? token;

  OnPhoneOtpSent({
    required this.verificationId,
    required this.token,
  });
}

class OnPhoneAuthErrorEvent extends AuthBlocEvent {
  final String error;
  OnPhoneAuthErrorEvent({required this.error});
}

class OnPhoneAuthVerificationCompleteEvent extends AuthBlocEvent {
  final AuthCredential credential;
  OnPhoneAuthVerificationCompleteEvent({
    required this.credential,
  });
}
