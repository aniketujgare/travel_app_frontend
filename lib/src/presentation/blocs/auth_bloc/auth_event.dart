part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthInitializeEvent extends AuthEvent {}

final class RegisterUserEvent extends AuthEvent {
  final String email;
  final String password;

  const RegisterUserEvent(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}

final class SignInUserEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInUserEvent(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}
