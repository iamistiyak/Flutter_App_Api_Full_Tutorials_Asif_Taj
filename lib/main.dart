
import 'package:flutter/material.dart';
import 'package:flutter_app_api_full_tutorials/screens/getAPI/userlist.dart';
import 'package:flutter_app_api_full_tutorials/screens/getAPI/userlist_without_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: UserListWithoutModel(),
    );
  }
}