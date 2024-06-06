import 'dart:convert';

class Turma {
  final String nome;
  final String data;
  final String hora;
  final int vagasDisponiveis;

  Turma({
    required this.nome,
    required this.data,
    required this.hora,
    required this.vagasDisponiveis,
  });

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'data': data,
      'hora': hora,
      'vagas_disponiveis': vagasDisponiveis,
    };
  }

  factory Turma.fromJson(Map<String, dynamic> json) {
    return Turma(
      nome: json['nome'],
      data: json['data'],
      hora: json['hora'],
      vagasDisponiveis: json['vagas_disponiveis'],
    );
  }
}
