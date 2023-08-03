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
  final String verificationId;
  final String otp;

  VerifySentOtpEvent(super.phone,
      {required this.verificationId, required this.otp});
}

class OnPhoneOtpSent extends AuthBlocEvent {
  final String verificationId;
  final int? token;

  OnPhoneOtpSent(
    super.phone, {
    required this.verificationId,
    required this.token,
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
