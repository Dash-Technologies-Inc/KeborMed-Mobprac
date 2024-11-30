part of 'login_bloc.dart';

abstract class LoginEvent {}

class ToggleRememberMe extends LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final String username;
  final String password;
  final bool rememberMe;
  LoginSubmitted(this.username, this.password,this.rememberMe);
}

class LoadSavedCredentials extends LoginEvent {}
