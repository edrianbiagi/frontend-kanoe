import 'package:dio/dio.dart';
import 'package:kanoevaa/config.dart';
import 'package:kanoevaa/models/alunos.dart';

class AlunoRepository {
  final Dio _dio;
  final String baseUrl = Config.baseUrl;

  AlunoRepository() : _dio = Dio();

  Future<List<AlunoModel>> buscaAlunos(String token) async {
    try {
      final response = await _dio.get(
        '$baseUrl/alunos/buscarAluno',
        options: Options(headers: {
          'x-access-token': token,
        }),
      );
      if (response.statusCode == 200) {
        final List<dynamic> alunosJson = response.data;
        return alunosJson
            .map((alunoJson) => AlunoModel.fromJson(alunoJson))
            .toList();
      } else {
        throw Exception('Falha ao carregar alunos');
      }
    } catch (error) {
      throw Exception('Erro na requisição: $error');
    }
  }
}
