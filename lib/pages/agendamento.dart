import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kanoevaa/app_controller.dart';
import 'package:kanoevaa/pages/turma.dart';
import 'package:kanoevaa/repositories/agendamento_repository.dart';

class Agendamento extends StatefulWidget {
  final String? idTurma;

  const Agendamento({Key? key, required this.idTurma}) : super(key: key);

  @override
  State<Agendamento> createState() => _AgendamentoState();
}

class _AgendamentoState extends State<Agendamento> {
  var opacity = 0.0;
  bool alunoAgendado = false;
  bool position = false;
  final _repositorioAgendamento = AgendamentoRepository(
    armazenamentoSeguro: FlutterSecureStorage(),
  );
  List<TextEditingController> _controllers = [];
  final AppController appController = AppController();
  FlutterSecureStorage? armazenamentoSeguro;

  @override
  void initState() {
    super.initState();
    _verificarAgendamentoAluno();
    Future.delayed(Duration.zero, () {
      animator();
    });
  }

  void animator() {
    setState(() {
      opacity = opacity == 1 ? 0 : 1;
      position = !position;
    });
  }

  Future<void> _verificarAgendamentoAluno() async {
    final bool agendado = await _repositorioAgendamento
        .verificarAgendamentoAluno(widget.idTurma!);
    setState(() {
      alunoAgendado = agendado;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 70),
      height: size.height,
      width: size.width,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: opacity,
        child: Column(
          children: [
            toolbar(),
            SizedBox(
              height: 30,
            ),
            alunoAgendado ? desagendar() : confirmaAgendamento(),
          ],
        ),
      ),
    ));
  }

  Widget toolbar() {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              animator();
              Timer(const Duration(milliseconds: 600), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Turmas(),
                  ),
                );
              });
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
              size: 25,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Agendamento de aula",
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget desagendar() {
    return Container(
      padding: EdgeInsets.all(14),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
            ),
            onPressed: () async {
              try {
                final bool success =
                    await _repositorioAgendamento.desagendarAula();

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Aula desagendada com sucesso!'),
                      backgroundColor: Colors.green,
                    ),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Turmas()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erro ao desagendar aula.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Erro ao desagendar aula: $error'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            icon: Icon(
              Icons.cancel_outlined,
              size: 30,
              color: Colors.red,
            ),
            label: Text(
              'Finalizar agendamento de aula',
              style: TextStyle(
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.normal,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget confirmaAgendamento() {
    return Container(
      padding: EdgeInsets.all(14),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
            ),
            onPressed: () async {
              List<Map<String, dynamic>> convidados = [];

              try {
                final Map<String, dynamic> result =
                    await _repositorioAgendamento.finalizarAgendamento(
                  widget.idTurma!,
                  convidados,
                );

                final statusCode = result['statusCode'];
                final errorMessage = result['errorMessage'];

                if (statusCode == 201) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Agendamento finalizado com sucesso!'),
                      backgroundColor: Colors.green,
                    ),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Turmas(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(errorMessage ?? 'Erro desconhecido'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Erro ao finalizar o agendamento: $error'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            icon: Icon(
              Icons.check_circle_outline,
              size: 30,
              color: Colors.white,
            ),
            label: Text(
              'Finalizar agendamento de aula',
              style: TextStyle(
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.normal,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
