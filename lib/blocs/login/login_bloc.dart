import 'package:bloc/bloc.dart';
import 'package:kebormed_mobile/common/labels.dart';
import 'package:kebormed_mobile/utils/session/preference.dart';
import 'package:equatable/equatable.dart';
import '../../utils/utils.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<ToggleRememberMe>(_toggleRemember);
    on<LoadSavedCredentials>(_loadSavedCredentials);
    on<LoginSubmitted>(_login);
  }

  void _toggleRemember(ToggleRememberMe event, Emitter<LoginState> emit) {
    emit(state.copyWith(rememberMe: !state.rememberMe, loadSavedCredential: false, error: null,usernameError: state.usernameError,passwordError: state.passwordError));
  }

  void _loadSavedCredentials(LoadSavedCredentials event, Emitter<LoginState> emit) {
    final username = Preference.getRememberEmail();
    final password = Preference.getRememberPassword();
    final rememberMe = Preference.getRemember();
    emit(state.copyWith(username: username, password: password, rememberMe: rememberMe, loadSavedCredential: true));
  }

  void _login(LoginSubmitted event, Emitter<LoginState> emit) async {
    // Reset any previous error state and indicate loading
    emit(state.copyWith(isLoading: true, usernameError: null, passwordError: null, error: null, loadSavedCredential: false));

    // Validate input fields
    final errors = _validateInput(event.username, event.password);
    if (errors['usernameError'] != null || errors['passwordError'] != null) {
      emit(state.copyWith(isLoading: false, usernameError: errors['usernameError'], passwordError: errors['passwordError']));
      return;
    }

    // Dummy authentication
    String username = event.username;
    String password = event.password;
    await Future.delayed(const Duration(seconds: 1)); // Simulate API call delay
    if (username == "test" && password == "Test@123") {
      await Preference.setRemember(state.rememberMe);
      if (state.rememberMe) {
        await Preference.setRememberEmail(username);
        await Preference.setRememberPassword(password);
      }
      await Preference.setToken(generateRandomToken(32));
      emit(state.copyWith(isLoading: false, loginSuccess: true));
    } else {
      emit(state.copyWith(isLoading: false, error: Labels.incorrectCredentialsMessage));
    }
  }

  Map<String, String?> _validateInput(String username, String password) {
    return {
      'usernameError': username.isEmpty ? Labels.userNameErrorMessage : null,
      'passwordError': password.isEmpty ? Labels.passwordErrorMessage : null,
    };
  }
}
