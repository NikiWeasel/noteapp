// import 'package:flutter/material.dart';
// import 'stuff.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:getwidget/getwidget.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:convert';
// import 'package:crypto/crypto.dart';
// import 'dart:io';
//
//
// class SignUpWidget extends StatefulWidget {
//   @override
//   State<SignUpWidget> createState() => Note_screen();
//
// }
//
// class Note_screen extends State<SignUpWidget> {
//   late Future<Users> futureUser;
//
//   @override
//   void initState() {
//     super.initState();
//   }
// }
//
//
// void imagePicker() async {
//   ImagePicker picker = ImagePicker();
//   XFile? fileData = await picker.pickImage(source: ImageSource.gallery);
//   // if (fileData=!null){return;}
//
//
//   var imageBytes = await fileData?.readAsBytes();
//   // print(imageBytes);
//   String base64Image = base64Encode(imageBytes!);
//   print(base64Image);
//   // Fluttertoast.showToast(
//   //     msg: base64Image,
//   //     toastLength: Toast.LENGTH_SHORT,
//   //     gravity: ToastGravity.CENTER,
//   //     timeInSecForIosWeb: 1,
//   //     backgroundColor: Colors.red,
//   //     textColor: Colors.white,
//   //     fontSize: 16.0
//   // );
// }