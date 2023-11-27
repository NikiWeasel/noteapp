import 'package:flutter/material.dart';

import 'package:dart/signup_screen.dart';
import 'package:dart/user_screen.dart';


void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: MyWidget(),
  ));
}


class MyWidget extends StatefulWidget {
  @override
  FirstRoute createState() => FirstRoute();

}

class FirstRoute extends State<MyWidget> {
  // FirstRoute({super.key});
  bool? rememberMe = false;

  void verification(String login, String password){

  }

  void _onRememberMeChanged(bool? newValue) => setState(() {
    rememberMe = newValue;

    if (newValue==null) {throw Exception();}
    if (rememberMe!) {
      // TODO: Here goes your functionality that remembers the user.
    } else {
      // TODO: Forget the user
    }
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/cat.png', width: 320, height:250),
          const SizedBox(
            width: 250,
            height: 70,
            child: TextField(
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                autofocus: false,
                maxLength: 15,
                enabled: true,
                maxLines: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-mail',
                )
            ),
          ),
          const SizedBox(
            width: 250,
            height: 70,
            child: TextField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                autofocus: false,
                maxLength: 15,
                enabled: true,
                maxLines: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                )
            ),
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
                Navigator.push(
                  context,
                  // if (verification(login, password))=>
                  MaterialPageRoute(builder: (context) => SignUpWidget()),
                );
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
                    MaterialPageRoute(builder: (context) => const SecondRoute()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}