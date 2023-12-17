part of 'user_bloc.dart';

abstract class UserNetworkEvent {
  const UserNetworkEvent();
}

class SignupEvent extends UserNetworkEvent {
  UserDto newUser;

  SignupEvent(this.newUser);
}

class LoginEvent extends UserNetworkEvent {}
