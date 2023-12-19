import 'dart:async';

import 'package:dart/dto/user_dto.dart';
import 'package:dart/main.dart';
import 'package:dart/server/rest_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserListBloc extends Bloc<UserNetworkEvent, UserListState> {
  final RestClient _networkRepository;

  UserListBloc(this._networkRepository) : super(const UserListState()) {
    on<LoginEvent>(_getUserList);
    // on<SignupEvent>(_addUser as EventHandler<SignupEvent, UserNetworkState>);
  }

  Future<void> _getUserList(
      LoginEvent event, Emitter<UserListState> emit) async {
    final users = await restClient!.getUserList();
    emit(UserListState(userList: users));
  }
}

////////////////////

class UserAddBloc extends Bloc<UserNetworkEvent, UserDtoState> {
  final RestClient _networkRepository;

  UserAddBloc(this._networkRepository) : super(UserDtoState()) {
    on<SignupEvent>(_addUser);
  }

  Future<void> _addUser(SignupEvent event, Emitter<UserDtoState> emit) async {
    await restClient!.addUser(event.newUser);
  }
}
