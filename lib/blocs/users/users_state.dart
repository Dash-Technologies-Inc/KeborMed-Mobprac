part of 'users_bloc.dart';

class UsersState extends Equatable {

  final ApiResponse<List<User>> userList;

  const UsersState({required this.userList});

  UsersState copyWith({ApiResponse<List<User>>? userList}){
    return UsersState(userList: userList??this.userList);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [userList];

}

