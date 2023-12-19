part of 'user_bloc.dart';

class UserListState {
  final List<UserDto> userList;

  const UserListState({
    this.userList = const [],
  });
}

class UserDtoState {
  final UserDto? user;

  UserDtoState({this.user});
}
