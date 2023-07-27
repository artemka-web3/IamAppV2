// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

@immutable
class AuthInitial {}

class PhoneAuthError extends AuthInitial {
  final String error;

  PhoneAuthError({required this.error});
}

class PhoneAuthVerified extends AuthInitial {
  final String phone;
  PhoneAuthVerified({
    required this.phone,
  });
}

class PhoneAuthCodeSentSuccess extends AuthInitial {
  final String verificationId;
  PhoneAuthCodeSentSuccess({
    required this.verificationId,
  });
}

class AuthLoading extends AuthInitial {}
