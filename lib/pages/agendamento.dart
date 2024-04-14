import 'dart:async';

import 'package:auth_screen/repositories/convidado_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:auth_screen/pages/turma.dart';

class Agendamento extends StatefulWidget {
  final String? idTurma;

  const Agendamento({Key? key, required this.idTurma}) : super(key: key);

  @override
  State<Agendamento> createState() => _AgendamentoState();
}

class _AgendamentoState extends State<Agendamento> {
  var opacity = 0.0;
  bool position = false;
  int _numberOfGuests = 0; // Número inicial de convidados
  final _repositorioConvidado = RepositorioConvidado(
    armazenamentoSeguro: FlutterSecureStorage(),
  );
  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 70),
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 400),
              top: position ? 1 : 50,
              left: 20,
              right: 20,
              child: upperRow(),
            ),
            AnimatedPositioned(
              top: position ? 60 : 120,
              right: 20,
              left: 20,
              duration: Duration(milliseconds: 300),
              child: addConvidados(),
            ),
            AnimatedPositioned(
              top: 200,
              right: 20,
              left: 20,
              duration: Duration(milliseconds: 400),
              child: AnimatedOpacity(
                opacity: opacity,
                duration: Duration(milliseconds: 400),
                child: Container(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Confirma o agendamento?',
                        style: TextStyle(
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'ok',
                        style: TextStyle(
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addConvidados() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: opacity,
      child: GestureDetector(
        onTap: () => _showBottomSheet(context),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            height: 110,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue.shade700,
                  Colors.blue.shade900,
                  Colors.blue.shade900,
                ],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 15,
                  left: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Chame seus amigos!",
                            style: TextStyle(
                              fontFamily: 'Helvetica',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Se tiver convidados, adicione o nome de\ncada um clicando aqui!",
                                style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget upperRow() {
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
          Text(
            "Agendamento de aula",
            style: TextStyle(
              fontFamily: 'Helvetica',
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Adicionar Convidado',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _numberOfGuests++;
                            });
                          },
                          child: Text('+ Convidado'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Column(
                      children: _buildGuestInputFields(context),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _onFinalizarPressed(context),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      child: Text('Finalizar',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  List<Widget> _buildGuestInputFields(BuildContext context) {
    List<Widget> fields = [];
    _controllers.clear();
    for (int i = 0; i < _numberOfGuests; i++) {
      _controllers.add(TextEditingController());
      fields.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            controller: _controllers[i],
            decoration: InputDecoration(
              hintText: 'Convidado(a) ${i + 1}',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
        ),
      );
    }
    return fields;
  }

  void _onFinalizarPressed(BuildContext context) async {
    List<String> nomesConvidados = _controllers
        .map((controller) => controller.text.trim())
        .where((nome) => nome.isNotEmpty)
        .toList();

    String? idUsuario =
        "1"; // Substitua "1" pelo ID do usuário logado ou obtenha de outra fonte
    if (idUsuario != null) {
      if (nomesConvidados.isNotEmpty) {
        List<Map<String, dynamic>> convidadosCriados =
            await _repositorioConvidado.salvarConvidados(
          nomesConvidados,
          idUsuario,
        );
        if (convidadosCriados.isNotEmpty) {
          for (var controller in _controllers) {
            controller.clear();
          }
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Convidados salvos com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao salvar os convidados.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Insira pelo menos um nome de convidado.'),
            backgroundColor: Colors.yellow,
          ),
        );
      }
      Navigator.pop(context); // Fechar o BottomSheet
    } else {
      // Tratar caso em que idUsuario é null
    }
  }
}
