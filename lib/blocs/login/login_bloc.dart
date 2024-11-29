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
    on<LoginSubmitted>(_login);
  }

  void _toggleRemember(ToggleRememberMe event, Emitter<LoginState> emit) {
    emit(state.copyWith(rememberMe: !state.rememberMe));
  }

  void _login(LoginSubmitted event, Emitter<LoginState> emit) async {
    // Validate input fields
    String email = event.emailController.text.trim();
    String password = event.passwordController.text.trim();

    String? emailError = email.isEmpty ? Labels.userNameErrorMessage : null;

    String? passwordError = password.isEmpty ? Labels.passwordErrorMessage : null;

    if (emailError != null || passwordError != null) {
      emit(state.copyWith(emailError: emailError, passwordError: passwordError));
      return;
    }

    // Dummy authentication
    if (email == "test" && password == "Test@123") {
      if (state.rememberMe) {
        await Preference.setRememberEmail(email);
        await Preference.setRememberPassword(password);
      }
      String token = generateRandomToken(32);
      await Preference.setToken(token);
      emit(state.copyWith(error: null));
    } else {
      emit(state.copyWith(error: Labels.incorrectCredentialsMessage));
    }
  }
}
