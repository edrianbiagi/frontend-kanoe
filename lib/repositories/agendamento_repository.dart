import 'dart:convert';
import 'package:auth_screen/app_controller.dart';
import 'package:auth_screen/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AgendamentoRepository {
  final appController = AppController();
  final Dio _dio;
  final String baseUrl = Config.baseUrl;
  final FlutterSecureStorage armazenamentoSeguro;

  AgendamentoRepository({required this.armazenamentoSeguro}) : _dio = Dio();

  Future<void> finalizarAgendamento() async {
    String? token = await armazenamentoSeguro.read(key: 'token');

    try {
      final Map<String, dynamic> body = {
        'alunoId': appController.alunoId,
        'turmaId': appController.idTurma,
        'convidados': appController.convidado,
      };

      Options opcoes = Options(headers: {
        "Content-Type": "application/json",
        "x-access-token": token,
      });

      final response = await _dio.post(
        '$baseUrl/agendamento/novoAgendamento',
        data: json.encode(body),
        options: opcoes,
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception('Falha ao finalizar agendamento');
      }
    } catch (error) {
      throw Exception('Erro ao enviar solicitação HTTP: $error');
    }
  }
}
