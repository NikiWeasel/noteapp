import 'package:dart/dto/user_dto.dart';
import 'package:dart/main.dart';
import 'package:dart/screens/signup_screen.dart';
import 'package:dart/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:fluttertoast/fluttertoast.dart';

import 'user_bloc/user_bloc.dart';

class LoginWidget extends StatefulWidget {
  @override
  LoginWidgetState createState() => LoginWidgetState();
}

class LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late final UserListBloc _bloc;
  bool? rememberMe = false;

  @override
  void initState() {
    super.initState();
    _bloc = UserListBloc(restClient!);
  }

  String? verification(
      UserNetworkState context, String emailInput, String passwordInput) {
    UserDto? user;
    try {
      user = context.userList
          .where((p) => p.email == emailInput && p.password == passwordInput)
          .single;
    } catch (ex) {
      //todo flutter toast
    }

    return user?.id;
  }

  void _onRememberMeChanged(bool? newValue) => setState(() {
        rememberMe = newValue;

        if (newValue == null) {
          throw Exception();
        }
        if (rememberMe!) {
          // TODO: Here goes your functionality that remembers the user.
        } else {
          //TODO: Forget the user
        }
      });

  void _onLogin() {
    _bloc.add(LoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserListBloc, UserNetworkState>(
        bloc: _bloc,
        builder: (context, snapshot) {
          final userList = snapshot.userList;
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/cat.png', width: 320, height: 250),
                SizedBox(
                  width: 250,
                  height: 70,
                  child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      autofocus: false,
                      maxLength: 25,
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
                      maxLength: 25,
                      enabled: true,
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      )),
                ),
                SizedBox(
                  width: 210,
                  height: 50,
                  child: CheckboxListTile(
                    title: const Text("Remember me"),
                    controlAffinity: ListTileControlAffinity.leading,
                    checkColor: Colors.white,
                    value: rememberMe,
                    onChanged: _onRememberMeChanged,
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 40,
                  child: ElevatedButton(
                    child: const Text('Log In'),
                    onPressed: () {
                      _onLogin();
                      var con = verification(snapshot, emailController.text,
                          passwordController.text);
                      if (con != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UserWidget(con)));
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('First time?'),
                    TextButton(
                      child: const Text('Sign Up'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          // if (verification(login, password))=>
                          MaterialPageRoute(
                              builder: (context) => SignupWidget()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
