part of 'login_bloc.dart';

abstract class LoginEvent {}

class ToggleRememberMe extends LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final String username;
  final String password;
  LoginSubmitted(this.username, this.password);
}

class LoadSavedCredentials extends LoginEvent {}
