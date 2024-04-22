import 'dart:convert';
import 'package:auth_screen/app_controller.dart';
import 'package:auth_screen/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AgendamentoRepository {
  final Dio _dio;
  final String baseUrl = Config.baseUrl;
  final FlutterSecureStorage armazenamentoSeguro;
  final appController = AppController();

  AgendamentoRepository({required this.armazenamentoSeguro}) : _dio = Dio() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers = {
      "Content-Type": "application/json",
    };
    _dio.options.validateStatus = (status) {
      return status != null && status >= 200 && status < 500;
    };
  }

  Future<Map<String, dynamic>> finalizarAgendamento(
      String turmaId, List<Map<String, dynamic>> convidados) async {
    String? token = await armazenamentoSeguro.read(key: 'token');
    String? alunoId = await armazenamentoSeguro.read(key: 'aluno');

    List<String> nomesConvidados =
        convidados.map<String>((convidado) => convidado['id']).toList();

    String convidadosString = json.encode(nomesConvidados);

    final Map<String, dynamic> body = {
      'alunoId': alunoId,
      'turmaId': turmaId,
      'convidados': convidadosString,
    };

    try {
      final response = await _dio.post(
        '$baseUrl/agendamento/agendarAula',
        data: json.encode(body),
        options: Options(headers: {
          "x-access-token": token,
        }),
      );

if (response.statusCode == 201) {
    return {'statusCode': response.statusCode, 'errorMessage': null};
  } else {
    if (response.data != null && response.data is Map<String, dynamic>) {
      // Verifica se a resposta contém a chave 'message'
      if (response.data.containsKey('message')) {
        // Obtém a mensagem de erro do servidor
        final errorMessage = response.data['message'].toString();
        return {'statusCode': response.statusCode, 'errorMessage': errorMessage};
      } else {
        // Se não houver uma mensagem específica, retorna um erro genérico
        return {'statusCode': response.statusCode, 'errorMessage': 'Erro desconhecido'};
      }
    } else {
      // Se a resposta não contém dados ou não é um mapa, retorna um erro genérico
      return {'statusCode': response.statusCode, 'errorMessage': 'Erro desconhecido'};
    }
  }
} catch (error) {
  return {'statusCode': -1, 'errorMessage': 'Erro ao enviar solicitação HTTP: $error'};
}
  }
}
