part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginAuthenticated extends LoginState {
  Requestapi data;
  LoginAuthenticated(this.data);
}

class LoginFailed extends LoginState {
  String message;
  LoginFailed(this.message);
}

class LoginError extends LoginState {
  String error;
  LoginError(this.error);
}
