import 'dart:convert';
import 'package:auth_screen/pages/turma.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:auth_screen/app_controller.dart';

class AuthService {
  final Dio _dio;
  final String baseUrl;
  final FlutterSecureStorage _secureStorage;

  AuthService({required this.baseUrl})
      : _dio = Dio(),
        _secureStorage = FlutterSecureStorage();

  Future<Map<String, dynamic>?> signIn(
      BuildContext context, String cpf, String password) async {
    try {
      final response = await _dio.post(
        '${baseUrl}/auth/login',
        data: jsonEncode(<String, String>{
          'cpf': cpf,
          'password': password,
        }),
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          validateStatus: (status) {
            // Retorna true se o status for 200, 401 ou qualquer outro código de status que você deseja tratar explicitamente
            return status == 200 || status == 401;
          },
        ),
      );

      if (response.statusCode == 200) {
        final token = response.data['accessToken'];
        final idUser = response.data['id'];
        final appController = AppController();
        appController.updateAlunoId(idUser);
        await _secureStorage.write(key: 'token', value: token);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Turmas()),
        );
      } else if (response.statusCode == 401) {
        // Se o status da resposta for 401 (Unauthorized), significa que as credenciais estão incorretas
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login falhou. Verifique suas credenciais.'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        // Se o status da resposta for diferente de 200 e 401, algo inesperado aconteceu
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ocorreu um erro. Por favor, tente novamente mais tarde.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print('Error during sign in: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocorreu um erro. Por favor, tente novamente mais tarde.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
