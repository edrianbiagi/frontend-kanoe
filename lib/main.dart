import 'package:auth_screen/constants.dart';
import 'package:auth_screen/login.dart';
import 'package:auth_screen/services/auth_services.dart';
import 'package:flutter/material.dart';

void main() {
  final authService = AuthService(baseUrl: 'sua_url_base');
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
