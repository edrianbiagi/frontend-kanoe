import 'package:flutter/material.dart';
import 'package:kanoevaa/constants.dart';
import 'package:kanoevaa/pages/login.dart';
import 'package:kanoevaa/repositories/auth_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kanoê Vaa',
      theme: ThemeData(
        scaffoldBackgroundColor: kWhiteColor,
        primaryColor: kPrimaryColor,
        textTheme: TextTheme(
          button: TextStyle(fontWeight: FontWeight.bold),
        ),
        inputDecorationTheme:
            InputDecorationTheme(enabledBorder: InputBorder.none),
      ),
      home: LoginPage(),
    );
  }
}
