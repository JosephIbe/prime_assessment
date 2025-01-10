part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];

}

class LoginEvent extends AuthEvent {

  final LoginParams loginParams;
  const LoginEvent({required this.loginParams});

}

class RegisterUserEvent extends AuthEvent {

  final RegisterParams registerParams;
  const RegisterUserEvent({required this.registerParams});

}

class VerifyEmailEvent extends AuthEvent {

  final VerifyEmailParams verifyEmailParams;
  const VerifyEmailEvent({required this.verifyEmailParams});

}

class BackStackEvent extends AuthEvent {}