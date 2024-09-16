import 'dart:async';

import 'package:dart/dto/user_dto.dart';
import 'package:dart/main.dart';
import 'package:dart/server/rest_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserListBloc extends Bloc<UserNetworkEvent, UserNetworkState> {
  final RestClient _networkRepository;

  UserListBloc(this._networkRepository) : super(const UserNetworkState()) {
    on<LoginEvent>(_getUserList);
    // on<SignupEvent>(_addUser as EventHandler<SignupEvent, UserNetworkState>);
  }

  Future<void> _getUserList(
      LoginEvent event, Emitter<UserNetworkState> emit) async {
    final users = await restClient!.getUserList();
    emit(UserNetworkState(userList: users));
  }
}

////////////////////

class UserAddBloc extends Bloc<UserNetworkEvent, UserNetworkState1> {
  final RestClient _networkRepository;

  UserAddBloc(this._networkRepository) : super(UserNetworkState1()) {
    on<SignupEvent>(_addUser);
  }

  Future<void> _addUser(
      SignupEvent event, Emitter<UserNetworkState1> emit) async {
    await restClient!.addUser(event.newUser);
  }
}
