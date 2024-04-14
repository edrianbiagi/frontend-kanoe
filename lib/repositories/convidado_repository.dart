import 'dart:convert';

import 'package:auth_screen/app_controller.dart';
import 'package:auth_screen/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RepositorioConvidado {
  final appController = AppController();
  final FlutterSecureStorage armazenamentoSeguro;
  final Dio _dio;
  final String baseUrl = Config.baseUrl;


  RepositorioConvidado({required this.armazenamentoSeguro})
      : _dio = Dio();

Future<List<Map<String, dynamic>>> salvarConvidados(List<String> nomesConvidados, String idUsuario) async {
  try {
    String? token = await armazenamentoSeguro.read(key: 'token');

    if (token == null || idUsuario.isEmpty) {
      return [];
    }

    List<String> nomesValidos =
        nomesConvidados.where((nome) => nome.isNotEmpty).toList();

    if (nomesValidos.isEmpty) {
      return [];
    }

    String corpoRequisicao =
        json.encode({"nomes": nomesValidos, "criadoPor": idUsuario});

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
