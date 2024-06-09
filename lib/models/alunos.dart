import 'package:kanoevaa/models/user.dart';

class AlunoModel {
  final String id;
  final String dtNascimento;
  final String profissao;
  final String numEmergencia;
  final String dtInicio;
  final String nomeEmergencia;
  final String sexo;
  final String obsPatologica;
  final String planoSaude;
  final String tratamentoMedico;
  final String obsGerais;
  final bool termoResponsabilidade;
  final double valorMensalidade;
  final int diaVencimento;
  final int mensalidadesEmAtraso;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel user;

  AlunoModel({
    required this.id,
    required this.dtNascimento,
    required this.profissao,
    required this.numEmergencia,
    required this.dtInicio,
    required this.nomeEmergencia,
    required this.sexo,
    required this.obsPatologica,
    required this.planoSaude,
    required this.tratamentoMedico,
    required this.obsGerais,
    required this.termoResponsabilidade,
    required this.valorMensalidade,
    required this.diaVencimento,
    required this.mensalidadesEmAtraso,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory AlunoModel.fromJson(Map<String, dynamic> json) {
    return AlunoModel(
      id: json['id'],
      dtNascimento: json['dt_nascimento'],
      profissao: json['profissao'],
      numEmergencia: json['num_emergencia'],
      dtInicio: json['dt_inicio'],
      nomeEmergencia: json['nome_emergencia'],
      sexo: json['sexo'],
      obsPatologica: json['obs_patologica'],
      planoSaude: json['plano_saude'],
      tratamentoMedico: json['tratamento_medico'],
      obsGerais: json['obs_gerais'],
      termoResponsabilidade: json['termo_responsabilidade'],
      valorMensalidade: double.parse(json['valor_mensalidade']),
      diaVencimento: json['dia_vencimento'],
      mensalidadesEmAtraso: json['mensalidades_em_atraso'] is int
          ? json['mensalidades_em_atraso']
          : 0, // Verifica se é um inteiro, senão atribui 0
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      user: UserModel.fromJson(json['user']),
    );
  }
}
