class Turma {
  final String id;
  final String nome;
  final DateTime data;
  final String hora;
  final int vagasDisponiveis;

  Turma({
    required this.id,
    required this.nome,
    required this.data,
    required this.hora,
    required this.vagasDisponiveis,
  });

  factory Turma.fromJson(Map<String, dynamic> json) {
    return Turma(
      id: json['id'],
      nome: json['nome'],
      data: DateTime.parse(json['data']),
      hora: json['hora'],
      vagasDisponiveis: json['vagas_disponiveis'],
    );
  }
}
