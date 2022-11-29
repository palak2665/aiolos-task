part of 'login_bloc.dart';

abstract class LoginEvent {}

class StatusChange extends LoginEvent {
  LoginStatus status;
  StatusChange(this.status);
}

class LoginInit extends LoginEvent {
  String username;
  String password;
  LoginInit(this.username, this.password);
}
