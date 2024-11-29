part of 'login_bloc.dart';

abstract class LoginEvent {}

class ToggleRememberMe extends LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  LoginSubmitted(this.emailController, this.passwordController);
}
