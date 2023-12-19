import 'package:dart/dto/user_dto.dart';
import 'package:dart/main.dart';
import 'package:dart/screens/signup_screen.dart';
import 'package:dart/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:fluttertoast/fluttertoast.dart';

import 'user_bloc/user_bloc.dart';

class LoginWidget extends StatefulWidget {
  @override
  LoginWidgetState createState() => LoginWidgetState();
}

class LoginWidgetState extends State<LoginWidget> {
  UserData userData = UserData();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late final UserListBloc _bloc;

  bool? rememberMe = false;

  @override
  void initState() {
    super.initState();
    _bloc = UserListBloc(restClient!);
    autoVer();
    _onLogin();
  }

  void autoVer() async {
    final rememberMe_ = await userData.getRemembermeStatus();
    rememberMe = rememberMe_ ?? false;

    if (rememberMe ?? false) {
      final res = await userData.getUserEmail();
      emailController.text = res ?? '';
      final res1 = await userData.getUserEmail();
      passwordController.text = res1 ?? '';

      // toUserScreen(verification(context, emailController.text, passwordController.text))
    }
  }

  String? verification(
      UserListState context, String emailInput, String passwordInput) {
    UserDto? user;

    if (rememberMe ?? false) {
      userData.setUserData(emailController.text, passwordController.text);
    } else {
      userData.deleteUserData();
    }
    try {
      user = context.userList
          .where((p) => p.email == emailInput && p.password == passwordInput)
          .single;
    } catch (ex) {
      //todo flutter toast
    }

    return user?.id;
  }

  void toUserScreen(String? userId) {
    if (userId != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => UserWidget(userId)));
    }
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
    return BlocBuilder<UserListBloc, UserListState>(
        bloc: _bloc,
        builder: (context, snapshot) {
          // final userList = snapshot.userList;
          // _onLogin();
          return Scaffold(
            extendBody: true,
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
                      decoration: const InputDecoration(
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
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      )),
                ),
                SizedBox(
                  width: 210,
                  height: 50,
                  child: CheckboxListTile(
                    title: const Text('Remember me'),
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
                    onPressed: () async {
                      // _onLogin();
                      toUserScreen(verification(snapshot, emailController.text,
                          passwordController.text));
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

class UserData {
  late SharedPreferences prefs;

  Future<void> getPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> setUserData(String email, String password) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setBool('rememberme', true);
  }

  Future<void> deleteUserData() async {
    prefs = await SharedPreferences.getInstance();

    await prefs.remove('email');
    await prefs.remove('password');
    await prefs.remove('rememberme');
  }

  Future<String?> getUserEmail() async {
    prefs = await SharedPreferences.getInstance();

    return prefs.getString('email');
  }

  Future<String?> getUserPassword() async {
    prefs = await SharedPreferences.getInstance();

    return prefs.getString('password');
  }

  Future<bool?> getRemembermeStatus() async {
    prefs = await SharedPreferences.getInstance();

    return prefs.getBool('rememberme');
  }
}
