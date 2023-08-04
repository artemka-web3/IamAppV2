part of 'auth_bloc.dart';

@immutable
abstract class AuthBlocEvent {
  final String phone;

  AuthBlocEvent(this.phone);
}

class DeleteAcc extends AuthBlocEvent {
  DeleteAcc(super.phone);
}

class SendOtpToPhoneEvent extends AuthBlocEvent {
  final String password;
  SendOtpToPhoneEvent(super.phone, this.password);
}

class VerifySentOtpEvent extends AuthBlocEvent {
  VerifySentOtpEvent(super.phone);
}

class OnPhoneOtpSent extends AuthBlocEvent {
  final String link;

  OnPhoneOtpSent(
    super.phone, {
    required this.link,
  });
}

class OnPhoneAuthErrorEvent extends AuthBlocEvent {
  final String error;
  OnPhoneAuthErrorEvent(super.phone, {required this.error});
}

class OnPhoneAuthVerificationCompleteEvent extends AuthBlocEvent {
  OnPhoneAuthVerificationCompleteEvent(
    super.phone,
  );
}
