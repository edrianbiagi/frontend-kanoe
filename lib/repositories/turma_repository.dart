import 'dart:convert';
import 'package:auth_screen/config.dart';
import 'package:auth_screen/model/turmas.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TurmaRepository {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;
  final String baseUrl = Config.baseUrl;


  TurmaRepository()
      : _dio = Dio(),
        _secureStorage = FlutterSecureStorage();

  Future<List<Turma>> buscarTurmas(String token) async {
    try {
      final response = await _dio.get(
        '$baseUrl/turma/buscarTurmas',
        options: Options(headers: {
          'x-access-token': token,
        }),
      );
      if (response.statusCode == 200) {
        final List<dynamic> turmasJson = response.data;
        return turmasJson
            .map((turmaJson) => Turma.fromJson(turmaJson))
            .toList();
      } else {
        throw Exception('Falha ao carregar turmas');
      }
    } catch (error) {
      throw Exception('Erro na requisição: $error');
    }
  }
}
