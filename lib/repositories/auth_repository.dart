import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kanoevaa/config.dart';

class AuthRepository {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;
  final String baseUrl = Config.baseUrl;

  AuthRepository()
      : _dio = Dio(),
        _secureStorage = FlutterSecureStorage();

  Future<Map<String, dynamic>?> login(
      BuildContext context, String cpf, String password) async {
    try {
      final response = await _dio.post(
        '$baseUrl/auth/login',
        data: jsonEncode(<String, String>{
          'cpf': cpf,
          'password': password,
        }),
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          validateStatus: (status) {
            return status == 200 || status == 401;
          },
        ),
      );

      if (response.statusCode == 200) {
        final token = response.data['accessToken'];
        final idUser = response.data['id'];
        final nomeUsuario = response.data['nome'];
        final idAluno = response.data['alunoId'];
        final mensalidadeAtrasada = response.data['mensalidadesAtrasadas'];
        final roles = response.data['roles'];

        await _secureStorage.write(key: 'token', value: token);
        await _secureStorage.write(key: 'user', value: idUser);
        await _secureStorage.write(key: 'nomeUser', value: nomeUsuario);
        await _secureStorage.write(key: 'aluno', value: idAluno);
        await _secureStorage.write(
            key: 'mensalidade_atrasada', value: mensalidadeAtrasada.toString());
        await _secureStorage.write(key: 'roles', value: jsonEncode(roles));

        return {'success': true, 'message': 'Login successful'};
      } else if (response.statusCode == 401) {
        return {'success': false, 'message': 'Invalid credentials'};
      } else {
        return {'success': false, 'message': 'Unexpected error'};
      }
    } catch (error) {
      print('Error during sign in: $error');
      return {'success': false, 'message': 'Unexpected error'};
    }
  }
}
