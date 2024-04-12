import 'dart:convert';
import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio;
  final String baseUrl;

  AuthService({required this.baseUrl}) : _dio = Dio();

  Future<Map<String, dynamic>?> signIn(String cpf, String password) async {
    try {
      final response = await _dio.post(
        'http://localhost:3000/api/auth/login',
        data: jsonEncode(<String, String>{
          'cpf': cpf,
          'password': password,
        }),
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } catch (error) {
      print('Error during sign in: $error');
      return null;
    }
  }
}
