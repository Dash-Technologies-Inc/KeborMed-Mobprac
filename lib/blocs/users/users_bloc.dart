import 'package:bloc/bloc.dart';
import 'package:kebormed_mobile/data/models/user_model.dart';
import 'package:kebormed_mobile/data/network/api_response.dart';
import 'package:kebormed_mobile/data/repositories/users_repository.dart';
import 'package:equatable/equatable.dart';

part 'users_event.dart';

part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersRepository usersRepository;

  UsersBloc({required this.usersRepository}) : super(UsersState(userList: ApiResponse.loading())) {
    on<UsersFetch>(fetchUserApiCall);
  }

  Future<void> fetchUserApiCall(UsersFetch event, Emitter<UsersState> emit) async {
    await usersRepository.fetchUsers().then((response) {
      emit(state.copyWith(userList: ApiResponse.completed(response)));
    }).onError((error, stackTrace) {
      emit(state.copyWith(userList: ApiResponse.error(error.toString())));
    });
  }
}
