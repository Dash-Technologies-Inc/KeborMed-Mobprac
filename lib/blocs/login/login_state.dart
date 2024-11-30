part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool rememberMe;
  final bool loadSavedCredential;
  final bool loginSuccess;
  final String? username;
  final String? password;
  final String? usernameError;
  final String? passwordError;
  final String? error;

  const LoginState({
    this.rememberMe = false,
    this.loadSavedCredential = false,
    this.loginSuccess = false,
    this.username,
    this.password,
    this.usernameError,
    this.passwordError,
    this.error,
  });

  LoginState copyWith({
    bool? rememberMe,
    bool? loadSavedCredential,
    bool? loginSuccess,
    String? username,
    String? password,
    String? usernameError,
    String? passwordError,
    String? error,
  }) {
    return LoginState(
      rememberMe: rememberMe ?? this.rememberMe,
      loadSavedCredential: loadSavedCredential ?? this.loadSavedCredential,
      loginSuccess: loginSuccess ?? this.loginSuccess,
      username: username ?? this.username,
      password: password ?? this.password,
      usernameError: usernameError ?? this.usernameError,
      passwordError: passwordError ?? this.passwordError,
      error: error ?? this.error,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [rememberMe, loadSavedCredential, loginSuccess, username, password, usernameError, passwordError, error];
}
