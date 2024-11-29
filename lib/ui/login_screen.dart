import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kebormed_mobile/blocs/login/login_bloc.dart';
import 'package:kebormed_mobile/common/app_dimens.dart';
import 'package:kebormed_mobile/common/app_routes.dart';
import 'package:kebormed_mobile/common/labels.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
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
          create: (_) => LoginBloc(),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.error == null && state.emailError == null && state.passwordError == null) {
                Get.offAllNamed(AppRoutes.home);
              } else if (state.error != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error!)),
                );
              }
            },
            builder: (context, state) {
              final bloc = context.read<LoginBloc>();
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
                    TextField(
                      textInputAction: TextInputAction.next,
                      style: theme.textTheme.bodyLarge,
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelStyle: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                        labelText: Labels.email,
                        errorText: state.emailError, // Error on button click
                      ),
                    ),
                    SizedBox(height: AppDimens.padding16),
                    TextField(
                      textInputAction: TextInputAction.done,
                      style: theme.textTheme.bodyLarge,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelStyle: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                        labelText: Labels.password,
                        errorText: state.passwordError, // Error on button click
                      ),
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
                      width: double.maxFinite,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.primary),
                        onPressed: () {
                          bloc.add(LoginSubmitted(_emailController, _passwordController)); // Pass controllers
                        },
                        child: Text(
                          'Login',
                          style: theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.onPrimary),
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
