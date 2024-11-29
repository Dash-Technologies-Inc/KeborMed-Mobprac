part of 'login_bloc.dart';

class LoginState extends Equatable{
  final bool rememberMe;
  final String? emailError;
  final String? passwordError;
  final String? error;

  const LoginState({
    this.rememberMe = false,
    this.emailError,
    this.passwordError,
    this.error,
  });

  LoginState copyWith({
    bool? rememberMe,
    String? emailError,
    String? passwordError,
    String? error,
  }) {
    return LoginState(
      rememberMe: rememberMe ?? this.rememberMe,
      emailError: emailError,
      passwordError: passwordError,
      error: error,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [rememberMe,emailError,passwordError,error];
}

