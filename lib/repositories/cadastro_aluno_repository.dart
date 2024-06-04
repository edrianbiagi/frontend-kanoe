import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kanoevaa/app_controller.dart';
import 'package:kanoevaa/config.dart';

class CadastroAlunoRepository {
  final Dio _dio;
  final String baseUrl = Config.baseUrl;
  final FlutterSecureStorage armazenamentoSeguro;
  final appController = AppController();

  CadastroAlunoRepository({required this.armazenamentoSeguro}) : _dio = Dio() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers = {
      "Content-Type": "application/json",
    };
    _dio.options.validateStatus = (status) {
      return status != null && status >= 200 && status < 500;
    };
  }

  Future<Map<String, dynamic>> cadAluno({
    required String nome,
    required String email,
    required String telefone,
    required String password,
    required String cpf,
    required String dtNascimento,
    required String profissao,
    required String dtInicio,
    required String numEmergencia,
    required String nomeEmergencia,
    String? obsPatologica,
    String? tratamentoMedico,
    required String obsGerais,
    required String sexo,
    required double valorMensalidade,
    required int diaVencimento,
    required int mensalidadesEmAtraso,
    required bool termoResponsabilidade,
  }) async {
    final body = {
      "nome": nome,
      "email": email,
      "telefone": telefone,
      "password": password,
      "cpf": cpf,
      "dt_nascimento": dtNascimento,
      "profissao": profissao,
      "dt_inicio": dtInicio,
      "num_emergencia": numEmergencia,
      "nome_emergencia": nomeEmergencia,
      "obs_patologica": obsPatologica,
      "tratamento_medico": tratamentoMedico,
      "obs_gerais": obsGerais,
      "sexo": sexo,
      "valor_mensalidade": valorMensalidade,
      "dia_vencimento": diaVencimento,
      "mensalidades_em_atraso": mensalidadesEmAtraso,
      "termo_responsabilidade": termoResponsabilidade,
      "roles": ["alunos"],
      "status": "INATIVO",
    };

    try {
      final response = await _dio.post(
        '/alunos/novoAluno',
        data: json.encode(body),
      );

      print(response);

      if (response.statusCode == 201) {
        return {'statusCode': response.statusCode, 'errorMessage': null};
      } else {
        return {
          'statusCode': response.statusCode,
          'errorMessage': response.data
        };
      }
    } catch (error) {
      return {
        'statusCode': -1,
        'errorMessage': 'Erro ao enviar solicitação HTTP: $error'
      };
    }
  }
}
