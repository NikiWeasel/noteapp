import 'package:dart/server/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

RestClient? restClient;

void main() {
  final dio = Dio();
  dio.options.baseUrl = 'http://192.168.0.55:8000/';
  //http://localhost:3000/
  //http://10.0.2.2:3000/
  //https://my-json-server.typicode.com/NikiWeasel/demo1/
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
    ),
  );
  restClient = RestClient(dio);
  runApp(MaterialApp(
    theme: ThemeData(
        // colorScheme: ColorScheme.dark(),
        // primaryColor: Colors.black54,
        // hintColor: Colors.red,
        // floatingActionButtonTheme: FloatingActionButtonThemeData.lerp(2, 2, 2),
        ),
    home: LoginWidget(),
  ));
}

/*
*todo: Переименовать getuserlist
ЗАПОМНИ МЕНЯ + кэшировпние
Экран?/
тема
* toast'ы
* проверить исключения dio

json-server --host 192.168.0.106 C:\Users\Dns\Documents\dart_flutter\dart\lib\server\db.json --port 8000
* */
