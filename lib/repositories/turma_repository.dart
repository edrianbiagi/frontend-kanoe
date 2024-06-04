import 'package:dio/dio.dart';
import 'package:kanoevaa/config.dart';
import 'package:kanoevaa/model/turmas.dart';

class TurmaRepository {
  final Dio _dio;
  final String baseUrl = Config.baseUrl;

  TurmaRepository() : _dio = Dio();

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
