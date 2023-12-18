import 'dart:convert';
import 'dart:typed_data';

import 'package:dart/server/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
        // scaffoldBackgroundColor: Colors.grey,
        // colorScheme: ColorScheme.dark(),

        ),
    home: LoginWidget(),
  ));
}

class Base64 {
  static Uint8List base64decode(String base64String) {
    var uint8image = const Base64Decoder().convert(base64String);
    return uint8image;
  }

  String base64encode(Uint8List uint8image) {
    var base64String = const Base64Encoder().convert(uint8image);
    return base64String;
  }

  Future<String> imagePicker() async {
    final picker = ImagePicker();
    final fileData = await picker.pickImage(source: ImageSource.gallery);
    final imageBytes = await fileData?.readAsBytes();

    var base64Image = base64Encode(imageBytes!);
    return base64Image;
  }
}
