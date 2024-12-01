import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kebormed_mobile/blocs/login/login_bloc.dart';
import 'package:kebormed_mobile/common/app_dimens.dart';
import 'package:kebormed_mobile/common/app_routes.dart';
import 'package:kebormed_mobile/common/labels.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/common_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(
          Labels.loginLabel,
          style: theme.textTheme.headlineMedium,
        ),
      ),
      body: BlocProvider(
          create: (_) => LoginBloc()..add(LoadSavedCredentials()),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.loginSuccess) {
                Get.offAllNamed(AppRoutes.home);
              } else if (state.error != null) {
                print(state.toString());
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error!)),
                );
              }
            },
            builder: (context, state) {
              final bloc = context.read<LoginBloc>();
              if (state.loadSavedCredential) {
                _usernameController.text = state.username ?? '';
                _passwordController.text = state.password ?? '';
              }
              return Padding(
                padding: const EdgeInsets.all(AppDimens.padding16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      Labels.loginContinueMessage,
                      style: theme.textTheme.titleLarge,
                    ),
                    SizedBox(height: AppDimens.padding16),
                    CommonTextField(
                      controller: _usernameController,
                      labelText: Labels.email,
                      errorText: state.usernameError??"",
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: AppDimens.padding16),
                    CommonTextField(
                      textInputAction: TextInputAction.done,
                      labelText: Labels.password,
                      errorText: state.passwordError??"",
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    SizedBox(height: AppDimens.padding16),
                    Row(
                      children: [
                        Checkbox(
                          value: state.rememberMe,
                          onChanged: (value) => bloc.add(ToggleRememberMe()),
                        ),
                        Text(
                          Labels.rememberMe,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimens.padding20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.primary),
                        onPressed: state.isLoading
                            ? null
                            : () {
                                bloc.add(LoginSubmitted(
                                  _usernameController.text.trim(),
                                  _passwordController.text.trim(),
                                ));
                              },
                        child: state.isLoading
                            ? CircularProgressIndicator(color: theme.colorScheme.onPrimary)
                            : Text(
                                Labels.loginLabel,
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  color: theme.colorScheme.onPrimary,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
