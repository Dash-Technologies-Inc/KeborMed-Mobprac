import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kebormed_mobile/blocs/users/users_bloc.dart';
import 'package:kebormed_mobile/data/network/api_response.dart';
import 'package:kebormed_mobile/data/repositories/users_repository.dart';

import '../common/labels.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
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
                return const Center(child: CircularProgressIndicator());
              case Status.error:
                return errorWidget(context, state);
              case Status.completed:
                if (state.userList.data == null || state.userList.data!.isEmpty) {
                  return Text(
                    'No data found',
                    style: theme.textTheme.bodyLarge,
                  );
                }
                final userList = state.userList.data!;
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<UsersBloc>().add(UsersFetch());
                  },
                  child: ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        final user = userList[index];
                        return Card(
                          child: ListTile(
                            title: Text(user.name!), // Title of the movie
                            subtitle: Text(user.email!),
                            onTap: () {}, // Network of the movie
                          ),
                        );
                      }),
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget errorWidget(BuildContext context, UsersState state) {
    return InkWell(
      onTap: () {
        // Dispatching PostFetched event to trigger fetching movies data
        context.read<UsersBloc>().add(UsersFetch());
      },
      child: Center(
        child: Text(state.userList.message.toString(), style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}
