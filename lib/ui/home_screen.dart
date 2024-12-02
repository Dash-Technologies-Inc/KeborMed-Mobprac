import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kebormed_mobile/blocs/users/users_bloc.dart';
import 'package:kebormed_mobile/common/app_routes.dart';
import 'package:kebormed_mobile/data/models/user_model.dart';
import 'package:kebormed_mobile/data/network/api_response.dart';
import 'package:kebormed_mobile/data/repositories/users_repository.dart';
import '../common/app_dimens.dart';
import '../common/labels.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(
          Labels.userLabel,
          style: theme.textTheme.headlineMedium,
        ),
      ),
      body: BlocProvider(
        create: (_) => UsersBloc(usersRepository: UsersRepository())..add(UsersFetch()),
        child: BlocBuilder<UsersBloc, UsersState>(
          buildWhen: (previous, current) => previous.userList != current.userList,
          builder: (context, state) {
            switch (state.userList.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator.adaptive());
              case Status.error:
                return errorWidget(context, state);
              case Status.completed:
                if (state.userList.data == null || state.userList.data!.isEmpty) {
                  return noDataWidget(context);
                }
                final userList = state.userList.data!;
                return listWidget(context, userList);
              default:
                return noDataWidget(context);
            }
          },
        ),
      ),
    );
  }

  //error widget for displaying error message and retry option
  Widget errorWidget(BuildContext context, UsersState state) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, size: AppDimens.iconSize, color: theme.colorScheme.error),
          const SizedBox(height: AppDimens.padding16),
          Text(
            state.userList.message ?? Labels.errorLabel,
            style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.error),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimens.padding16),
          ElevatedButton(
            onPressed: () {
              context.read<UsersBloc>().add(UsersFetch());
            },
            child: const Text(Labels.retryLabel),
          ),
        ],
      ),
    );
  }

  //no data widget when api will not provide data
  Widget noDataWidget(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_off, size: AppDimens.iconSize, color: theme.colorScheme.onSurface.withOpacity(0.6)),
          const SizedBox(height: AppDimens.padding16),
          Text(
            Labels.noDataLabel,
            style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface),
          ),
        ],
      ),
    );
  }

  //user list widget
  Widget listWidget(BuildContext context, List<User> userList) {
    final theme = Theme.of(context);
    return RefreshIndicator(
      onRefresh: () async {
        context.read<UsersBloc>().add(UsersFetch());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.padding08),
        child: ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              final user = userList[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: theme.colorScheme.primary,
                    child: Text(user.name![0], style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white)),
                  ),
                  title: Text(
                    user.name!,
                    style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                  ), // Title of the movie
                  subtitle: Text(
                    user.email!,
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7)),
                  ),
                  onTap: () {
                    Get.toNamed(AppRoutes.userDetails, arguments: [user]);
                  }, // Network of the movie
                ),
              );
            }),
      ),
    );
  }
}
