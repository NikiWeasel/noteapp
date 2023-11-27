import 'package:flutter/material.dart';
import 'package:dart/main.dart';


class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 250,
              height: 70,
              child: TextField(
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  autofocus: false,
                  maxLength: 15,
                  enabled: true,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Имя',
                  )
              ),
            ),
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
                    labelText: 'Confirm Password',
                  )
              ),
            ),

            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(

                child: const Text('Sign Up'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}