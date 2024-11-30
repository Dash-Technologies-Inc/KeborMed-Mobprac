import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
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
    emit(state.copyWith(rememberMe: !state.rememberMe));
  }

  void _loadSavedCredentials(LoadSavedCredentials event, Emitter<LoginState> emit) {
    final username = Preference.getRememberEmail();
    final password = Preference.getRememberPassword();
    final rememberMe = Preference.getRemember();

    emit(state.copyWith(username: username, password: password, rememberMe: rememberMe, loadSavedCredential: rememberMe));
  }

  void _login(LoginSubmitted event, Emitter<LoginState> emit) async {
    // Validate input fields
    String username = event.username;
    String password = event.password;

    String? usernameError = username.isEmpty ? Labels.userNameErrorMessage : null;

    String? passwordError = password.isEmpty ? Labels.passwordErrorMessage : null;

    if (usernameError != null || passwordError != null) {
      emit(state.copyWith(usernameError: usernameError, passwordError: passwordError));
      return;
    }

    // Dummy authentication
    if (username == "test" && password == "Test@123") {
      await Preference.setRemember(state.rememberMe);
      if (state.rememberMe) {
        await Preference.setRememberEmail(username);
        await Preference.setRememberPassword(password);
      }
      String token = generateRandomToken(32);
      await Preference.setToken(token);
      emit(state.copyWith(error: null, loginSuccess: true));
    } else {
      emit(state.copyWith(error: Labels.incorrectCredentialsMessage));
    }
  }
}
