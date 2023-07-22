part of 'auth_bloc_bloc.dart';

@immutable
class AuthInitial {}

class PhoneAuthError extends AuthInitial {
  final String error;

  PhoneAuthError({required this.error});
}

class PhoneAuthVerified extends AuthInitial {}

class PhoneAuthCodeSentSuccess extends AuthInitial {
  final String verificationId;
  PhoneAuthCodeSentSuccess({
    required this.verificationId,
  });
}
