import 'package:auth_screen/constants.dart';
import 'package:auth_screen/pages/login.dart';
import 'package:auth_screen/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

void main() {
  final authService = AuthService();
  runApp(MyApp(authService: authService));
}

class MyApp extends StatelessWidget {
  final AuthService? authService;

  MyApp({required this.authService});

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
      home: Login(authService: authService!),
    );
  }
}
