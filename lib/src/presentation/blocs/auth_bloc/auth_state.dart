part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class LoggedInState extends AuthState {
  final UserModel userModel;

  const LoggedInState({required this.userModel});
}

final class SignUpSuccessState extends AuthState {}

final class UnAuthenticatedState extends AuthState {}
