import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kanoevaa/app_controller.dart';
import 'package:kanoevaa/config.dart';

class RepositorioConvidado {
  final appController = AppController();
  final FlutterSecureStorage armazenamentoSeguro;
  final Dio _dio;
  final String baseUrl = Config.baseUrl;

  RepositorioConvidado({required this.armazenamentoSeguro}) : _dio = Dio();

  Future<List<Map<String, dynamic>>> salvarConvidados(
      List<String> nomesConvidados) async {
    try {
      String? token = await armazenamentoSeguro.read(key: 'token');

      if (token == null) {
        return [];
      }

      List<String> nomesValidos =
          nomesConvidados.where((nome) => nome.isNotEmpty).toList();

      if (nomesValidos.isEmpty) {
        return [];
      }

      String corpoRequisicao = json.encode({"nomes": nomesValidos});

      Options opcoes = Options(headers: {
        "Content-Type": "application/json",
        "x-access-token": token,
      });

      final resposta = await _dio.post(
        "$baseUrl/convidado/novoConvidado",
        data: corpoRequisicao,
        options: opcoes,
      );

      if (resposta.statusCode == 201) {
        List<dynamic> dados = resposta.data;
        List<Map<String, dynamic>> convidadosCriados = [];
        for (var dado in dados) {
          appController.addConvidado(
            dado['nome'],
            dado['id'],
          );
          convidadosCriados.add({
            'id': dado['id'],
            'nome': dado['nome'],
            'criadoPor': dado['criadoPor'],
          });
        }
        return convidadosCriados;
      } else {
        return [];
      }
    } catch (erro) {
      print("Erro ao enviar solicitação HTTP: $erro");
      return [];
    }
  }
}
