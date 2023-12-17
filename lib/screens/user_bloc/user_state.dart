part of 'user_bloc.dart';

class UserNetworkState {
  final List<UserDto> userList;

  const UserNetworkState({
    this.userList = const [],
  });
}

class UserNetworkState1 {
  final UserDto? user;

  UserNetworkState1({this.user});
}
