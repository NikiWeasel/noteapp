import 'package:dart/dto/user_dto.dart';
import 'package:dart/screens/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main.dart';

class SignupWidget extends StatelessWidget {
  SignupWidget({super.key});

  // late final UserNetworkBloc1 _bloc;
  UserAddBloc _bloc = UserAddBloc(restClient!);
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final password1Controller = TextEditingController();

  void _addUser(String username, String email, String password) {
    var newUser = UserDto(username, email, password);
    _bloc.add(SignupEvent(newUser));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAddBloc, UserDtoState>(
        bloc: _bloc,
        builder: (context, snapshot) {
          // final userList = snapshot.user;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Sign Up'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    height: 70,
                    child: TextField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        autofocus: false,
                        maxLength: 15,
                        enabled: true,
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Имя',
                        )),
                  ),
                  SizedBox(
                    width: 250,
                    height: 70,
                    child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        autofocus: false,
                        maxLength: 15,
                        enabled: true,
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'E-mail',
                        )),
                  ),
                  SizedBox(
                    width: 250,
                    height: 70,
                    child: TextField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        autofocus: false,
                        maxLength: 15,
                        enabled: true,
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        )),
                  ),
                  SizedBox(
                    width: 250,
                    height: 70,
                    child: TextField(
                        controller: password1Controller,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        autofocus: false,
                        maxLength: 15,
                        enabled: true,
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Confirm Password',
                        )),
                  ),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      child: const Text('Sign Up'),
                      onPressed: () {
                        try {
                          if (password1Controller.text ==
                              passwordController.text) {
                            _addUser(nameController.text, emailController.text,
                                passwordController.text);
                          }
                        } catch (e) {
                          print(StackTrace.current);
                        }
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
