import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kanoevaa/app_controller.dart';
import 'package:kanoevaa/constants.dart';
import 'package:kanoevaa/pages/login.dart';
import 'package:kanoevaa/pages/alunos/turma.dart';
import 'package:kanoevaa/repositories/agendamento_repository.dart';

class Agendamento extends StatefulWidget {
  final String? idTurma;

  const Agendamento({Key? key, required this.idTurma}) : super(key: key);

  @override
  State<Agendamento> createState() => _AgendamentoState();
}

class _AgendamentoState extends State<Agendamento> {
  late final FlutterSecureStorage _secureStorage;
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
    _secureStorage = FlutterSecureStorage();
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
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_left,
          color: kWhiteColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'Informações sobre a aula',
        style: TextStyle(
          fontSize: 16,
          color: kWhiteColor,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: kWhiteColor,
            ),
            onPressed: () async {
              if (_secureStorage != null) {
                await _secureStorage.delete(key: 'token');
                await _secureStorage.delete(key: 'aluno');

                await Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              }
            },
          ),
        ),
      ],
      backgroundColor: kSecondaryColor,
    );
  }

  Widget desagendar() {
    return Container(
      padding: EdgeInsets.all(14),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            "Deseja desagendar essa aula?",
            textAlign: TextAlign.left, // Alinha o texto à esquerda
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
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
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.red), // Cor de fundo vermelha
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8.0), // Diminuindo a borda
                ),
              ),
            ),
            child: Text(
              'Desagendar',
              style: TextStyle(
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.normal,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
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
